-- Generated schema for sod on 2025-07-03 22:04:36
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['sod'] = {
    messages = {
      PriestTalents = {
        fields = {
          unbreakable_will = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          wand_specialization = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          silent_resolve = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_power_word_fortitude = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_power_word_shield = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          martyrdom = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          inner_focus = {
            id = 7,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerInnerFocus",
                  spellId = 14751,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Inner Focus"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
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
                  Flags = "core.SpellFlagAPL",
                  ClassSpellMask = "ClassSpellMask_PriestInnerFocus"
                }
              }
            }
          },
          meditation = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          improved_inner_fire = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          mental_agility = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          improved_mana_burn = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          mental_strength = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          divine_spirit = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          force_of_will = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          power_infusion = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/power_infusion.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerPowerInfusionCD",
                  majorCooldown = {
                    type = "core.CooldownTypeMana",
                    priority = "core.CooldownPriorityBloodlust"
                  },
                  spellId = 10060,
                  cast = [[{
	// 		CD: core.Cooldown{
	// 			Timer:    priest.NewTimer(),
	// 			Duration: time.Duration(float64(core.PowerInfusionCD)),
	// 		},
	// 	}]],
                  cooldown = {
                    raw = "time.Duration(float64(core.PowerInfusionCD))",
                    seconds = nil
                  },
                  Flags = "SpellFlagPriest | core.SpellFlagHelpful"
                }
              }
            }
          },
          healing_focus = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          improved_renew = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          holy_specialization = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          spell_warding = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          divine_fury = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          holy_nova = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          blessed_recovery = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          inspiration = {
            id = 23,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyInspiration",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Inspiration Talent"
                }
              }
            }
          },
          holy_reach = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          improved_healing = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          searing_light = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          improved_prayer_of_healing = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          spirit_of_redemption = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          spiritual_guidance = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          spiritual_healing = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          lightwell = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          spirit_tap = {
            id = 32,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applySpiritTap",
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Spirit Tap"
                }
              }
            }
          },
          blackout = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          shadow_affinity = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_shadow_word_pain = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          shadow_focus = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_psychic_scream = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_mind_blast = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          mind_flay = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          improved_fade = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          shadow_reach = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          shadow_weaving = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          silence = {
            id = 43,
            type = "bool",
            label = "optional"
          },
          vampiric_embrace = {
            id = 44,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/vampiric_embrace.go",
                  registrationType = "RegisterAura",
                  functionName = "registerVampiricEmbraceSpell",
                  spellId = 15286,
                  auraDuration = {
                    raw = "duration",
                    seconds = nil
                  },
                  label = "Vampiric Embrace (Health) - "
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/vampiric_embrace.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerVampiricEmbraceSpell",
                  spellId = 15286,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                  Flags = "core.SpellFlagAPL",
                  ClassSpellMask = "ClassSpellMask_PriestVampiricEmbrace",
                  SpellSchool = "core.SpellSchoolShadow",
                  ProcMask = "core.ProcMaskEmpty"
                }
              }
            }
          },
          improved_vampiric_embrace = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          darkness = {
            id = 46,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDarkness",
                  label = "Darkness"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDarkness",
                  label = "Darkness"
                }
              }
            }
          },
          shadowform = {
            id = 47,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerShadowform",
                  spellId = 15473,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Shadowform"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerShadowform",
                  spellId = 15473,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Shadowform"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerShadowform",
                  spellId = 15473,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
		}]],
                  Flags = "core.SpellFlagAPL"
                }
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "unbreakable_will",
          "wand_specialization",
          "silent_resolve",
          "improved_power_word_fortitude",
          "improved_power_word_shield",
          "martyrdom",
          "inner_focus",
          "meditation",
          "improved_inner_fire",
          "mental_agility",
          "improved_mana_burn",
          "mental_strength",
          "divine_spirit",
          "force_of_will",
          "power_infusion",
          "healing_focus",
          "improved_renew",
          "holy_specialization",
          "spell_warding",
          "divine_fury",
          "holy_nova",
          "blessed_recovery",
          "inspiration",
          "holy_reach",
          "improved_healing",
          "searing_light",
          "improved_prayer_of_healing",
          "spirit_of_redemption",
          "spiritual_guidance",
          "spiritual_healing",
          "lightwell",
          "spirit_tap",
          "blackout",
          "shadow_affinity",
          "improved_shadow_word_pain",
          "shadow_focus",
          "improved_psychic_scream",
          "improved_mind_blast",
          "mind_flay",
          "improved_fade",
          "shadow_reach",
          "shadow_weaving",
          "silence",
          "vampiric_embrace",
          "improved_vampiric_embrace",
          "darkness",
          "shadowform"
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
      MiscConsumes = {
        fields = {
          bogling_root = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          elixir_of_coalesced_regret = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          catnip = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          juju_ember = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          juju_chill = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          juju_escape = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          juju_flurry = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          draught_of_the_sands = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          greater_mark_of_the_dawn = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          raptor_punch = {
            id = 10,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "bogling_root",
          "elixir_of_coalesced_regret",
          "catnip",
          "juju_ember",
          "juju_chill",
          "juju_escape",
          "juju_flurry",
          "draught_of_the_sands",
          "greater_mark_of_the_dawn",
          "raptor_punch"
        }
      },
      PetMiscConsumes = {
        fields = {
          juju_flurry = {
            id = 1,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "juju_flurry"
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
          blood_pact = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          strength_of_earth_totem = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          grace_of_air_totem = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          arcane_brilliance = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          divine_spirit = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          battle_shout = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          trueshot_aura = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          furious_howl = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          moonkin_aura = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          mana_spring_totem = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          blessing_of_wisdom = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          vampiric_touch = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          shadow_protection = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          shadow_resistance_aura = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          nature_resistance_totem = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          aspect_of_the_wild = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          frost_resistance_aura = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          frost_resistance_totem = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          fire_resistance_totem = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          fire_resistance_aura = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          scroll_of_protection = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          scroll_of_stamina = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          scroll_of_strength = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          scroll_of_agility = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          scroll_of_intellect = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          scroll_of_spirit = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          demonic_pact = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          horn_of_lordaeron = {
            id = 33,
            type = "bool",
            label = "optional"
          },
          aspect_of_the_lion = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          commanding_shout = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          thorns = {
            id = 22,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          devotion_aura = {
            id = 23,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          stoneskin_totem = {
            id = 24,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          retribution_aura = {
            id = 25,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          sanctity_aura = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          battle_squawk = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_stoneskin_windwall = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          resilience_of_the_dawn = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          atiesh_cast_speed_buff = {
            id = 44,
            type = "bool",
            label = "optional"
          },
          atiesh_healing_buff = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          atiesh_spell_crit_buff = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          atiesh_spell_power_buff = {
            id = 47,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "gift_of_the_wild",
          "power_word_fortitude",
          "blood_pact",
          "strength_of_earth_totem",
          "grace_of_air_totem",
          "arcane_brilliance",
          "divine_spirit",
          "battle_shout",
          "trueshot_aura",
          "furious_howl",
          "leader_of_the_pack",
          "moonkin_aura",
          "mana_spring_totem",
          "blessing_of_wisdom",
          "vampiric_touch",
          "shadow_protection",
          "shadow_resistance_aura",
          "nature_resistance_totem",
          "aspect_of_the_wild",
          "frost_resistance_aura",
          "frost_resistance_totem",
          "fire_resistance_totem",
          "fire_resistance_aura",
          "scroll_of_protection",
          "scroll_of_stamina",
          "scroll_of_strength",
          "scroll_of_agility",
          "scroll_of_intellect",
          "scroll_of_spirit",
          "demonic_pact",
          "horn_of_lordaeron",
          "aspect_of_the_lion",
          "commanding_shout",
          "thorns",
          "devotion_aura",
          "stoneskin_totem",
          "retribution_aura",
          "sanctity_aura",
          "battle_squawk",
          "improved_stoneskin_windwall",
          "resilience_of_the_dawn",
          "atiesh_cast_speed_buff",
          "atiesh_healing_buff",
          "atiesh_spell_crit_buff",
          "atiesh_spell_power_buff"
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
          mana_tide_totems = {
            id = 3,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "atiesh_mage",
          "atiesh_warlock",
          "mana_tide_totems"
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
          rallying_cry_of_the_dragonslayer = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          valor_of_azeroth = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          sayges_fortune = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "SaygesFortune"
          },
          spirit_of_zandalar = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          songflower_serenade = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          warchiefs_blessing = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          might_of_stormwind = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          fengus_ferocity = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          moldars_moxie = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          slipkiks_savvy = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          boon_of_blackfathom = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          ashenvale_pvp_buff = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          spark_of_inspiration = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          fervor_of_the_temple_explorer = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          spirit_of_the_alpha = {
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
          "innervates",
          "power_infusions",
          "rallying_cry_of_the_dragonslayer",
          "valor_of_azeroth",
          "sayges_fortune",
          "spirit_of_zandalar",
          "songflower_serenade",
          "warchiefs_blessing",
          "might_of_stormwind",
          "fengus_ferocity",
          "moldars_moxie",
          "slipkiks_savvy",
          "boon_of_blackfathom",
          "ashenvale_pvp_buff",
          "spark_of_inspiration",
          "fervor_of_the_temple_explorer",
          "spirit_of_the_alpha"
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
          judgement_of_the_crusader = {
            id = 33,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          faerie_fire = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          curse_of_elements = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          curse_of_shadow = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          mark_of_chaos = {
            id = 37,
            type = "bool",
            label = "optional"
          },
          occult_poison = {
            id = 38,
            type = "bool",
            label = "optional"
          },
          winters_chill = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          improved_shadow_bolt = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          improved_scorch = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          shadow_weaving = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          stormstrike = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          dreamstate = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          expose_armor = {
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
          homunculi = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          sebacious_poison = {
            id = 39,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          curse_of_weakness = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          curse_of_recklessness = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          demoralizing_roar = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          demoralizing_shout = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          atrophic_poison = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          thunder_clap = {
            id = 16,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          waylay = {
            id = 34,
            type = "bool",
            label = "optional"
          },
          thunderfury = {
            id = 40,
            type = "bool",
            label = "optional"
          },
          numbing_poison = {
            id = 43,
            type = "bool",
            label = "optional"
          },
          insect_swarm = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          scorpid_sting = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          vampiric_embrace = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          hunters_mark = {
            id = 20,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          mangle = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          gift_of_arthas = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          holy_sunder = {
            id = 44,
            type = "bool",
            label = "optional"
          },
          curse_of_vulnerability = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          mekkatorque_fist_debuff = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          serpents_striker_fist_debuff = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          improved_faerie_fire = {
            id = 36,
            type = "bool",
            label = "optional"
          },
          melee_hunter_dodge_debuff = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          frost_fever = {
            id = 45,
            type = "bool",
            label = "optional"
          },
          blood_plague = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          curse_of_elements_new = {
            id = 31,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          curse_of_shadow_new = {
            id = 32,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          }
        },
        oneofs = {

        },
        field_order = {
          "judgement_of_wisdom",
          "judgement_of_light",
          "judgement_of_the_crusader",
          "faerie_fire",
          "curse_of_elements",
          "curse_of_shadow",
          "mark_of_chaos",
          "occult_poison",
          "winters_chill",
          "improved_shadow_bolt",
          "improved_scorch",
          "shadow_weaving",
          "stormstrike",
          "dreamstate",
          "expose_armor",
          "sunder_armor",
          "homunculi",
          "sebacious_poison",
          "curse_of_weakness",
          "curse_of_recklessness",
          "demoralizing_roar",
          "demoralizing_shout",
          "atrophic_poison",
          "thunder_clap",
          "waylay",
          "thunderfury",
          "numbing_poison",
          "insect_swarm",
          "scorpid_sting",
          "vampiric_embrace",
          "hunters_mark",
          "mangle",
          "gift_of_arthas",
          "holy_sunder",
          "curse_of_vulnerability",
          "mekkatorque_fist_debuff",
          "serpents_striker_fist_debuff",
          "improved_faerie_fire",
          "melee_hunter_dodge_debuff",
          "frost_fever",
          "blood_plague",
          "curse_of_elements_new",
          "curse_of_shadow_new"
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
          },
          enchant_id_list = {
            id = 4,
            type = "int32",
            label = "repeated"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "stats",
          "enchant_id_list"
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
          rune = {
            id = 5,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "random_suffix",
          "enchant",
          "rune"
        }
      },
      SimItem = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          requires_level = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          class_allowlist = {
            id = 17,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
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
          spell_school = {
            id = 23,
            type = "enum",
            label = "optional",
            enum_type = "SpellSchool"
          },
          bonus_physical_damage = {
            id = 20,
            type = "double",
            label = "optional"
          },
          bonus_periodic_pct = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          set_name = {
            id = 14,
            type = "string",
            label = "optional"
          },
          set_id = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          weapon_skills = {
            id = 15,
            type = "double",
            label = "repeated"
          },
          timeworn = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          sanctified = {
            id = 21,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "requires_level",
          "class_allowlist",
          "name",
          "type",
          "armor_type",
          "weapon_type",
          "hand_type",
          "ranged_weapon_type",
          "stats",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "spell_school",
          "bonus_physical_damage",
          "bonus_periodic_pct",
          "set_name",
          "set_id",
          "weapon_skills",
          "timeworn",
          "sanctified"
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
      SimRune = {
        fields = {
          id = {
            id = 1,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "id"
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
          },
          rank = {
            id = 5,
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
          "tag",
          "rank"
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
          runes = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "SimRune"
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "random_suffixes",
          "enchants",
          "runes"
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
            id = 1,
            type = "int32",
            label = "optional"
          },
          name = {
            id = 2,
            type = "string",
            label = "optional"
          },
          level = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          mob_type = {
            id = 4,
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
            id = 6,
            type = "double",
            label = "optional"
          },
          damage_spread = {
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
          parry_haste = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          spell_school = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "SpellSchool"
          },
          tank_index = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          target_inputs = {
            id = 14,
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
          "spell_school",
          "tank_index",
          "target_inputs"
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
          food = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Food"
          },
          agility_elixir = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "AgilityElixir"
          },
          mana_regen_elixir = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "ManaRegenElixir"
          },
          strength_buff = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "StrengthBuff"
          },
          attack_power_buff = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "AttackPowerBuff"
          },
          spell_power_buff = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "SpellPowerBuff"
          },
          shadow_power_buff = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "ShadowPowerBuff"
          },
          fire_power_buff = {
            id = 11,
            type = "enum",
            label = "optional",
            enum_type = "FirePowerBuff"
          },
          frost_power_buff = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "FrostPowerBuff"
          },
          sapper_explosive = {
            id = 34,
            type = "enum",
            label = "optional",
            enum_type = "SapperExplosive"
          },
          filler_explosive = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "Explosive"
          },
          main_hand_imbue = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          off_hand_imbue = {
            id = 16,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          default_potion = {
            id = 17,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          default_conjured = {
            id = 18,
            type = "enum",
            label = "optional",
            enum_type = "Conjured"
          },
          enchanted_sigil = {
            id = 20,
            type = "enum",
            label = "optional",
            enum_type = "EnchantedSigil"
          },
          mildly_irradiated_rejuv_pot = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          pet_agility_consumable = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          pet_strength_consumable = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          pet_attack_power_consumable = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          pet_misc_consumes = {
            id = 33,
            type = "message",
            label = "optional",
            message_type = "PetMiscConsumes"
          },
          dragon_breath_chili = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          misc_consumes = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "MiscConsumes"
          },
          seal_of_the_dawn = {
            id = 35,
            type = "enum",
            label = "optional",
            enum_type = "SealOfTheDawn"
          },
          zanza_buff = {
            id = 27,
            type = "enum",
            label = "optional",
            enum_type = "ZanzaBuff"
          },
          armor_elixir = {
            id = 28,
            type = "enum",
            label = "optional",
            enum_type = "ArmorElixir"
          },
          health_elixir = {
            id = 29,
            type = "enum",
            label = "optional",
            enum_type = "HealthElixir"
          },
          alcohol = {
            id = 30,
            type = "enum",
            label = "optional",
            enum_type = "Alcohol"
          },
          mage_scroll = {
            id = 32,
            type = "enum",
            label = "optional",
            enum_type = "MageScroll"
          }
        },
        oneofs = {

        },
        field_order = {
          "flask",
          "food",
          "agility_elixir",
          "mana_regen_elixir",
          "strength_buff",
          "attack_power_buff",
          "spell_power_buff",
          "shadow_power_buff",
          "fire_power_buff",
          "frost_power_buff",
          "sapper_explosive",
          "filler_explosive",
          "main_hand_imbue",
          "off_hand_imbue",
          "default_potion",
          "default_conjured",
          "enchanted_sigil",
          "mildly_irradiated_rejuv_pot",
          "pet_agility_consumable",
          "pet_strength_consumable",
          "pet_attack_power_consumable",
          "pet_misc_consumes",
          "dragon_breath_chili",
          "misc_consumes",
          "seal_of_the_dawn",
          "zanza_buff",
          "armor_elixir",
          "health_elixir",
          "alcohol",
          "mage_scroll"
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
            type = "string",
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
      APLActionAddComboPoints = {
        fields = {
          num_points = {
            id = 2,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "num_points"
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
          min_combos_for_rip = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          max_wait_time = {
            id = 2,
            type = "float",
            label = "optional"
          },
          maintain_faerie_fire = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          use_shred_trick = {
            id = 4,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "min_combos_for_rip",
          "max_wait_time",
          "maintain_faerie_fire",
          "use_shred_trick"
        }
      },
      APLActionCastPaladinPrimarySeal = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLActionPaladinCastWithMacro = {
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
          macro = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "Macro"
          }
        },
        oneofs = {

        },
        field_order = {
          "spell_id",
          "target",
          "macro"
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
      APLValueTargetMobType = {
        fields = {
          mob_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "MobType"
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
          "mob_type",
          "target"
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
      APLValueMaxEnergy = {
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
      APLValueTimeToEnergyTick = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueEnergyThreshold = {
        fields = {
          threshold = {
            id = 1,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "threshold"
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
          auto_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "AttackType"
          }
        },
        oneofs = {

        },
        field_order = {
          "auto_type"
        }
      },
      APLValueAutoSwingTime = {
        fields = {
          auto_type = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "SwingType"
          }
        },
        oneofs = {

        },
        field_order = {
          "auto_type"
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
      APLValueSpellInFlight = {
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
      APLValueRuneIsEquipped = {
        fields = {
          rune_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          }
        },
        oneofs = {

        },
        field_order = {
          "rune_id"
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
      APLValueWarlockCurrentPetMana = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueWarlockCurrentPetManaPercent = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueWarlockPetIsActive = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueHunterPetIsActive = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueHunterCurrentPetFocus = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueHunterCurrentPetFocusPercent = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCurrentSealRemainingTime = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueCatEnergyAfterDuration = {
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
          instant_interrupt = {
            id = 4,
            type = "bool",
            label = "optional"
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
          "instant_interrupt",
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
          target_mob_type = {
            id = 75,
            type = "message",
            label = "optional",
            message_type = "APLValueTargetMobType",
            uiLabel = "Target Mob Type",
            submenu = {
              "Encounter"
            },
            shortDescription = "|cffffcc00True|r if the selected target is of the specified mob type, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "target",
                configType = "unit"
              },
              {
                field = "mobType",
                configType = "targetMobType"
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() !== Class.ClassRogue && player.getClass() !== Class.ClassWarrior",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() !== Class.ClassRogue && player.getClass() !== Class.ClassWarrior",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarrior || player.getClass() === Class.ClassDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassRogue || player.getClass() === Class.ClassDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          max_energy = {
            id = 77,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxEnergy",
            uiLabel = "Max Energy",
            submenu = {
              "Resources",
              "Energy"
            },
            shortDescription = "Amount of maximum available Energy.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassRogue || player.getClass() === Class.ClassDruid",
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassRogue || player.getClass() === Class.ClassDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          time_to_energy_tick = {
            id = 66,
            type = "message",
            label = "optional",
            message_type = "APLValueTimeToEnergyTick",
            uiLabel = "Time to Next Energy Tick",
            submenu = {
              "Resources"
            },
            shortDescription = "Time until the next energy regen tick will happen",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassRogue || player.getClass() === Class.ClassDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          energy_threshold = {
            id = 73,
            type = "message",
            label = "optional",
            message_type = "APLValueEnergyThreshold",
            uiLabel = "Energy Threshold",
            submenu = {
              "Resources"
            },
            shortDescription = "Compares current energy to a threshold value.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassRogue || player.getClass() === Class.ClassDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "threshold",
                configType = "number",
                label = ">=",
                labelTooltip = "Energy threshold. Subtracted from maximum energy if negative."
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
              {
                field = "autoType",
                configType = "autoType"
              }
            }
          },
          auto_swing_time = {
            id = 64,
            type = "message",
            label = "optional",
            message_type = "APLValueAutoSwingTime",
            uiLabel = "Auto Swing Time",
            submenu = {
              "Auto"
            },
            shortDescription = "Total swing duration including all haste buffs.",
            fields = {
              {
                field = "autoType",
                configType = "autoSwingType"
              }
            }
          },
          spell_is_known = {
            id = 68,
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
          spell_in_flight = {
            id = 74,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellInFlight",
            uiLabel = "In Flight",
            submenu = {
              "Spell"
            },
            shortDescription = "|cffffcc00True|r if the spell has a missile in flight, otherwise |cffffcc00False|r.",
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
            id = 67,
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
          rune_is_equipped = {
            id = 69,
            type = "message",
            label = "optional",
            message_type = "APLValueRuneIsEquipped",
            uiLabel = "Rune Equipped",
            submenu = {
              "Rune"
            },
            shortDescription = "|cffffcc00True|r if the rune is currently equipped, otherwise |cffffcc00False|r.",
            fields = {
              {
                field = "runeId",
                configType = "rune"
              }
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassShaman",
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec === Spec.SpecFeralDruid",
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec === Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          cat_energy_after_duration = {
            id = 76,
            type = "message",
            label = "optional",
            message_type = "APLValueCatEnergyAfterDuration",
            uiLabel = "Energy After Duration",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Returns the |cffffcc00total uncapped|r amount of energy after the given duration. This will include Staff of the Glade timing and the Scarlet 2 piece bonus.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec === Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "condition",
                configType = "value"
              }
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarlock",
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarlock",
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
          warlock_current_pet_mana = {
            id = 70,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockCurrentPetMana",
            uiLabel = "Pet Mana",
            submenu = {
              "Warlock"
            },
            shortDescription = "Amount of currently available pet mana.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          warlock_current_pet_mana_percent = {
            id = 71,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockCurrentPetManaPercent",
            uiLabel = "Pet Mana (%)",
            submenu = {
              "Warlock"
            },
            shortDescription = "Amount of currently available pet mana, as a percentage.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          warlock_pet_is_active = {
            id = 72,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockPetIsActive",
            uiLabel = "Pet is Active",
            submenu = {
              "Warlock"
            },
            shortDescription = "Returns |cffffcc00True|r if the Warlock has a pet active.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          current_seal_remaining_time = {
            id = 65,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentSealRemainingTime",
            uiLabel = "Current Seal Remaining Time",
            submenu = {
              "Paladin"
            },
            shortDescription = "Returns the amount of time remaining until the Paladin's current Seal aura will expire.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassPaladin",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          hunter_current_pet_focus = {
            id = 80,
            type = "message",
            label = "optional",
            message_type = "APLValueHunterCurrentPetFocus",
            uiLabel = "Pet Focus",
            submenu = {
              "Hunter"
            },
            shortDescription = "Amount of currently available pet focus.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          hunter_current_pet_focus_percent = {
            id = 81,
            type = "message",
            label = "optional",
            message_type = "APLValueHunterCurrentPetFocusPercent",
            uiLabel = "Pet Focus (%)",
            submenu = {
              "Hunter"
            },
            shortDescription = "Amount of currently available pet focus, as a percentage.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassHunter",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          hunter_pet_is_active = {
            id = 82,
            type = "message",
            label = "optional",
            message_type = "APLValueHunterPetIsActive",
            uiLabel = "Pet is Active",
            submenu = {
              "Hunter"
            },
            shortDescription = "Returns |cffffcc00True|r if the Hunter has a pet active.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassHunter",
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
            "target_mob_type",
            "current_health",
            "current_health_percent",
            "current_mana",
            "current_mana_percent",
            "current_rage",
            "current_energy",
            "max_energy",
            "current_combo_points",
            "time_to_energy_tick",
            "energy_threshold",
            "gcd_is_ready",
            "gcd_time_to_ready",
            "auto_time_to_next",
            "auto_swing_time",
            "spell_is_known",
            "spell_can_cast",
            "spell_is_ready",
            "spell_time_to_ready",
            "spell_cast_time",
            "spell_travel_time",
            "spell_in_flight",
            "spell_cpm",
            "spell_is_channeling",
            "spell_channeled_ticks",
            "spell_current_cost",
            "aura_is_known",
            "aura_is_active",
            "aura_is_active_with_reaction_time",
            "aura_remaining_time",
            "aura_num_stacks",
            "aura_internal_cooldown",
            "aura_icd_is_ready_with_reaction_time",
            "aura_should_refresh",
            "rune_is_equipped",
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
            "cat_energy_after_duration",
            "warlock_should_recast_drain_soul",
            "warlock_should_refresh_corruption",
            "warlock_current_pet_mana",
            "warlock_current_pet_mana_percent",
            "warlock_pet_is_active",
            "current_seal_remaining_time",
            "hunter_current_pet_focus",
            "hunter_current_pet_focus_percent",
            "hunter_pet_is_active"
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
          "target_mob_type",
          "current_health",
          "current_health_percent",
          "current_mana",
          "current_mana_percent",
          "current_rage",
          "current_energy",
          "max_energy",
          "current_combo_points",
          "time_to_energy_tick",
          "energy_threshold",
          "gcd_is_ready",
          "gcd_time_to_ready",
          "auto_time_to_next",
          "auto_swing_time",
          "spell_is_known",
          "spell_can_cast",
          "spell_is_ready",
          "spell_time_to_ready",
          "spell_cast_time",
          "spell_travel_time",
          "spell_in_flight",
          "spell_cpm",
          "spell_is_channeling",
          "spell_channeled_ticks",
          "spell_current_cost",
          "aura_is_known",
          "aura_is_active",
          "aura_is_active_with_reaction_time",
          "aura_remaining_time",
          "aura_num_stacks",
          "aura_internal_cooldown",
          "aura_icd_is_ready_with_reaction_time",
          "aura_should_refresh",
          "rune_is_equipped",
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
          "cat_energy_after_duration",
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption",
          "warlock_current_pet_mana",
          "warlock_current_pet_mana_percent",
          "warlock_pet_is_active",
          "current_seal_remaining_time",
          "hunter_current_pet_focus",
          "hunter_current_pet_focus_percent",
          "hunter_pet_is_active"
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

			The channel will be interrupted only if Instant Interrupt is true OR all of the following are true:

			
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
                field = "instantInterrupt",
                configType = "boolean",
                labelTooltip = "If checked, interrupts of this channel will happen instantly after the cast."
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
          activate_aura_with_stacks = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "APLActionActivateAuraWithStacks",
            uiLabel = "Activate Aura With Stacks",
            submenu = {
              "Misc"
            },
            shortDescription = "Activates an aura with the specified number of stacks",
            includeIf = "(player: Player<any>, isPrepull: boolean) => isPrepull",
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
                configType = "string",
                label = "stacks",
                labelTooltip = "Desired number of initial aura stacks.",
                default = "1"
              }
            },
            defaults = {
              numStacks = "1"
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => itemSwapEnabledSpecs.includes(player.spec)",
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
            id = 18,
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
          add_combo_points = {
            id = 23,
            type = "message",
            label = "optional",
            message_type = "APLActionAddComboPoints",
            uiLabel = "Add Combo Points",
            submenu = {
              "Misc"
            },
            shortDescription = "Add combo points to target.",
            includeIf = "(player: Player<any>, isPrepull: boolean) => isPrepull",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = false,
            fields = {
              {
                field = "numPoints",
                configType = "string",
                labelTooltip = "Desired number of initial combo points.",
                default = "1"
              }
            },
            defaults = {
              numPoints = "1"
            }
          },
          cat_optimal_rotation_action = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "APLActionCatOptimalRotationAction",
            uiLabel = "Optimal Rotation Action",
            submenu = {
              "Feral Druid"
            },
            shortDescription = "Executes optimized Feral DPS rotation using hardcoded legacy algorithm.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec == Spec.SpecFeralDruid",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {
              {
                field = "minCombosForRip",
                configType = "number",
                label = "Min Rip CP",
                labelTooltip = "Combo Point threshold for allowing a Rip cast",
                default = 3
              },
              {
                field = "maxWaitTime",
                configType = "number",
                label = "Max Wait Time",
                labelTooltip = "Max seconds to wait for an Energy tick to cast rather than powershifting",
                default = 2.0
              },
              {
                field = "maintainFaerieFire",
                configType = "boolean",
                labelTooltip = "If checked, bundle Faerie Fire refreshes with powershifts. Ignored if an external Faerie Fire debuff is selected in settings.",
                default = false
              },
              {
                field = "useShredTrick",
                configType = "boolean",
                labelTooltip = "If checked, enable the",
                default = false
              }
            },
            defaults = {
              minCombosForRip = 3,
              maxWaitTime = 2.0,
              maintainFaerieFire = false,
              useShredTrick = false
            }
          },
          cast_paladin_primary_seal = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "APLActionCastPaladinPrimarySeal",
            uiLabel = "Cast Primary Seal",
            submenu = {
              "Paladin"
            },
            shortDescription = "Casts the Paladin's designated primary seal spell.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec == Spec.SpecRetributionPaladin || player.spec == Spec.SpecProtectionPaladin",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            },
            defaults = "APLActionCastPaladinPrimarySeal.create({})"
          },
          paladin_cast_with_macro = {
            id = 24,
            type = "message",
            label = "optional",
            message_type = "APLActionPaladinCastWithMacro",
            uiLabel = "Cast",
            submenu = {
              "Paladin"
            },
            shortDescription = "Casts the specified spell, followed by the selected macro.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.spec == Spec.SpecRetributionPaladin",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
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
                field = "macro",
                configType = "castWithMacro"
              }
            }
          },
          custom_rotation = {
            id = 20,
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
            "activate_aura_with_stacks",
            "cancel_aura",
            "trigger_icd",
            "item_swap",
            "move",
            "add_combo_points",
            "cat_optimal_rotation_action",
            "cast_paladin_primary_seal",
            "paladin_cast_with_macro",
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
          "activate_aura_with_stacks",
          "cancel_aura",
          "trigger_icd",
          "item_swap",
          "move",
          "add_combo_points",
          "cat_optimal_rotation_action",
          "cast_paladin_primary_seal",
          "paladin_cast_with_macro",
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
          tactical_mastery = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_thunder_clap = {
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
          deep_wounds = {
            id = 9,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/deep_wounds.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDeepWounds",
                  label = "Deep Wounds Talent"
                }
              }
            }
          },
          two_handed_weapon_specialization = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          impale = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          axe_specialization = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          sweeping_strikes = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/sweeping_strikes.go",
                  registrationType = "RegisterAura",
                  functionName = "registerSweepingStrikesCD",
                  spellId = 12292,
                  auraDuration = {
                    raw = "time.Second * 10",
                    seconds = 10
                  },
                  label = "Sweeping Strikes"
                }
              }
            }
          },
          mace_specialization = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          sword_specialization = {
            id = 15,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerSwordSpecialization",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Sword Specialization"
                }
              }
            }
          },
          polearm_specialization = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          improved_hamstring = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          mortal_strike = {
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
            id = 21,
            type = "int32",
            label = "optional"
          },
          unbridled_wrath = {
            id = 22,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyUnbridledWrath",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Unbridled Wrath"
                }
              }
            }
          },
          improved_cleave = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          piercing_howl = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          blood_craze = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          improved_battle_shout = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          improved_execute = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          enrage = {
            id = 29,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyEnrage",
                  spellId = 13048,
                  auraDuration = {
                    raw = "time.Second * 12",
                    seconds = 12
                  },
                  label = "Enrage"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyEnrage",
                  spellId = 13048,
                  auraDuration = {
                    raw = "time.Second * 12",
                    seconds = 12
                  },
                  label = "Enrage"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyEnrage",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Enrage Trigger"
                }
              }
            }
          },
          improved_slam = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          death_wish = {
            id = 31,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerDeathWishCD",
                  spellId = 12328,
                  auraDuration = {
                    raw = "time.Second * 30",
                    seconds = 30
                  },
                  label = "Death Wish"
                }
              }
            }
          },
          improved_intercept = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          improved_berserker_rage = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 34,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  spellId = 12974,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry Proc"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  label = "Flurry Proc Trigger"
                }
              }
            }
          },
          bloodthirst = {
            id = 35,
            type = "bool",
            label = "optional"
          },
          shield_specialization = {
            id = 36,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyShieldSpecialization",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Shield Specialization"
                }
              }
            }
          },
          anticipation = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          improved_bloodrage = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          iron_will = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          last_stand = {
            id = 41,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
            }
          },
          improved_shield_block = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          improved_revenge = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          defiance = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          improved_sunder_armor = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          improved_disarm = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          improved_taunt = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          improved_shield_wall = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          concussion_blow = {
            id = 49,
            type = "bool",
            label = "optional"
          },
          improved_shield_bash = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 51,
            type = "int32",
            label = "optional"
          },
          shield_slam = {
            id = 52,
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
          "tactical_mastery",
          "improved_thunder_clap",
          "improved_overpower",
          "anger_management",
          "deep_wounds",
          "two_handed_weapon_specialization",
          "impale",
          "axe_specialization",
          "sweeping_strikes",
          "mace_specialization",
          "sword_specialization",
          "polearm_specialization",
          "improved_hamstring",
          "mortal_strike",
          "booming_voice",
          "cruelty",
          "improved_demoralizing_shout",
          "unbridled_wrath",
          "improved_cleave",
          "piercing_howl",
          "blood_craze",
          "improved_battle_shout",
          "dual_wield_specialization",
          "improved_execute",
          "enrage",
          "improved_slam",
          "death_wish",
          "improved_intercept",
          "improved_berserker_rage",
          "flurry",
          "bloodthirst",
          "shield_specialization",
          "anticipation",
          "improved_bloodrage",
          "toughness",
          "iron_will",
          "last_stand",
          "improved_shield_block",
          "improved_revenge",
          "defiance",
          "improved_sunder_armor",
          "improved_disarm",
          "improved_taunt",
          "improved_shield_wall",
          "concussion_blow",
          "improved_shield_bash",
          "one_handed_weapon_specialization",
          "shield_slam"
        }
      },
      TankWarrior = {
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
          improved_arcane_missiles = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          wand_specialization = {
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
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyArcaneConcentration",
                  spellId = 12577,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Clearcasting"
                }
              }
            }
          },
          magic_attunement = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          improved_arcane_explosion = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          arcane_resilience = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          improved_mana_shield = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          improved_counterspell = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          arcane_meditation = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          presence_of_mind = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerPresenceOfMindCD",
                  spellId = 12043,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Presence of Mind"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
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
                  }
                }
              }
            }
          },
          arcane_mind = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          arcane_instability = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          arcane_power = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerArcanePowerCD",
                  spellId = 12042,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Arcane Power"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerArcanePowerCD",
                  spellId = 12042,
                  cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 180,
			},
		}]],
                  cooldown = {
                    raw = "time.Second * 180",
                    seconds = 180
                  },
                  ClassSpellMask = "ClassSpellMask_MageArcanePower",
                  RelatedSelfBuff = "buffAura"
                }
              }
            }
          },
          improved_fireball = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          impact = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          ignite = {
            id = 19,
            type = "int32",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyIgnite",
                  spellId = 12654,
                  cast = [[{
			IgnoreHaste: true,
		}]],
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                  ClassSpellMask = "ClassSpellMask_MageIgnite",
                  SpellSchool = "core.SpellSchoolFire",
                  ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1",
                  IgnoreHaste = "true",
                  label = "Ignite"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyIgnite",
                  spellId = 12654,
                  cast = [[{
			IgnoreHaste: true,
		}]],
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
                  ClassSpellMask = "ClassSpellMask_MageIgnite",
                  SpellSchool = "core.SpellSchoolFire",
                  ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1",
                  IgnoreHaste = "true",
                  label = "Ignite"
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
                  registrationType = "RegisterAura",
                  functionName = "applyIgnite",
                  label = "Ignite Trigger"
                }
              }
            }
          },
          flame_throwing = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_fire_blast = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          incinerate = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          improved_flamestrike = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          pyroblast = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          burning_soul = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          improved_scorch = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          improved_fire_ward = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          master_of_elements = {
            id = 28,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMasterOfElements",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Master of Elements"
                }
              }
            }
          },
          critical_mass = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          blast_wave = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          fire_power = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          combustion = {
            id = 32,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerCombustionCD",
                  spellId = 11129,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Combustion"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerCombustionCD",
                  spellId = 11129,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Combustion"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerCombustionCD",
                  majorCooldown = {
                    type = "core.CooldownTypeDPS",
                    priority = nil
                  },
                  spellId = 11129,
                  cast = [[{
			CD: cd,
		}]]
                }
              }
            }
          },
          frost_warding = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          improved_frostbolt = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          elemental_precision = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          ice_shards = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          frostbite = {
            id = 37,
            type = "int32",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyFrostbite",
                  spellId = 12494,
                  Flags = "core.SpellFlagPassiveSpell",
                  ClassSpellMask = "ClassSpellMask_MageFrostbite",
                  SpellSchool = "core.SpellSchoolFrost",
                  ProcMask = "core.ProcMaskSpellProc"
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFrostbite",
                  label = "Frostbite Trigger"
                }
              }
            }
          },
          improved_frost_nova = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          permafrost = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          piercing_ice = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          cold_snap = {
            id = 41,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerColdSnapCD",
                  majorCooldown = {
                    type = "core.CooldownTypeDPS",
                    priority = nil
                  },
                  spellId = 12472,
                  cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Duration(time.Minute * 5),
			},
		}]],
                  cooldown = {
                    raw = "time.Duration(time.Minute * 5)",
                    seconds = nil
                  }
                }
              }
            }
          },
          improved_blizzard = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          arctic_reach = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          frost_channeling = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          shatter = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          ice_block = {
            id = 46,
            type = "bool",
            label = "optional"
          },
          improved_cone_of_cold = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          winters_chill = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          ice_barrier = {
            id = 49,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "arcane_subtlety",
          "arcane_focus",
          "improved_arcane_missiles",
          "wand_specialization",
          "magic_absorption",
          "arcane_concentration",
          "magic_attunement",
          "improved_arcane_explosion",
          "arcane_resilience",
          "improved_mana_shield",
          "improved_counterspell",
          "arcane_meditation",
          "presence_of_mind",
          "arcane_mind",
          "arcane_instability",
          "arcane_power",
          "improved_fireball",
          "impact",
          "ignite",
          "flame_throwing",
          "improved_fire_blast",
          "incinerate",
          "improved_flamestrike",
          "pyroblast",
          "burning_soul",
          "improved_scorch",
          "improved_fire_ward",
          "master_of_elements",
          "critical_mass",
          "blast_wave",
          "fire_power",
          "combustion",
          "frost_warding",
          "improved_frostbolt",
          "elemental_precision",
          "ice_shards",
          "frostbite",
          "improved_frost_nova",
          "permafrost",
          "piercing_ice",
          "cold_snap",
          "improved_blizzard",
          "arctic_reach",
          "frost_channeling",
          "shatter",
          "ice_block",
          "improved_cone_of_cold",
          "winters_chill",
          "ice_barrier"
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
            label = "optional"
          },
          endurance_training = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          improved_eyes_of_the_beast = {
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
          bestial_swiftness = {
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
          frenzy = {
            id = 15,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFrenzy",
                  spellId = 19625,
                  auraDuration = {
                    raw = "time.Second * 8",
                    seconds = 8
                  },
                  label = "Frenzy Proc"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFrenzy",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Frenzy"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFrenzy",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Frenzy"
                }
              }
            }
          },
          bestial_wrath = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerBestialWrathCD",
                  spellId = 19574,
                  auraDuration = {
                    raw = "time.Second * 18",
                    seconds = 18
                  },
                  label = "Bestial Wrath Pet"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
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
				Duration: time.Minute * 2,
			},
		}]],
                  cooldown = {
                    raw = "time.Minute * 2",
                    seconds = 120
                  },
                  Flags = "core.SpellFlagAPL"
                }
              }
            }
          },
          improved_concussive_shot = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          efficiency = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_hunters_mark = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          lethal_shots = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          aimed_shot = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          improved_arcane_shot = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          hawk_eye = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          improved_serpent_sting = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          mortal_shots = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          scatter_shot = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          barrage = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          improved_scorpid_sting = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          ranged_weapon_specialization = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          trueshot_aura = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          monster_slaying = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          humanoid_slaying = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          entrapment = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          savage_strikes = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          improved_wing_clip = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          clever_traps = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          survivalist = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          deterrence = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          trap_mastery = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          surefooted = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          improved_feign_death = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          killer_instinct = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          counterattack = {
            id = 44,
            type = "bool",
            label = "optional"
          },
          lightning_reflexes = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          wyvern_sting = {
            id = 46,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_aspect_of_the_hawk",
          "endurance_training",
          "improved_eyes_of_the_beast",
          "improved_aspect_of_the_monkey",
          "thick_hide",
          "improved_revive_pet",
          "pathfinding",
          "bestial_swiftness",
          "unleashed_fury",
          "improved_mend_pet",
          "ferocity",
          "spirit_bond",
          "intimidation",
          "bestial_discipline",
          "frenzy",
          "bestial_wrath",
          "improved_concussive_shot",
          "efficiency",
          "improved_hunters_mark",
          "lethal_shots",
          "aimed_shot",
          "improved_arcane_shot",
          "hawk_eye",
          "improved_serpent_sting",
          "mortal_shots",
          "scatter_shot",
          "barrage",
          "improved_scorpid_sting",
          "ranged_weapon_specialization",
          "trueshot_aura",
          "monster_slaying",
          "humanoid_slaying",
          "deflection",
          "entrapment",
          "savage_strikes",
          "improved_wing_clip",
          "clever_traps",
          "survivalist",
          "deterrence",
          "trap_mastery",
          "surefooted",
          "improved_feign_death",
          "killer_instinct",
          "counterattack",
          "lightning_reflexes",
          "wyvern_sting"
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
            label = "optional"
          },
          spiked_collar = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          culling_the_herd = {
            id = 9,
            type = "int32",
            label = "optional"
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
            label = "optional"
          },
          lick_your_wounds = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          call_of_the_wild = {
            id = 27,
            type = "bool",
            label = "optional"
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
            id = 2,
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
          improved_wrath = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          natures_grasp = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          improved_natures_grasp = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_entangling_roots = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_moonfire = {
            id = 5,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyImprovedMoonfire",
                  label = "Improved moonfire"
                }
              }
            }
          },
          natural_weapons = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          natural_shapeshifter = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          improved_thorns = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          omen_of_clarity = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyOmenOfClarity",
                  spellId = 16870,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Clearcasting"
                }
              }
            }
          },
          natures_reach = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          vengeance = {
            id = 11,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  label = "Vengeance"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  label = "Vengeance"
                }
              }
            }
          },
          improved_starfire = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          natures_grace = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyNaturesGrace",
                  spellId = 16886,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Natures Grace Proc"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyNaturesGrace",
                  label = "Natures Grace"
                }
              }
            }
          },
          moonglow = {
            id = 14,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonglow",
                  label = "Moonglow"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonglow",
                  label = "Moonglow"
                }
              }
            }
          },
          moonfury = {
            id = 15,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonfury",
                  label = "Moonfury"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonfury",
                  label = "Moonfury"
                }
              }
            }
          },
          moonkin_form = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/forms.go",
                  registrationType = "RegisterAura",
                  functionName = "registerMoonkinFormSpell",
                  spellId = 24858,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Moonkin Form"
                }
              }
            }
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
            id = 19,
            type = "int32",
            label = "optional"
          },
          brutal_impact = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          thick_hide = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          feline_swiftness = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          feral_charge = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          sharpened_claws = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          improved_shred = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          predatory_strikes = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          blood_frenzy = {
            id = 27,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyBloodFrenzy",
                  label = "Blood Frenzy"
                }
              }
            }
          },
          primal_fury = {
            id = 28,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyPrimalFury",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Primal Fury"
                }
              }
            }
          },
          savage_fury = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          faerie_fire_feral = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          heart_of_the_wild = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          improved_mark_of_the_wild = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          furor = {
            id = 34,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFuror",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Furor"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFuror",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Furor"
                }
              }
            }
          },
          improved_healing_touch = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          natures_focus = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          improved_enrage = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          reflection = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          insect_swarm = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          subtlety = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          tranquil_spirit = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          improved_rejuvenation = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 43,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
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
            }
          },
          gift_of_nature = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          improved_tranquility = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          improved_regrowth = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          swiftmend = {
            id = 47,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "improved_wrath",
          "natures_grasp",
          "improved_natures_grasp",
          "improved_entangling_roots",
          "improved_moonfire",
          "natural_weapons",
          "natural_shapeshifter",
          "improved_thorns",
          "omen_of_clarity",
          "natures_reach",
          "vengeance",
          "improved_starfire",
          "natures_grace",
          "moonglow",
          "moonfury",
          "moonkin_form",
          "ferocity",
          "feral_aggression",
          "feral_instinct",
          "brutal_impact",
          "thick_hide",
          "feline_swiftness",
          "feral_charge",
          "sharpened_claws",
          "improved_shred",
          "predatory_strikes",
          "blood_frenzy",
          "primal_fury",
          "savage_fury",
          "faerie_fire_feral",
          "heart_of_the_wild",
          "leader_of_the_pack",
          "improved_mark_of_the_wild",
          "furor",
          "improved_healing_touch",
          "natures_focus",
          "improved_enrage",
          "reflection",
          "insect_swarm",
          "subtlety",
          "tranquil_spirit",
          "improved_rejuvenation",
          "natures_swiftness",
          "gift_of_nature",
          "improved_tranquility",
          "improved_regrowth",
          "swiftmend"
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
          murder = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_slice_and_dice = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          relentless_strikes = {
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
          cold_blood = {
            id = 12,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerColdBloodCD",
                  spellId = 14177,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Cold Blood"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
                }
              }
            }
          },
          improved_kidney_shot = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          seal_fate = {
            id = 14,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applySealFate",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Seal Fate"
                }
              }
            }
          },
          vigor = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          improved_gouge = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          improved_sinister_strike = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          lightning_reflexes = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_backstab = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          precision = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          endurance = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          riposte = {
            id = 23,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyRiposte",
                  spellId = 14251,
                  cast = [[{
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
                  cooldown = {
                    raw = "time.Second * 6",
                    seconds = 6
                  },
                  Flags = "SpellFlagCarnage | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                  SpellSchool = "core.SpellSchoolPhysical",
                  ProcMask = "core.ProcMaskMeleeMHSpecial",
                  DamageMultiplier = "1.5",
                  ThreatMultiplier = "1"
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRiposte",
                  auraDuration = {
                    raw = "time.Second * 5",
                    seconds = 5
                  },
                  label = "Riposte Ready Aura"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRiposte",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Riposte Trigger"
                }
              }
            }
          },
          improved_sprint = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          improved_kick = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          dagger_specialization = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          dual_wield_specialization = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          mace_specialization = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          blade_flurry = {
            id = 29,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerBladeFlurryCD",
                  spellId = 22482,
                  Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
                  SpellSchool = "core.SpellSchoolPhysical",
                  ProcMask = "core.ProcMaskEmpty",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
                  ClassSpellMask = "ClassSpellMask_RogueBladeFlurry",
                  IgnoreHaste = "true"
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerBladeFlurryCD",
                  spellId = 13877,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Blade Flurry"
                }
              }
            }
          },
          sword_specialization = {
            id = 30,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/sword_specialization.go",
                  registrationType = "RegisterAura",
                  functionName = "registerSwordSpecialization",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Sword Specialization"
                }
              }
            }
          },
          fist_weapon_specialization = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          weapon_expertise = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          aggression = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          adrenaline_rush = {
            id = 34,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerAdrenalineRushCD",
                  spellId = 13750,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Adrenaline Rush"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
                  ClassSpellMask = "ClassSpellMask_RogueAdrenalineRush",
                  IgnoreHaste = "true"
                }
              }
            }
          },
          master_of_deception = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          opportunity = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          sleight_of_hand = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          elusiveness = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          camouflage = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          initiative = {
            id = 40,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyInitiative",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Initiative"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyInitiative",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Initiative"
                }
              }
            }
          },
          ghostly_strike = {
            id = 41,
            type = "bool",
            label = "optional"
          },
          improved_ambush = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          setup = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          improved_sap = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          serrated_blades = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          heightened_senses = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          preparation = {
            id = 47,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/preparation.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerPreparationCD",
                  spellId = 14185,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 10,
			},
			IgnoreHaste: true,
		}]],
                  cooldown = {
                    raw = "time.Minute * 10",
                    seconds = 600
                  },
                  Flags = "core.SpellFlagAPL",
                  IgnoreHaste = "true"
                }
              }
            }
          },
          dirty_deeds = {
            id = 48,
            type = "int32",
            label = "optional"
          },
          hemorrhage = {
            id = 49,
            type = "bool",
            label = "optional"
          },
          deadliness = {
            id = 50,
            type = "int32",
            label = "optional"
          },
          premeditation = {
            id = 51,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/rogue/premeditation.go",
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
				Duration: time.Minute * 2,
			},
		}]],
                  cooldown = {
                    raw = "time.Minute * 2",
                    seconds = 120
                  },
                  Flags = "core.SpellFlagAPL",
                  IgnoreHaste = "true"
                }
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
          "murder",
          "improved_slice_and_dice",
          "relentless_strikes",
          "improved_expose_armor",
          "lethality",
          "vile_poisons",
          "improved_poisons",
          "cold_blood",
          "improved_kidney_shot",
          "seal_fate",
          "vigor",
          "improved_gouge",
          "improved_sinister_strike",
          "lightning_reflexes",
          "improved_backstab",
          "deflection",
          "precision",
          "endurance",
          "riposte",
          "improved_sprint",
          "improved_kick",
          "dagger_specialization",
          "dual_wield_specialization",
          "mace_specialization",
          "blade_flurry",
          "sword_specialization",
          "fist_weapon_specialization",
          "weapon_expertise",
          "aggression",
          "adrenaline_rush",
          "master_of_deception",
          "opportunity",
          "sleight_of_hand",
          "elusiveness",
          "camouflage",
          "initiative",
          "ghostly_strike",
          "improved_ambush",
          "setup",
          "improved_sap",
          "serrated_blades",
          "heightened_senses",
          "preparation",
          "dirty_deeds",
          "hemorrhage",
          "deadliness",
          "premeditation"
        }
      },
      RogueOptions = {
        fields = {
          HonorAmongThievesCritRate = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          pkSwap = {
            id = 2,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "HonorAmongThievesCritRate",
          "pkSwap"
        }
      },
      TankRogue = {
        fields = {
          options = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RogueOptions"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      Rogue = {
        fields = {
          options = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "RogueOptions"
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
          earths_grasp = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          elemental_warding = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          call_of_flame = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          elemental_focus = {
            id = 6,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyElementalFocus",
                  spellId = 16246,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Clearcasting"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyElementalFocus",
                  label = "Elemental Focus Trigger"
                }
              }
            }
          },
          reverberation = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          call_of_thunder = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          improved_fire_totems = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          eye_of_the_storm = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          elemental_devastation = {
            id = 11,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyElementalDevastation",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Elemental Devastation"
                }
              }
            }
          },
          storm_reach = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          elemental_fury = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          lightning_mastery = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          elemental_mastery = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerElementalMasteryCD",
                  spellId = 16166,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Elemental Mastery"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
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
                  }
                }
              }
            }
          },
          ancestral_knowledge = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          guardian_totems = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          thundering_strikes = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          improved_ghost_wolf = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_lightning_shield = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          enhancing_totems = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          two_handed_axes_and_maces = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          anticipation = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          flurry = {
            id = 25,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry Proc Trigger"
                }
              }
            }
          },
          toughness = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          improved_weapon_totems = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          elemental_weapons = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          parry = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          weapon_mastery = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          stormstrike = {
            id = 31,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/stormstrike.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerStormstrikeSpell",
                  spellId = 17364,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
                  Flags = "core.SpellFlagAPL",
                  ClassSpellMask = "ClassSpellMask_ShamanStormstrike",
                  SpellSchool = "core.SpellSchoolPhysical",
                  ProcMask = "core.ProcMaskMeleeMHSpecial"
                }
              }
            }
          },
          improved_healing_wave = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          tidal_focus = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          improved_reincarnation = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          ancestral_healing = {
            id = 35,
            type = "int32",
            label = "optional"
          },
          totemic_focus = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          natures_guidance = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          healing_focus = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          totemic_mastery = {
            id = 39,
            type = "bool",
            label = "optional"
          },
          healing_grace = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          restorative_totems = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          tidal_mastery = {
            id = 42,
            type = "int32",
            label = "optional"
          },
          healing_way = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          natures_swiftness = {
            id = 44,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "registerNaturesSwiftnessCD",
                  spellId = 16188,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Natures Swiftness"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
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
                  }
                }
              }
            }
          },
          purification = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          mana_tide_totem = {
            id = 46,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "convection",
          "concussion",
          "earths_grasp",
          "elemental_warding",
          "call_of_flame",
          "elemental_focus",
          "reverberation",
          "call_of_thunder",
          "improved_fire_totems",
          "eye_of_the_storm",
          "elemental_devastation",
          "storm_reach",
          "elemental_fury",
          "lightning_mastery",
          "elemental_mastery",
          "ancestral_knowledge",
          "shield_specialization",
          "guardian_totems",
          "thundering_strikes",
          "improved_ghost_wolf",
          "improved_lightning_shield",
          "enhancing_totems",
          "two_handed_axes_and_maces",
          "anticipation",
          "flurry",
          "toughness",
          "improved_weapon_totems",
          "elemental_weapons",
          "parry",
          "weapon_mastery",
          "stormstrike",
          "improved_healing_wave",
          "tidal_focus",
          "improved_reincarnation",
          "ancestral_healing",
          "totemic_focus",
          "natures_guidance",
          "healing_focus",
          "totemic_mastery",
          "healing_grace",
          "restorative_totems",
          "tidal_mastery",
          "healing_way",
          "natures_swiftness",
          "purification",
          "mana_tide_totem"
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
          use_mana_tide = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          recall_totems = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          use_fire_mcd = {
            id = 9,
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
          "use_mana_tide",
          "recall_totems",
          "use_fire_mcd",
          "bonus_spellpower",
          "enh_tier_ten_bonus"
        }
      },
      WardenShaman = {
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
          improved_curse_of_weakness = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_drain_soul = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          improved_life_tap = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          improved_drain_life = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          improved_curse_of_agony = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          fel_concentration = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          amplify_curse = {
            id = 9,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
                  registrationType = "RegisterAura",
                  functionName = "registerAmplifyCurseSpell",
                  spellId = 18288,
                  auraDuration = {
                    raw = "time.Second * 30",
                    seconds = 30
                  },
                  label = "Amplify Curse"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerAmplifyCurseSpell",
                  spellId = 18288,
                  cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 3 * time.Minute,
			},
		}]],
                  cooldown = {
                    raw = "3 * time.Minute",
                    seconds = 180
                  },
                  Flags = "core.SpellFlagAPL | WarlockFlagAffliction",
                  SpellSchool = "core.SpellSchoolShadow"
                }
              }
            }
          },
          grim_reach = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          nightfall = {
            id = 11,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyNightfall",
                  spellId = 17941,
                  auraDuration = {
                    raw = "time.Second * 10",
                    seconds = 10
                  },
                  label = "Nightfall Shadow Trance"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyNightfall",
                  label = "Nightfall Hidden Aura"
                }
              }
            }
          },
          improved_drain_mana = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          siphon_life = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          curse_of_exhaustion = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          improved_curse_of_exhaustion = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          shadow_mastery = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          dark_pact = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          improved_healthstone = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          improved_imp = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          demonic_embrace = {
            id = 20,
            type = "int32",
            label = "optional"
          },
          improved_health_funnel = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          improved_voidwalker = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          fel_intellect = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          improved_sayaad = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          fel_domination = {
            id = 25,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/fel_domination.go",
                  registrationType = "RegisterAura",
                  functionName = "registerFelDominationCD",
                  spellId = 18708,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Fel Domination"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/fel_domination.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerFelDominationCD",
                  majorCooldown = {
                    type = "core.CooldownTypeUnknown",
                    priority = nil
                  },
                  spellId = 18708,
                  cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Minute * 15,
			},
		}]],
                  cooldown = {
                    raw = "time.Minute * 15",
                    seconds = 900
                  },
                  SpellSchool = "core.SpellSchoolShadow",
                  ProcMask = "core.ProcMaskEmpty"
                }
              }
            }
          },
          fel_stamina = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          master_summoner = {
            id = 27,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMasterSummoner",
                  label = "Master Summoner Hidden Aura"
                }
              }
            }
          },
          unholy_power = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          improved_subjugate_demon = {
            id = 29,
            type = "int32",
            label = "optional"
          },
          demonic_sacrifice = {
            id = 30,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18789,
                  auraDuration = {
                    raw = "30 * time.Minute",
                    seconds = 1800
                  },
                  label = "Burning Wish"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18790,
                  auraDuration = {
                    raw = "30 * time.Minute",
                    seconds = 1800
                  },
                  label = "Fel Stamina"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18791,
                  auraDuration = {
                    raw = "30 * time.Minute",
                    seconds = 1800
                  },
                  label = "Touch of Shadow"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18792,
                  auraDuration = {
                    raw = "30 * time.Minute",
                    seconds = 1800
                  },
                  label = "Fel Energy"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18788,
                  Flags = "core.SpellFlagAPL",
                  ClassSpellMask = "ClassSpellMask_WarlockDemonicSacrifice",
                  SpellSchool = "core.SpellSchoolShadow"
                }
              }
            }
          },
          improved_firestone = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          master_demonologist = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          soul_link = {
            id = 33,
            type = "bool",
            label = "optional",
            goMetadata = {
              spell = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "applySoulLink",
                  spellId = 19028,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                  Flags = "core.SpellFlagAPL"
                }
              }
            }
          },
          improved_spellstone = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          improved_shadow_bolt = {
            id = 35,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyImprovedShadowBolt",
                  auraDuration = {
                    raw = "core.ISBDuration",
                    seconds = nil
                  },
                  label = "Improved Shadow Bolt Wrapper"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyImprovedShadowBolt",
                  label = "ISB Trigger"
                }
              }
            }
          },
          cataclysm = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          bane = {
            id = 37,
            type = "int32",
            label = "optional"
          },
          aftermath = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          improved_firebolt = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_lash_of_pain = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          devastation = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          shadowburn = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          intensity = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          destructive_reach = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          improved_searing_pain = {
            id = 45,
            type = "int32",
            label = "optional"
          },
          pyroclasm = {
            id = 46,
            type = "int32",
            label = "optional"
          },
          improved_immolate = {
            id = 47,
            type = "int32",
            label = "optional"
          },
          ruin = {
            id = 48,
            type = "bool",
            label = "optional"
          },
          emberstorm = {
            id = 49,
            type = "int32",
            label = "optional"
          },
          conflagrate = {
            id = 50,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "suppression",
          "improved_corruption",
          "improved_curse_of_weakness",
          "improved_drain_soul",
          "improved_life_tap",
          "improved_drain_life",
          "improved_curse_of_agony",
          "fel_concentration",
          "amplify_curse",
          "grim_reach",
          "nightfall",
          "improved_drain_mana",
          "siphon_life",
          "curse_of_exhaustion",
          "improved_curse_of_exhaustion",
          "shadow_mastery",
          "dark_pact",
          "improved_healthstone",
          "improved_imp",
          "demonic_embrace",
          "improved_health_funnel",
          "improved_voidwalker",
          "fel_intellect",
          "improved_sayaad",
          "fel_domination",
          "fel_stamina",
          "master_summoner",
          "unholy_power",
          "improved_subjugate_demon",
          "demonic_sacrifice",
          "improved_firestone",
          "master_demonologist",
          "soul_link",
          "improved_spellstone",
          "improved_shadow_bolt",
          "cataclysm",
          "bane",
          "aftermath",
          "improved_firebolt",
          "improved_lash_of_pain",
          "devastation",
          "shadowburn",
          "intensity",
          "destructive_reach",
          "improved_searing_pain",
          "pyroclasm",
          "improved_immolate",
          "ruin",
          "emberstorm",
          "conflagrate"
        }
      },
      WarlockRotation = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      WarlockOptions = {
        fields = {
          armor = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "Armor"
          },
          summon = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Summon"
          },
          weapon_imbue = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          max_firebolt_rank = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "MaxFireboltRank"
          },
          pet_pool_mana = {
            id = 5,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "armor",
          "summon",
          "weapon_imbue",
          "max_firebolt_rank",
          "pet_pool_mana"
        }
      },
      TankWarlock = {
        fields = {
          options = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "WarlockOptions"
          }
        },
        oneofs = {

        },
        field_order = {
          "options"
        }
      },
      Warlock = {
        fields = {
          options = {
            id = 2,
            type = "message",
            label = "optional",
            message_type = "WarlockOptions"
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
          spiritual_focus = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          improved_seal_of_righteousness = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          healing_light = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          consecration = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          improved_lay_on_hands = {
            id = 7,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyImprovedLayOnHands",
                  auraDuration = {
                    raw = "time.Minute * 2",
                    seconds = 120
                  },
                  label = "Lay on Hands"
                }
              }
            }
          },
          unyielding_faith = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          illumination = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          improved_blessing_of_wisdom = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          divine_favor = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/divine_favor.go",
                  registrationType = "RegisterAura",
                  functionName = "registerDivineFavor",
                  spellId = 20216,
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Divine Favor"
                }
              }
            }
          },
          lasting_judgement = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          holy_power = {
            id = 13,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
                  registrationType = "RegisterAura",
                  functionName = "registerHolyPowerAura",
                  spellId = 1226461,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Holy Power"
                }
              }
            }
          },
          holy_shock = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          improved_devotion_aura = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          redoubt = {
            id = 16,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRedoubt",
                  spellId = 20134,
                  auraDuration = {
                    raw = "time.Second * 10",
                    seconds = 10
                  },
                  label = "Redoubt"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRedoubt",
                  spellId = 20134,
                  auraDuration = {
                    raw = "time.Second * 10",
                    seconds = 10
                  },
                  label = "Redoubt"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRedoubt",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Redoubt Crit Trigger"
                }
              }
            }
          },
          precision = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          guardians_favor = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          toughness = {
            id = 19,
            type = "int32",
            label = "optional"
          },
          blessing_of_kings = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          improved_righteous_fury = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          shield_specialization = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          anticipation = {
            id = 23,
            type = "int32",
            label = "optional"
          },
          improved_hammer_of_justice = {
            id = 24,
            type = "int32",
            label = "optional"
          },
          improved_concentration_aura = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          blessing_of_sanctuary = {
            id = 26,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/blessing_of_sanctuary.go",
                  registrationType = "RegisterAura",
                  functionName = "registerBlessingOfSanctuary",
                  label = "Blessing of Sanctuary Trigger"
                }
              }
            }
          },
          reckoning = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          one_handed_weapon_specialization = {
            id = 28,
            type = "int32",
            label = "optional"
          },
          holy_shield = {
            id = 29,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/holy_shield.go",
                  registrationType = "RegisterAura",
                  functionName = "registerHolyShield",
                  auraDuration = {
                    raw = "time.Second * 10",
                    seconds = 10
                  },
                  label = "Holy Shield"
                }
              }
            }
          },
          improved_blessing_of_might = {
            id = 30,
            type = "int32",
            label = "optional"
          },
          benediction = {
            id = 31,
            type = "int32",
            label = "optional"
          },
          improved_judgement = {
            id = 32,
            type = "int32",
            label = "optional"
          },
          improved_seal_of_the_crusader = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          deflection = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          vindication = {
            id = 35,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVindication",
                  spellId = 26021,
                  auraDuration = {
                    raw = "time.Second * 30",
                    seconds = 30
                  },
                  label = "Vindication Proc"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVindication",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Vindication Talent"
                }
              }
            }
          },
          conviction = {
            id = 36,
            type = "int32",
            label = "optional"
          },
          seal_of_command = {
            id = 37,
            type = "bool",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/soc.go",
                  registrationType = "RegisterAura",
                  functionName = "registerSealOfCommand",
                  auraDuration = {
                    raw = "time.Second * 30",
                    seconds = 30
                  },
                  label = "Seal of Command"
                }
              }
            }
          },
          pursuit_of_justice = {
            id = 38,
            type = "int32",
            label = "optional"
          },
          eye_for_an_eye = {
            id = 39,
            type = "int32",
            label = "optional"
          },
          improved_retribution_aura = {
            id = 40,
            type = "int32",
            label = "optional"
          },
          two_handed_weapon_specialization = {
            id = 41,
            type = "int32",
            label = "optional"
          },
          sanctity_aura = {
            id = 42,
            type = "bool",
            label = "optional"
          },
          vengeance = {
            id = 43,
            type = "int32",
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  spellId = 20059,
                  auraDuration = {
                    raw = "time.Second * 8",
                    seconds = 8
                  },
                  label = "Vengeance Proc"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  label = "Vengeance"
                },
                {
                  sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  label = "Vengeance"
                }
              }
            }
          },
          repentance = {
            id = 44,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "divine_strength",
          "divine_intellect",
          "spiritual_focus",
          "improved_seal_of_righteousness",
          "healing_light",
          "consecration",
          "improved_lay_on_hands",
          "unyielding_faith",
          "illumination",
          "improved_blessing_of_wisdom",
          "divine_favor",
          "lasting_judgement",
          "holy_power",
          "holy_shock",
          "improved_devotion_aura",
          "redoubt",
          "precision",
          "guardians_favor",
          "toughness",
          "blessing_of_kings",
          "improved_righteous_fury",
          "shield_specialization",
          "anticipation",
          "improved_hammer_of_justice",
          "improved_concentration_aura",
          "blessing_of_sanctuary",
          "reckoning",
          "one_handed_weapon_specialization",
          "holy_shield",
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
          "two_handed_weapon_specialization",
          "sanctity_aura",
          "vengeance",
          "repentance"
        }
      },
      PaladinOptions = {
        fields = {
          primarySeal = {
            id = 1,
            type = "enum",
            label = "optional",
            enum_type = "PaladinSeal"
          },
          aura = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PaladinAura"
          },
          IsUsingDivineStormStopAttack = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          IsUsingJudgementStopAttack = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          IsUsingCrusaderStrikeStopAttack = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          IsUsingExorcismStopAttack = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          IsUsingManualStartAttack = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          righteousFury = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          personalBlessing = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "Blessings"
          }
        },
        oneofs = {

        },
        field_order = {
          "primarySeal",
          "aura",
          "IsUsingDivineStormStopAttack",
          "IsUsingJudgementStopAttack",
          "IsUsingCrusaderStrikeStopAttack",
          "IsUsingExorcismStopAttack",
          "IsUsingManualStartAttack",
          "righteousFury",
          "personalBlessing"
        }
      },
      HolyPaladin = {
        fields = {
          options = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "PaladinOptions"
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
            message_type = "PaladinOptions"
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
            message_type = "PaladinOptions"
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
      UIFaction = {
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
            type = "int32",
            label = "optional"
          },
          rep_level = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "RepLevel"
          },
          player_faction = {
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
          "player_faction"
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
          requires_level = {
            id = 14,
            type = "int32",
            label = "optional"
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
          "requires_level"
        }
      },
      UIRune = {
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
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "ItemType"
          },
          class_allowlist = {
            id = 7,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "name",
          "icon",
          "type",
          "class_allowlist"
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
          rank = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          requires_level = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          has_buff = {
            id = 6,
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
          "rank",
          "requires_level",
          "has_buff"
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
            id = 22,
            type = "int32",
            label = "optional"
          },
          max_ilvl = {
            id = 23,
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
          favorite_items = {
            id = 11,
            type = "int32",
            label = "repeated"
          },
          favorite_enchants = {
            id = 13,
            type = "string",
            label = "repeated"
          },
          favorite_runes = {
            id = 20,
            type = "int32",
            label = "repeated"
          },
          favorite_random_suffixes = {
            id = 21,
            type = "int32",
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
          "favorite_items",
          "favorite_enchants",
          "favorite_runes",
          "favorite_random_suffixes"
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
          excluded_from_calc = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "UnitStats"
          }
        },
        oneofs = {

        },
        field_order = {
          "excluded_from_calc"
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
            id = 3,
            type = "message",
            label = "optional",
            message_type = "Debuffs"
          },
          player_buffs = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          consumes = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "Consumes"
          },
          race = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "Race"
          },
          level = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          professions = {
            id = 10,
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
            id = 11,
            type = "int32",
            label = "optional"
          },
          channel_clip_delay_ms = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          in_front_of_target = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          distance_from_target = {
            id = 14,
            type = "double",
            label = "optional"
          },
          healing_model = {
            id = 15,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
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
          "level",
          "professions",
          "enable_item_swap",
          "item_swap",
          "reaction_time_ms",
          "channel_clip_delay_ms",
          "in_front_of_target",
          "distance_from_target",
          "healing_model"
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
            id = 1,
            type = "string",
            label = "optional"
          },
          race = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "Race"
          },
          level = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          class = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "Class"
          },
          equipment = {
            id = 5,
            type = "message",
            label = "optional",
            message_type = "EquipmentSpec"
          },
          consumes = {
            id = 6,
            type = "message",
            label = "optional",
            message_type = "Consumes"
          },
          bonus_stats = {
            id = 7,
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
            id = 8,
            type = "message",
            label = "optional",
            message_type = "IndividualBuffs"
          },
          talents_string = {
            id = 9,
            type = "string",
            label = "optional"
          },
          profession1 = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          profession2 = {
            id = 11,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          cooldowns = {
            id = 12,
            type = "message",
            label = "optional",
            message_type = "Cooldowns"
          },
          rotation = {
            id = 13,
            type = "message",
            label = "optional",
            message_type = "APLRotation"
          },
          reaction_time_ms = {
            id = 14,
            type = "int32",
            label = "optional"
          },
          channel_clip_delay_ms = {
            id = 15,
            type = "int32",
            label = "optional"
          },
          in_front_of_target = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          distance_from_target = {
            id = 17,
            type = "double",
            label = "optional"
          },
          isb_using_shadowflame = {
            id = 47,
            type = "bool",
            label = "optional"
          },
          isb_sb_frequency = {
            id = 41,
            type = "double",
            label = "optional"
          },
          isb_crit = {
            id = 42,
            type = "double",
            label = "optional"
          },
          isb_warlocks = {
            id = 43,
            type = "int32",
            label = "optional"
          },
          isb_spriests = {
            id = 44,
            type = "int32",
            label = "optional"
          },
          database = {
            id = 18,
            type = "message",
            label = "optional",
            message_type = "SimDatabase"
          },
          healing_model = {
            id = 19,
            type = "message",
            label = "optional",
            message_type = "HealingModel"
          },
          balance_druid = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "BalanceDruid"
          },
          feral_druid = {
            id = 21,
            type = "message",
            label = "optional",
            message_type = "FeralDruid"
          },
          feral_tank_druid = {
            id = 22,
            type = "message",
            label = "optional",
            message_type = "FeralTankDruid"
          },
          restoration_druid = {
            id = 23,
            type = "message",
            label = "optional",
            message_type = "RestorationDruid"
          },
          hunter = {
            id = 24,
            type = "message",
            label = "optional",
            message_type = "Hunter"
          },
          mage = {
            id = 25,
            type = "message",
            label = "optional",
            message_type = "Mage"
          },
          retribution_paladin = {
            id = 26,
            type = "message",
            label = "optional",
            message_type = "RetributionPaladin"
          },
          protection_paladin = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "ProtectionPaladin"
          },
          holy_paladin = {
            id = 28,
            type = "message",
            label = "optional",
            message_type = "HolyPaladin"
          },
          healing_priest = {
            id = 29,
            type = "message",
            label = "optional",
            message_type = "HealingPriest"
          },
          shadow_priest = {
            id = 30,
            type = "message",
            label = "optional",
            message_type = "ShadowPriest"
          },
          rogue = {
            id = 32,
            type = "message",
            label = "optional",
            message_type = "Rogue"
          },
          tank_rogue = {
            id = 40,
            type = "message",
            label = "optional",
            message_type = "TankRogue"
          },
          elemental_shaman = {
            id = 33,
            type = "message",
            label = "optional",
            message_type = "ElementalShaman"
          },
          enhancement_shaman = {
            id = 34,
            type = "message",
            label = "optional",
            message_type = "EnhancementShaman"
          },
          restoration_shaman = {
            id = 35,
            type = "message",
            label = "optional",
            message_type = "RestorationShaman"
          },
          warden_shaman = {
            id = 48,
            type = "message",
            label = "optional",
            message_type = "WardenShaman"
          },
          warlock = {
            id = 36,
            type = "message",
            label = "optional",
            message_type = "Warlock"
          },
          tank_warlock = {
            id = 39,
            type = "message",
            label = "optional",
            message_type = "TankWarlock"
          },
          warrior = {
            id = 37,
            type = "message",
            label = "optional",
            message_type = "Warrior"
          },
          tank_warrior = {
            id = 38,
            type = "message",
            label = "optional",
            message_type = "TankWarrior"
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
            "rogue",
            "tank_rogue",
            "elemental_shaman",
            "enhancement_shaman",
            "restoration_shaman",
            "warden_shaman",
            "warlock",
            "tank_warlock",
            "warrior",
            "tank_warrior"
          }
        },
        field_order = {
          "name",
          "race",
          "level",
          "class",
          "equipment",
          "consumes",
          "bonus_stats",
          "enable_item_swap",
          "item_swap",
          "buffs",
          "talents_string",
          "profession1",
          "profession2",
          "cooldowns",
          "rotation",
          "reaction_time_ms",
          "channel_clip_delay_ms",
          "in_front_of_target",
          "distance_from_target",
          "isb_using_shadowflame",
          "isb_sb_frequency",
          "isb_crit",
          "isb_warlocks",
          "isb_spriests",
          "database",
          "healing_model",
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
          "rogue",
          "tank_rogue",
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warden_shaman",
          "warlock",
          "tank_warlock",
          "warrior",
          "tank_warrior"
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
          resisted_hits = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          crits = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          resisted_crits = {
            id = 26,
            type = "int32",
            label = "optional"
          },
          ticks = {
            id = 21,
            type = "int32",
            label = "optional"
          },
          resisted_ticks = {
            id = 27,
            type = "int32",
            label = "optional"
          },
          crit_ticks = {
            id = 22,
            type = "int32",
            label = "optional"
          },
          resisted_crit_ticks = {
            id = 28,
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
          blocked_crits = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          crushes = {
            id = 35,
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
          resisted_damage = {
            id = 29,
            type = "double",
            label = "optional"
          },
          crit_damage = {
            id = 15,
            type = "double",
            label = "optional"
          },
          resisted_crit_damage = {
            id = 30,
            type = "double",
            label = "optional"
          },
          tick_damage = {
            id = 23,
            type = "double",
            label = "optional"
          },
          resisted_tick_damage = {
            id = 31,
            type = "double",
            label = "optional"
          },
          crit_tick_damage = {
            id = 24,
            type = "double",
            label = "optional"
          },
          resisted_crit_tick_damage = {
            id = 32,
            type = "double",
            label = "optional"
          },
          glance_damage = {
            id = 17,
            type = "double",
            label = "optional"
          },
          crush_damage = {
            id = 36,
            type = "double",
            label = "optional"
          },
          block_damage = {
            id = 18,
            type = "double",
            label = "optional"
          },
          blocked_crit_damage = {
            id = 34,
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
          "resisted_hits",
          "crits",
          "resisted_crits",
          "ticks",
          "resisted_ticks",
          "crit_ticks",
          "resisted_crit_ticks",
          "misses",
          "dodges",
          "parries",
          "blocks",
          "blocked_crits",
          "crushes",
          "glances",
          "damage",
          "resisted_damage",
          "crit_damage",
          "resisted_crit_damage",
          "tick_damage",
          "resisted_tick_damage",
          "crit_tick_damage",
          "resisted_crit_tick_damage",
          "glance_damage",
          "crush_damage",
          "block_damage",
          "blocked_crit_damage",
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
          "encounter_only"
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
          name = {
            id = 2,
            type = "string",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "talents_string",
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
          requires_level = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          stats = {
            id = 10,
            type = "double",
            label = "repeated"
          },
          random_suffix_options = {
            id = 27,
            type = "int32",
            label = "repeated"
          },
          weapon_damage_min = {
            id = 13,
            type = "double",
            label = "optional"
          },
          weapon_damage_max = {
            id = 14,
            type = "double",
            label = "optional"
          },
          weapon_speed = {
            id = 15,
            type = "double",
            label = "optional"
          },
          spell_school = {
            id = 35,
            type = "enum",
            label = "optional",
            enum_type = "SpellSchool"
          },
          weapon_skills = {
            id = 28,
            type = "double",
            label = "repeated"
          },
          bonus_physical_damage = {
            id = 31,
            type = "double",
            label = "optional"
          },
          bonus_periodic_pct = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          ilvl = {
            id = 16,
            type = "int32",
            label = "optional"
          },
          phase = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          quality = {
            id = 18,
            type = "enum",
            label = "optional",
            enum_type = "ItemQuality"
          },
          unique = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          unique_category = {
            id = 33,
            type = "string",
            label = "optional"
          },
          heroic = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          timeworn = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          sanctified = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          class_allowlist = {
            id = 21,
            type = "enum",
            label = "repeated",
            enum_type = "Class"
          },
          required_profession = {
            id = 22,
            type = "enum",
            label = "optional",
            enum_type = "Profession"
          },
          set_name = {
            id = 23,
            type = "string",
            label = "optional"
          },
          set_id = {
            id = 29,
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
            id = 25,
            type = "message",
            label = "repeated",
            message_type = "UIItemSource"
          },
          faction_restriction = {
            id = 26,
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
          "requires_level",
          "stats",
          "random_suffix_options",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "spell_school",
          "weapon_skills",
          "bonus_physical_damage",
          "bonus_periodic_pct",
          "ilvl",
          "phase",
          "quality",
          "unique",
          "unique_category",
          "heroic",
          "timeworn",
          "sanctified",
          "class_allowlist",
          "required_profession",
          "set_name",
          "set_id",
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
          runes = {
            id = 10,
            type = "message",
            label = "repeated",
            message_type = "UIRune"
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
          factions = {
            id = 12,
            type = "message",
            label = "repeated",
            message_type = "UIFaction"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "random_suffixes",
          "enchants",
          "runes",
          "encounters",
          "zones",
          "npcs",
          "factions",
          "item_icons",
          "spell_icons"
        }
      }
    },
    enums = {
      PriestRune = {
        PriestRuneNone = 0,
        RuneHelmDivineAegis = 431622,
        RuneHelmEyeOfTheVoid = 402789,
        RuneHelmPainAndSuffering = 413251,
        RuneShouldersContemnor = 1220138,
        RuneShouldersDeathdealer = 1220130,
        RuneShouldersFaithful = 1220112,
        RuneShouldersMindBreaker = 1220128,
        RuneShouldersPenitent = 1220122,
        RuneShouldersPlaguebringer = 1220140,
        RuneShouldersRefinedPriest = 1220108,
        RuneShouldersSerendipitous = 1220114,
        RuneShouldersSpiritFont = 1220132,
        RuneShouldersUnwaveringDefiler = 1220136,
        RuneShouldersZealot = 1220134,
        RuneCloakBindingHeal = 401937,
        RuneCloakSoulWarding = 402000,
        RuneCloakVampiricTouch = 402668,
        RuneChestSerendipity = 413248,
        RuneChestStrengthOfSoul = 415739,
        RuneChestTwistedFaith = 425198,
        RuneBracersDespair = 431670,
        RuneBracersSurgeOfLight = 431664,
        RuneBracersVoidZone = 431681,
        RuneHandsCircleOfHealing = 401946,
        RuneHandsMindSear = 413259,
        RuneHandsPenance = 402174,
        RuneHandsShadowWordDeath = 401955,
        RuneWaistEmpoweredRenew = 425266,
        RuneWaistMindSpike = 431655,
        RuneWaistRenewedHope = 425280,
        RuneLegsHomunculi = 402799,
        RuneLegsPowerWordBarrier = 425207,
        RuneLegsPrayerOfMending = 401859,
        RuneLegsSharedPain = 401969,
        RuneFeetDispersion = 425294,
        RuneFeetPainSuppression = 402004,
        RuneFeetSpiritOfTheRedeemer = 425284,
        RuneFeetVoidPlague = 425204
      },
      APLValueType = {
        ValueTypeUnknown = 0,
        ValueTypeBool = 1,
        ValueTypeInt = 2,
        ValueTypeFloat = 3,
        ValueTypeDuration = 4,
        ValueTypeString = 5
      },
      Spec = {
        SpecBalanceDruid = 0,
        SpecFeralDruid = 12,
        SpecFeralTankDruid = 14,
        SpecRestorationDruid = 18,
        SpecElementalShaman = 1,
        SpecEnhancementShaman = 9,
        SpecRestorationShaman = 19,
        SpecWardenShaman = 23,
        SpecHunter = 8,
        SpecMage = 2,
        SpecHolyPaladin = 20,
        SpecProtectionPaladin = 13,
        SpecRetributionPaladin = 3,
        SpecRogue = 7,
        SpecTankRogue = 22,
        SpecHealingPriest = 17,
        SpecShadowPriest = 4,
        SpecWarlock = 5,
        SpecTankWarlock = 21,
        SpecWarrior = 6,
        SpecTankWarrior = 11
      },
      Race = {
        RaceUnknown = 0,
        RaceDwarf = 1,
        RaceGnome = 2,
        RaceHuman = 3,
        RaceNightElf = 4,
        RaceOrc = 5,
        RaceTauren = 6,
        RaceTroll = 7,
        RaceUndead = 8
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
        ClassWarrior = 9
      },
      Profession = {
        ProfessionUnknown = 0,
        Alchemy = 1,
        Blacksmithing = 2,
        Enchanting = 3,
        Engineering = 4,
        Herbalism = 5,
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
        StatArcanePower = 6,
        StatFirePower = 7,
        StatFrostPower = 8,
        StatHolyPower = 9,
        StatNaturePower = 10,
        StatShadowPower = 11,
        StatMP5 = 12,
        StatSpellHit = 13,
        StatSpellCrit = 14,
        StatSpellHaste = 15,
        StatSpellPenetration = 16,
        StatAttackPower = 17,
        StatMeleeHit = 18,
        StatMeleeCrit = 19,
        StatMeleeHaste = 20,
        StatArmorPenetration = 21,
        StatExpertise = 22,
        StatMana = 23,
        StatEnergy = 24,
        StatRage = 25,
        StatArmor = 26,
        StatRangedAttackPower = 27,
        StatDefense = 28,
        StatBlock = 29,
        StatBlockValue = 30,
        StatDodge = 31,
        StatParry = 32,
        StatResilience = 33,
        StatHealth = 34,
        StatArcaneResistance = 35,
        StatFireResistance = 36,
        StatFrostResistance = 37,
        StatNatureResistance = 38,
        StatShadowResistance = 39,
        StatBonusArmor = 40,
        StatHealingPower = 41,
        StatSpellDamage = 42,
        StatFeralAttackPower = 43
      },
      PseudoStat = {
        PseudoStatMainHandDps = 0,
        PseudoStatOffHandDps = 1,
        PseudoStatRangedDps = 2,
        PseudoStatBlockValueMultiplier = 3,
        PseudoStatDodge = 4,
        PseudoStatParry = 5,
        PseudoStatBonusPhysicalDamage = 31,
        PseudoStatThornsDamage = 32,
        PseudoStatUnarmedSkill = 6,
        PseudoStatDaggersSkill = 7,
        PseudoStatSwordsSkill = 8,
        PseudoStatMacesSkill = 9,
        PseudoStatAxesSkill = 10,
        PseudoStatTwoHandedSwordsSkill = 11,
        PseudoStatTwoHandedMacesSkill = 12,
        PseudoStatTwoHandedAxesSkill = 13,
        PseudoStatPolearmsSkill = 14,
        PseudoStatStavesSkill = 15,
        PseudoStatBowsSkill = 16,
        PseudoStatCrossbowsSkill = 17,
        PseudoStatGunsSkill = 18,
        PseudoStatThrownSkill = 19,
        PseudoStatFeralCombatSkill = 20,
        PseudoStatSchoolHitArcane = 21,
        PseudoStatSchoolHitFire = 22,
        PseudoStatSchoolHitFrost = 23,
        PseudoStatSchoolHitHoly = 24,
        PseudoStatSchoolHitNature = 25,
        PseudoStatSchoolHitShadow = 26,
        PseudoStatMeleeSpeedMultiplier = 27,
        PseudoStatRangedSpeedMultiplier = 28,
        PseudoStatCastSpeedMultiplier = 34,
        PseudoStatBlockValuePerStrength = 29,
        PseudoStatTimewornBonus = 30,
        PseudoStatSanctifiedBonus = 33
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
      WeaponSkill = {
        WeaponSkillUnknown = 0,
        WeaponSkillAxes = 1,
        WeaponSkillSwords = 2,
        WeaponSkillMaces = 3,
        WeaponSkillDaggers = 4,
        WeaponSkillUnarmed = 5,
        WeaponSkillTwoHandedAxes = 6,
        WeaponSkillTwoHandedSwords = 7,
        WeaponSkillTwoHandedMaces = 8,
        WeaponSkillPolearms = 9,
        WeaponSkillStaves = 10,
        WeaponSkillThrown = 11,
        WeaponSkillBows = 12,
        WeaponSkillCrossbows = 13,
        WeaponSkillGuns = 14,
        WeaponSkillFeralCombat = 15
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
      CastType = {
        CastTypeUnknown = 0,
        CastTypeMainHand = 1,
        CastTypeOffHand = 2,
        CastTypeRanged = 3
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
      SapperExplosive = {
        SapperUnknown = 0,
        SapperGoblinSapper = 1,
        SapperFumigator = 2
      },
      Explosive = {
        ExplosiveUnknown = 0,
        ExplosiveSolidDynamite = 1,
        ExplosiveDenseDynamite = 2,
        ExplosiveThoriumGrenade = 3,
        ExplosiveEzThroRadiationBomb = 4,
        ExplosiveHighYieldRadiationBomb = 5,
        ExplosiveGoblinLandMine = 6,
        ExplosiveObsidianBomb = 7,
        ExplosiveStratholmeHolyWater = 8
      },
      Potions = {
        UnknownPotion = 0,
        ManaPotion = 2,
        GreaterManaPotion = 3,
        SuperiorManaPotion = 4,
        MajorManaPotion = 5,
        RagePotion = 6,
        GreatRagePotion = 7,
        MightyRagePotion = 8,
        LesserStoneshieldPotion = 9,
        GreaterStoneshieldPotion = 10,
        LesserHealingPotion = 11,
        HealingPotion = 12,
        GreaterHealingPotion = 13,
        SuperiorHealingPotion = 14,
        MajorHealingPotion = 15,
        MagicResistancePotion = 16,
        GreaterArcaneProtectionPotion = 17,
        GreaterFireProtectionPotion = 18,
        GreaterFrostProtectionPotion = 19,
        GreaterHolyProtectionPotion = 20,
        GreaterNatureProtectionPotion = 21,
        GreaterShadowProtectionPotion = 22,
        LesserManaPotion = 1
      },
      Conjured = {
        ConjuredUnknown = 0,
        ConjuredMinorRecombobulator = 1,
        ConjuredDemonicRune = 2,
        ConjuredRogueThistleTea = 3,
        ConjuredHealthstone = 7,
        ConjuredGreaterHealthstone = 8,
        ConjuredMajorHealthstone = 9,
        ConjuredDruidCatnip = 4
      },
      EnchantedSigil = {
        UnknownSigil = 0,
        InnovationSigil = 1,
        LivingDreamsSigil = 2,
        FlowingWatersSigil = 3,
        WrathOfTheStormSigil = 4
      },
      Flask = {
        FlaskUnknown = 0,
        FlaskOfTheTitans = 1,
        FlaskOfDistilledWisdom = 2,
        FlaskOfSupremePower = 3,
        FlaskOfChromaticResistance = 4,
        FlaskOfRestlessDreams = 5,
        FlaskOfEverlastingNightmares = 6,
        FlaskOfMadness = 7,
        FlaskOfUnyieldingSorrow = 8,
        FlaskOfAncientKnowledge = 9,
        FlaskOfTheOldGods = 10
      },
      Alcohol = {
        AlcoholUnknown = 0,
        AlcoholRumseyRumBlackLabel = 1,
        AlcoholGordokGreenGrog = 2,
        AlcoholRumseyRumDark = 3,
        AlcoholRumseyRumLight = 4,
        AlcoholKreegsStoutBeatdown = 5
      },
      AgilityElixir = {
        AgilityElixirUnknown = 0,
        ElixirOfTheMongoose = 1,
        ElixirOfGreaterAgility = 2,
        ElixirOfLesserAgility = 3,
        ScrollOfAgility = 4,
        ElixirOfAgility = 5,
        ElixirOfTheHoneyBadger = 6
      },
      ArmorElixir = {
        ArmorElixirUnknown = 0,
        ElixirOfSuperiorDefense = 1,
        ElixirOfGreaterDefense = 2,
        ElixirOfDefense = 3,
        ElixirOfMinorDefense = 4,
        ScrollOfProtection = 5,
        ElixirOfTheIronside = 6
      },
      HealthElixir = {
        HealthElixirUnknown = 0,
        ElixirOfFortitude = 1,
        ElixirOfMinorFortitude = 2
      },
      ManaRegenElixir = {
        ManaRegenElixirUnknown = 0,
        MagebloodPotion = 1
      },
      StrengthBuff = {
        StrengthBuffUnknown = 0,
        JujuPower = 1,
        ElixirOfGiants = 2,
        ElixirOfOgresStrength = 3,
        ScrollOfStrength = 4
      },
      AttackPowerBuff = {
        AttackPowerBuffUnknown = 0,
        JujuMight = 1,
        WinterfallFirewater = 2
      },
      SpellPowerBuff = {
        SpellPowerBuffUnknown = 0,
        ArcaneElixir = 1,
        GreaterArcaneElixir = 2,
        LesserArcaneElixir = 3,
        ElixirOfTheMageLord = 4
      },
      ShadowPowerBuff = {
        ShadowPowerBuffUnknown = 0,
        ElixirOfShadowPower = 1
      },
      FirePowerBuff = {
        FirePowerBuffUnknown = 0,
        ElixirOfFirepower = 1,
        ElixirOfGreaterFirepower = 2
      },
      FrostPowerBuff = {
        FrostPowerBuffUnknown = 0,
        ElixirOfFrostPower = 1
      },
      SealOfTheDawn = {
        SealOfTheDawnUnknown = 0,
        SealOfTheDawnDamageR1 = 1,
        SealOfTheDawnDamageR2 = 2,
        SealOfTheDawnDamageR3 = 3,
        SealOfTheDawnDamageR4 = 4,
        SealOfTheDawnDamageR5 = 5,
        SealOfTheDawnDamageR6 = 6,
        SealOfTheDawnDamageR7 = 7,
        SealOfTheDawnDamageR8 = 8,
        SealOfTheDawnDamageR9 = 9,
        SealOfTheDawnDamageR10 = 10,
        SealOfTheDawnTankR1 = 11,
        SealOfTheDawnTankR2 = 12,
        SealOfTheDawnTankR3 = 13,
        SealOfTheDawnTankR4 = 14,
        SealOfTheDawnTankR5 = 15,
        SealOfTheDawnTankR6 = 16,
        SealOfTheDawnTankR7 = 17,
        SealOfTheDawnTankR8 = 18,
        SealOfTheDawnTankR9 = 19,
        SealOfTheDawnTankR10 = 20,
        SealOfTheDawnHealingR1 = 21,
        SealOfTheDawnHealingR2 = 22,
        SealOfTheDawnHealingR3 = 23,
        SealOfTheDawnHealingR4 = 24,
        SealOfTheDawnHealingR5 = 25,
        SealOfTheDawnHealingR6 = 26,
        SealOfTheDawnHealingR7 = 27,
        SealOfTheDawnHealingR8 = 28,
        SealOfTheDawnHealingR9 = 29,
        SealOfTheDawnHealingR10 = 30
      },
      ZanzaBuff = {
        ZanzaBuffUnknown = 0,
        SpiritOfZanza = 1,
        SheenOfZanza = 2,
        SwiftnessOfZanza = 3,
        ROIDS = 4,
        GroundScorpokAssay = 5,
        CerebralCortexCompound = 6,
        GizzardGum = 7,
        LungJuiceCocktail = 8,
        AtalaiMojoOfWar = 9,
        AtalaiMojoOfForbiddenMagic = 10,
        AtalaiMojoOfLife = 11
      },
      AtalaiMojo = {
        AtalaiMojoUnknown = 0,
        MojoOfWar = 1,
        MojoOfForbiddenMagic = 2,
        MojoOfLife = 3
      },
      MageScroll = {
        MageScrollUnknown = 0,
        MageScrollArcaneRecovery = 1,
        MageScrollArcaneAccuracy = 2,
        MageScrollArcanePower = 3,
        MageScrollFireProtection = 4,
        MageScrollFrostProtection = 5
      },
      WeaponImbue = {
        WeaponImbueUnknown = 0,
        MinorWizardOil = 13,
        LesserWizardOil = 14,
        WizardOil = 20,
        BrilliantWizardOil = 2,
        EnchantedRepellent = 30,
        BlessedWizardOil = 33,
        MinorManaOil = 15,
        LesserManaOil = 16,
        BrilliantManaOil = 1,
        BlackfathomManaOil = 5,
        SolidSharpeningStone = 17,
        DenseSharpeningStone = 3,
        ElementalSharpeningStone = 4,
        BlackfathomSharpeningStone = 6,
        ConsecratedSharpeningStone = 34,
        WeightedConsecratedSharpeningStone = 35,
        SolidWeightstone = 18,
        DenseWeightstone = 19,
        ShadowOil = 21,
        FrostOil = 22,
        WildStrikes = 7,
        Windfury = 8,
        RockbiterWeapon = 9,
        FlametongueWeapon = 10,
        FrostbrandWeapon = 11,
        WindfuryWeapon = 12,
        InstantPoison = 23,
        DeadlyPoison = 24,
        WoundPoison = 25,
        OccultPoison = 27,
        SebaciousPoison = 28,
        AtrophicPoison = 31,
        NumbingPoison = 32,
        ConductiveShieldCoating = 26,
        MagnificentTrollshine = 29
      },
      Food = {
        FoodUnknown = 0,
        FoodGrilledSquid = 1,
        FoodSmokedDesertDumpling = 2,
        FoodNightfinSoup = 3,
        FoodRunnTumTuberSurprise = 4,
        FoodDirgesKickChimaerokChops = 5,
        FoodBlessedSunfruitJuice = 6,
        FoodBlessSunfruit = 7,
        FoodHotWolfRibs = 8,
        FoodTenderWolfSteak = 9,
        FoodSmokedSagefish = 10,
        FoodSagefishDelight = 11,
        FoodDarkclawBisque = 12,
        FoodSmokedRedgill = 13,
        FoodProwlerSteak = 14,
        FoodFiletOFlank = 15,
        FoodSunriseOmelette = 16,
        FoodSpecklefinFeast = 17,
        FoodGrandLobsterBanquet = 18
      },
      SaygesFortune = {
        SaygesUnknown = 0,
        SaygesDamage = 1,
        SaygesAgility = 2,
        SaygesIntellect = 3,
        SaygesStamina = 4,
        SaygesSpirit = 5
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
        OtherActionEnergyRegen = 3,
        OtherActionFocusRegen = 4,
        OtherActionManaGain = 5,
        OtherActionRageGain = 6,
        OtherActionAttack = 7,
        OtherActionShoot = 8,
        OtherActionPet = 9,
        OtherActionRefund = 10,
        OtherActionDamageTaken = 11,
        OtherActionHealingModel = 12,
        OtherActionPotion = 13,
        OtherActionMove = 14,
        OtherActionComboPoints = 15,
        OtherActionExplosives = 16,
        OtherActionOffensiveEquip = 17,
        OtherActionDefensiveEquip = 18
      },
      RingRune = {
        RuneRingNone = 0,
        RuneRingArcaneSpecialization = 442893,
        RuneRingAxeSpecialization = 442876,
        RuneRingDaggerSpecialization = 442887,
        RuneRingDefenseSpecialization = 459312,
        RuneRingFeralCombatSpecialization = 453622,
        RuneRingFireSpecialization = 442894,
        RuneRingFistWeaponSpecialization = 442890,
        RuneRingFrostSpecialization = 442895,
        RuneRingHealingSpecialization = 468758,
        RuneRingHolySpecialization = 442898,
        RuneRingMaceSpecialization = 442881,
        RuneRingMeditationSpecialization = 468762,
        RuneRingNatureSpecialization = 442896,
        RuneRingPoleWeaponSpecialization = 442892,
        RuneRingRangedWeaponSpecialization = 442891,
        RuneRingShadowSpecialization = 442897,
        RuneRingSwordSpecialization = 442813
      },
      WarriorRune = {
        WarriorRuneNone = 0,
        RuneEndlessRage = 403218,
        RuneTasteForBlood = 426953,
        RuneVigilance = 426972,
        RuneShieldMastery = 426980,
        RuneShouldersAftershock = 1219992,
        RuneShouldersBattleForecaster = 1219960,
        RuneShouldersBloodseeker = 1219962,
        RuneShouldersDeathbound = 1219968,
        RuneShouldersDeflective = 1219978,
        RuneShouldersDestroyer = 1219966,
        RuneShouldersEnmityWarrior = 1219976,
        RuneShouldersGladiator = 1219990,
        RuneShouldersIncessant = 1219982,
        RuneShouldersRevenger = 1219980,
        RuneShouldersSanguinist = 1219970,
        RuneShouldersSavage = 1219974,
        RuneShouldersSentinel = 1219986,
        RuneShouldersSouthpaw = 1219988,
        RuneShouldersTactician = 1219957,
        RuneShouldersThunderbringer = 1219984,
        RuneShouldersTitan = 1219964,
        RuneShouldersWarVeteran = 1219958,
        RuneSuddenDeath = 440113,
        RuneFreshMeat = 440484,
        RuneShockwave = 440488,
        RuneFlagellation = 402877,
        RuneRagingBlow = 402911,
        RuneBloodFrenzy = 412507,
        RuneWarbringer = 425421,
        RuneRampage = 426940,
        RuneSwordAndBoard = 426978,
        RuneWreckingCrew = 427065,
        RuneVictoryRush = 402927,
        RuneDevastate = 403195,
        RuneSingleMindedFury = 413404,
        RuneQuickStrike = 429765,
        RuneFocusedRage = 29787,
        RunePreciseTiming = 402922,
        RuneBloodSurge = 413380,
        RuneFuriousThunder = 403219,
        RuneFrenziedAssault = 425412,
        RuneConsumedByRage = 425418,
        RuneEnragedRegeneration = 403467,
        RuneIntervene = 403472,
        RuneRallyingCry = 426491,
        RuneGladiatorStance = 412513
      },
      WarriorShout = {
        WarriorShoutNone = 0,
        WarriorShoutBattle = 1,
        WarriorShoutCommanding = 2
      },
      WarriorStance = {
        WarriorStanceNone = 0,
        WarriorStanceBattle = 1,
        WarriorStanceDefensive = 2,
        WarriorStanceBerserker = 3,
        WarriorStanceGladiator = 4
      },
      MageRune = {
        MageRuneNone = 0,
        RuneHelmAdvancedWarding = 428738,
        RuneHelmDeepFreeze = 428739,
        RuneHelmHotStreak = 400624,
        RuneHelmTemporalAnomaly = 429305,
        RuneShouldersArcanist = 1220150,
        RuneShouldersCryomancer = 1220160,
        RuneShouldersElementalist = 1220164,
        RuneShouldersFieryConvergence = 1220170,
        RuneShouldersIgniter = 1220176,
        RuneShouldersKindler = 1220168,
        RuneShouldersMagicalArmorer = 1220166,
        RuneShouldersPerpetualBlaze = 1220172,
        RuneShouldersPrecognitive = 1220148,
        RuneShouldersPyromaniac = 1220174,
        RuneShouldersSpellbinder = 1220154,
        RuneShouldersTorcher = 1220178,
        RuneShouldersWintersGrasp = 1220158,
        RuneCloakArcaneBarrage = 400610,
        RuneCloakOverheat = 400615,
        RuneCloakFrozenOrb = 440802,
        RuneChestBurnout = 412286,
        RuneChestEnlightenment = 412324,
        RuneChestFingersOfFrost = 400647,
        RuneChestRegeneration = 401417,
        RuneBracersMoltenArmor = 428741,
        RuneBracersDisplacement = 428863,
        RuneBracersBalefireBolt = 428878,
        RuneBracersRewindTime = 401462,
        RuneHandsArcaneBlast = 400574,
        RuneHandsIceLance = 400640,
        RuneHandsLivingBomb = 400613,
        RuneBeltFrostfireBolt = 401502,
        RuneBeltMissileBarrage = 400588,
        RuneBeltSpellfrostBolt = 412532,
        RuneLegsArcaneSurge = 425124,
        RuneLegsIcyVeins = 425121,
        RuneLegsLivingFlame = 401556,
        RuneLegsMassRegeneration = 412510,
        RuneFeetBrainFreeze = 400731,
        RuneFeetChronoPreservation = 436516,
        RuneFeetSpellPower = 412322
      },
      HunterRune = {
        HunterRuneNone = 0,
        RuneHelmRapidKilling = 415405,
        RuneHelmLockAndLoad = 415413,
        RuneHelmCatlikeReflexes = 415428,
        RuneshouldersAlphaTamer = 1220090,
        RuneShouldersAlternator = 1220078,
        RuneShouldersBeastTender = 1220086,
        RuneShouldersBountyHunter = 1220082,
        RuneShouldersDeadlyStriker = 1220104,
        RuneShouldersEchoes = 1220096,
        RuneShouldersHazardHarrier = 1220076,
        RuneShouldersHoundMaster = 1220088,
        RuneShouldersHuntsman = 1220092,
        RuneShouldersKineticist = 1220100,
        RuneShouldersLethalLasher = 1220098,
        RuneShouldersMisleader = 1220070,
        RuneShouldersPreyseeker = 1220072,
        RuneShouldersRetaliator = 1220094,
        RuneShouldersSharpshooter = 1220074,
        RuneShouldersStrategist = 1220102,
        RuneShouldersToxinologist = 1220080,
        RuneShouldersTrickShooter = 1220084,
        RuneCloakImprovedVolley = 440520,
        RuneCloakResourcefulness = 440529,
        RuneCloakHitAndRun = 440533,
        RuneChestBeastmastery = 409368,
        RuneChestMasterMarksman = 409428,
        RuneChestLoneWolf = 415370,
        RuneChestCobraStrikes = 425713,
        RuneBracersRaptorFury = 415358,
        RuneBracersFocusFire = 428726,
        RuneBracersTNT = 428717,
        RuneHandsCobraSlayer = 458393,
        RuneHandsChimeraShot = 409433,
        RuneHandsExplosiveShot = 409552,
        RuneHandsCarve = 425711,
        RuneBeltExposeWeakness = 409504,
        RuneBeltMeleeSpecialist = 415352,
        RuneBeltSteadyShot = 437123,
        RuneLegsKillShot = 409593,
        RuneLegsFlankingStrike = 415320,
        RuneLegsSniperTraining = 415399,
        RuneLegsSerpentSpread = 425738,
        RuneBootsTrapLauncher = 409541,
        RuneBootsDualWieldSpecialization = 409687,
        RuneBootsWyvernStrike = 458479
      },
      DruidRune = {
        DruidRuneNone = 0,
        RuneHelmGaleWinds = 417135,
        RuneHelmGore = 417145,
        RuneHelmImprovedBarkskin = 431388,
        RuneShouldersAnimalisticExpertise = 1220368,
        RuneShouldersAstralAscendant = 1220362,
        RuneShouldersBarbaric = 1220342,
        RuneShouldersBeast = 1220307,
        RuneShouldersClaw = 1220338,
        RuneShouldersCometcaller = 1220364,
        RuneShouldersExsanguinator = 1220346,
        RuneShouldersForest = 1220366,
        RuneShouldersFrenetic = 1220344,
        RuneShouldersFurious = 1220312,
        RuneShouldersGraceful = 1220360,
        RuneShouldersIlluminator = 1220332,
        RuneShouldersKeepers = 1220356,
        RuneShouldersLacerator = 1220310,
        RuneShouldersLunatic = 1220350,
        RuneShouldersMangler = 1220314,
        RuneShouldersNight = 1220355,
        RuneShouldersPredatoryInstincts = 1220334,
        RuneShouldersPrideful = 1220340,
        RuneShouldersRipper = 1220336,
        RuneShoulderFerocious = 1220301,
        RuneShouldersShifter = 1220303,
        RuneShouldersStarcaller = 1220352,
        RuneShouldersTerritorial = 1220305,
        RuneShouldersWrathful = 1220358,
        RuneCloakImprovedSwipe = 439510,
        RuneCloakTreeofLife = 439733,
        RuneCloakStarfall = 439748,
        RuneChestFuryOfStormrage = 414799,
        RuneChestLivingSeed = 414677,
        RuneChestSurvivalOfTheFittest = 411115,
        RuneChestWildStrikes = 407977,
        RuneBracersEfflorescence = 417149,
        RuneBracersElunesFires = 414719,
        RuneBracersImpFrenziedRegen = 431389,
        RuneHandsMangle = 407995,
        RuneHandsSunfire = 414684,
        RuneHandsWildGrowth = 408120,
        RuneHandsSkullBash = 410176,
        RuneBeltBerserk = 417141,
        RuneBeltEclipse = 408248,
        RuneBeltNourish = 408247,
        RuneLegsStarsurge = 417157,
        RuneLegsSavageRoar = 407988,
        RuneLegsLifebloom = 409824,
        RuneLegsLacerate = 414644,
        RuneFeetDreamstate = 408258,
        RuneFeetKingOfTheJungle = 417046,
        RuneFeetSurvivalInstincts = 408024
      },
      RogueRune = {
        RogueRuneNone = 0,
        RuneFocusedAttacks = 432256,
        RuneCombatPotency = 432259,
        RuneHonorAmongThieves = 432264,
        RuneShouldersAvoidant = 1219994,
        RuneShouldersBlackBelt = 1220023,
        RuneShouldersBloodthirsty = 1220030,
        RuneShouldersButcher = 1220002,
        RuneShouldersEfficient = 1220014,
        RuneShouldersEquilibrist = 1220020,
        RuneShouldersExecutioner = 1219998,
        RuneShouldersFencer = 1220026,
        RuneShouldersKnifeJuggler = 1220016,
        RuneShouldersOpportunist = 1220000,
        RuneShouldersPhantom = 1220004,
        RuneShouldersPoisedBrawler = 1220022,
        RuneShouldersScoundrel = 1220006,
        RuneShouldersShadowMaster = 1220018,
        RuneShouldersShivSavant = 1220010,
        RuneShouldersStalker = 1220012,
        RuneShouldersSwashbuckler = 1220028,
        RuneShouldersThrillSeeker = 1220008,
        RuneShouldersToxicologist = 1219996,
        RuneFanOfKnives = 409240,
        RuneCrimsonTempest = 412096,
        RuneBlunderbuss = 436564,
        RuneQuickDraw = 398196,
        RuneDeadlyBrew = 399965,
        RuneJustAFleshWound = 400014,
        RuneSlaughterFromTheShadows = 424925,
        RuneCutToTheChase = 432271,
        RuneUnfairAdvantage = 432273,
        RuneCarnage = 432276,
        RuneMutilate = 399956,
        RuneShadowstrike = 399985,
        RuneSaberSlash = 424785,
        RuneMainGauche = 424919,
        RuneCutthroat = 462708,
        RuneShurikenToss = 399986,
        RuneShadowstep = 400101,
        RunePoisonedKnife = 425012,
        RuneEnvenom = 399963,
        RuneBetweenTheEyes = 400009,
        RuneBladeDance = 400012,
        RuneRollingWithThePunches = 400016,
        RuneWaylay = 408700,
        RuneMasterOfSubtlety = 425096
      },
      ShamanRune = {
        RuneNone = 0,
        RuneHelmBurn = 415231,
        RuneHelmMentalDexterity = 415140,
        RuneHelmTidalWaves = 432042,
        RuneShouldersAncestralWarden = 1220295,
        RuneShouldersChieftain = 1220266,
        RuneShouldersCorrupt = 1220297,
        RuneShouldersElder = 1220288,
        RuneShouldersElementalMaster = 1220282,
        RuneShouldersElementalSeer = 1220258,
        RuneShouldersElements = 1220291,
        RuneShouldersFlamebringer = 1220276,
        RuneShouldersFurycharged = 1220268,
        RuneShouldersLavaSage = 1220293,
        RuneShouldersLavaWalker = 1220244,
        RuneShouldersMaelstrombringer = 1220242,
        RuneShouldersRagingFlame = 1220279,
        RuneShouldersRefinedShaman = 1220034,
        RuneShouldersSeismicSmasher = 1220274,
        RuneShouldersShieldMaster = 1220234,
        RuneShouldersShockAbsorber = 1220238,
        RuneShouldersSpiritualBulwark = 1220240,
        RuneShouldersSpiritGuide = 1220286,
        RuneShouldersStormbreaker = 1220270,
        RuneShouldersStormtender = 1220256,
        RuneShouldersTempest = 1220272,
        RuneShouldersTotemicProtector = 1220236,
        RuneShouldersTribesman = 1220284,
        RuneShouldersTrueAlpha = 1220246,
        RuneShouldersVolcano = 1220278,
        RuneShouldersWaterWalker = 1220254,
        RuneShouldersWindwalker = 1220232,
        RuneCloakCoherence = 415096,
        RuneCloakStormEarthAndFire = 440569,
        RuneCloakFeralSpirit = 440580,
        RuneChestDualWieldSpec = 408496,
        RuneChestHealingRain = 415236,
        RuneChestOverload = 408438,
        RuneChestShieldMastery = 408524,
        RuneChestTwoHandedMastery = 436364,
        RuneBracersOvercharged = 432140,
        RuneBracersRiptide = 408521,
        RuneBracersRollingThunder = 432056,
        RuneBracersStaticShock = 432134,
        RuneHandsLavaBurst = 408490,
        RuneHandsLavaLash = 408507,
        RuneHandsMoltenBlast = 425339,
        RuneHandsWaterShield = 408510,
        RuneWaistFireNova = 408339,
        RuneWaistMaelstromWeapon = 408498,
        RuneWaistPowerSurge = 415100,
        RuneLegsAncestralGuidance = 409324,
        RuneLegsEarthShield = 408514,
        RuneLegsWayOfEarth = 408531,
        RuneLegsGreaterGhostWolf = 415813,
        RuneFeetAncestralAwakening = 425858,
        RuneFeetDecoyTotem = 425874,
        RuneFeetSpiritOfTheAlpha = 408696
      },
      EarthTotem = {
        NoEarthTotem = 0,
        StrengthOfEarthTotem = 1,
        TremorTotem = 2,
        StoneskinTotem = 3
      },
      AirTotem = {
        NoAirTotem = 0,
        WindfuryTotem = 1,
        GraceOfAirTotem = 2
      },
      FireTotem = {
        NoFireTotem = 0,
        MagmaTotem = 1,
        SearingTotem = 2,
        FireNovaTotem = 3
      },
      WaterTotem = {
        NoWaterTotem = 0,
        ManaSpringTotem = 1,
        HealingStreamTotem = 2
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
      WarlockRune = {
        WarlockRuneNone = 0,
        RuneHelmVengeance = 426195,
        RuneHelmPandemic = 427712,
        RuneHelmBackdraft = 427713,
        RuneShouldersAbyssal = 1220060,
        RuneShouldersArsonist = 1220046,
        RuneShouldersChaosHarbinger = 1220044,
        RuneShouldersDecimator = 1220035,
        RuneShouldersDemonicExorcist = 1220052,
        RuneShouldersDemonlord = 1220050,
        RuneShouldersFlamewraith = 1220056,
        RuneShouldersFleshfeaster = 1220058,
        RuneShouldersInfernalShepherd = 1220048,
        RuneShouldersMalevolent = 1220040,
        RuneShouldersPained = 1220054,
        RuneShouldersPainSpreader = 1220068,
        RuneShouldersRefinedWarlock = 1220034,
        RuneShouldersRitualist = 1220066,
        RuneShouldersRotbringer = 1220038,
        RuneShouldersShadowmancer = 1220042,
        RuneShouldersTransfusionist = 1220032,
        RuneShouldersUmbralBlade = 1220064,
        RuneShouldersVoidborne = 1220062,
        RuneCloakMarkOfChaos = 440892,
        RuneCloakInfernalArmor = 440882,
        RuneCloakSoulSiphon = 403511,
        RuneChestLakeOfFire = 403666,
        RuneChestMasterChanneler = 403668,
        RuneChestDemonicTactics = 412727,
        RuneBracerUnstableAffliction = 427717,
        RuneBracerImmolationAura = 427726,
        RuneBracerIncinerate = 412758,
        RuneBracerSummonFelguard = 427733,
        RuneHandsHaunt = 403501,
        RuneHandsChaosBolt = 403629,
        RuneHandsShadowBoltVolley = 403628,
        RuneHandsMetamorphosis = 403789,
        RuneBeltInvocation = 426243,
        RuneBeltGrimoireOfSynergy = 426301,
        RuneBeltShadowAndFlame = 426316,
        RuneLegsEverlastingAffliction = 412689,
        RuneLegsDemonicGrace = 425463,
        RuneLegsDemonicPact = 425464,
        RuneBootsDemonicKnowledge = 412732,
        RuneBootsDanceOfTheWicked = 412798,
        RuneBootsShadowflame = 426320,
        RuneBootsDecimation = 440870
      },
      PaladinRune = {
        PaladinRuneNone = 0,
        RuneHeadFanaticism = 429142,
        RuneHeadImprovedSanctuary = 429133,
        RuneHeadWrath = 429139,
        RuneShouldersAltruist = 1220210,
        RuneShouldersArbiter = 1220212,
        RuneShouldersAscendant = 1220220,
        RuneShouldersBastion = 1220188,
        RuneShouldersDominus = 1220206,
        RuneShouldersEnmityPaladin = 1219976,
        RuneShouldersExcommunicator = 1220224,
        RuneShouldersExemplar = 1220200,
        RuneShouldersExile = 1220228,
        RuneShouldersGuardian = 1220194,
        RuneShouldersInquisitor = 1220202,
        RuneShouldersIronclad = 1220192,
        RuneShouldersJudicator = 1220218,
        RuneShouldersJusticar = 1220216,
        RuneShouldersLightbringer = 1220226,
        RuneShouldersLightwarden = 1220182,
        RuneShouldersPeacekeeper = 1220196,
        RuneShouldersPristineBlocker = 1219972,
        RuneShouldersRadiantDefender = 1220184,
        RuneShouldersReckoner = 1220190,
        RuneShouldersRefinedPaladin = 1220198,
        RuneShouldersRetributor = 1220222,
        RuneShouldersSealbearer = 1220214,
        RuneShouldersShieldbearer = 1220186,
        RuneShouldersSovereign = 1220204,
        RuneShouldersTemplar = 1220230,
        RuneShouldersVindicator = 1220208,
        RuneCloakShieldOfRighteousness = 440658,
        RuneCloakVindicator = 440666,
        RuneCloakShockAndAwe = 462834,
        RuneCloakRighteousVengeance = 440672,
        RuneChestDivineStorm = 407778,
        RuneChestAegis = 425589,
        RuneChestHallowedGround = 458287,
        RuneChestDivineLight = 458856,
        RuneWristHammerOfTheRighteous = 407632,
        RuneWristLightsGrace = 428909,
        RuneWristPurifyingPower = 429144,
        RuneWristImprovedHammerOfWrath = 429152,
        RuneHandsBeaconOfLight = 407613,
        RuneHandsHandOfReckoning = 407631,
        RuneHandsCrusaderStrike = 407676,
        RuneWaistInfusionOfLight = 426065,
        RuneWaistSheathOfLight = 426158,
        RuneWaistMalleableProtection = 458318,
        RuneLegsAuraMastery = 407624,
        RuneLegsAvengersShield = 407669,
        RuneLegsDivineSacrifice = 407804,
        RuneLegsInspirationExemplar = 407880,
        RuneLegsRebuke = 425609,
        RuneFeetSacredShield = 412019,
        RuneFeetGuardedByTheLight = 415059,
        RuneFeetTheArtOfWar = 426157,
        RuneUtilitySealOfMartyrdom = 407798,
        RuneUtilityExorcist = 415076,
        RuneUtilityAvengingWrath = 407788
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
        RetributionAura = 3,
        ConcentrationAura = 4,
        FrostResistanceAura = 5,
        ShadowResistanceAura = 6,
        FireResistanceAura = 7
      },
      PaladinSeal = {
        NoSeal = 0,
        Righteousness = 1,
        Command = 2,
        Martyrdom = 3,
        Crusader = 4
      },
      Expansion = {
        ExpansionUnknown = 0,
        ExpansionVanilla = 1,
        ExpansionTbc = 2,
        ExpansionWotlk = 3
      },
      DungeonDifficulty = {
        DifficultyUnknown = 0,
        DifficultyNormal = 1
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
      SourceFilterOption = {
        SourceUnknown = 0,
        SourceCrafting = 1,
        SourceQuest = 2,
        SourceDungeon = 3,
        SourceRaid = 4,
        SourceWorldBOE = 6,
        SourceReputation = 7
      },
      DungeonFilterOption = {
        DungeonUnknown = 0,
        DungeonRagefireChasm = 2437,
        DungeonDeadmines = 1581,
        DungeonWailingCaverns = 718,
        DungeonShadowfangKeep = 209,
        DungeonStockades = 717,
        DungeonRazorfenKraul = 491,
        DungeonScarletMonestary = 796,
        DungeonRazorfenDowns = 722,
        DungeonUldaman = 1337,
        DungeonZulFarrak = 1176,
        DungeonMaraudon = 2100,
        DungeonBlackrockDepths = 1584,
        DungeonScholomance = 2057,
        DungeonStratholme = 2017,
        DungeonBlackrockSpire = 1583,
        DungeonDireMaul = 2557
      },
      RaidFilterOption = {
        RaidUnknown = 0,
        RaidBlackfathomDeeps = 719,
        RaidGnomeregan = 721,
        RaidSunkenTemple = 1477,
        RaidMoltenCore = 2717,
        RaidBlackwingLair = 2677,
        RaidZulGurub = 1977,
        RaidRuinsOfAQ = 3428,
        RaidTempleOfAQ = 3429,
        RaidNaxxramas = 3456
      },
      ExcludedZones = {
        ZoneUnknown = 0
      },
      ResourceType = {
        ResourceTypeNone = 0,
        ResourceTypeMana = 1,
        ResourceTypeEnergy = 2,
        ResourceTypeRage = 3,
        ResourceTypeComboPoints = 4,
        ResourceTypeFocus = 5,
        ResourceTypeHealth = 6
      },
      ErrorOutcomeType = {
        ErrorOutcomeError = 0,
        ErrorOutcomeAborted = 1
      }
    },
    go_metadata = {
      rogue = {
        riposte = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
              registrationType = "RegisterSpell",
              functionName = "applyRiposte",
              spellId = 14251,
              cast = [[{
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6
              },
              Flags = "SpellFlagCarnage | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "1.5",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
              registrationType = "RegisterAura",
              functionName = "applyRiposte",
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Riposte Ready Aura"
            }
          }
        },
        riposte_ready = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
              registrationType = "RegisterAura",
              functionName = "applyRiposte",
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Riposte Ready Aura"
            }
          }
        },
        riposte_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/riposte.go",
              registrationType = "RegisterAura",
              functionName = "applyRiposte",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Riposte Trigger"
            }
          }
        },
        slice_and_dice = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/slice_and_dice.go",
              registrationType = "RegisterAura",
              functionName = "registerSliceAndDice",
              auraDuration = {
                raw = "rogue.sliceAndDiceDurations[5]",
                seconds = nil
              },
              label = "Slice and Dice"
            }
          }
        },
        taq_tank2_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_6.go",
              registrationType = "RegisterSpell",
              functionName = "applyTAQTank2PBonus",
              spellId = 1213754,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQTank2PBonus",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "2P Cleave Buff"
            }
          }
        },
        ["2_p_cleave"] = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQTank2PBonus",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "2P Cleave Buff"
            }
          }
        },
        taq_tank4_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_6.go",
              registrationType = "RegisterSpell",
              functionName = "applyTAQTank4PBonus",
              spellId = 1213761,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Blood Barrier"
            }
          }
        },
        blood_barrier = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_6.go",
              registrationType = "RegisterSpell",
              functionName = "applyTAQTank4PBonus",
              spellId = 1213761,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Blood Barrier"
            }
          }
        },
        shadowstep = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/shadowstep.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowstep",
              spellId = 400029,
              cast = [[{
			DefaultCast: core.Cast{
				Cost: baseCost,
				GCD:  time.Second * 1,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30
              },
              Flags = "core.SpellFlagAPL",
              IgnoreHaste = "true"
            }
          }
        },
        sword_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/sword_specialization.go",
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
        vanish = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/vanish.go",
              registrationType = "RegisterSpell",
              functionName = "registerVanishSpell",
              spellId = 1856,
              cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * time.Duration(300-float64(45*rogue.Talents.Elusiveness)),
			},
		}]],
              cooldown = {
                raw = "time.Second * time.Duration(300-float64(45*rogue.Talents.Elusiveness))",
                seconds = nil
              },
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolPhysical",
              IgnoreHaste = "true"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Tank4PBonus",
              spellId = 457437,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Vanish"
            }
          }
        },
        make_fan_of_knives_weapon_hit = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/fan_of_knives.go",
              registrationType = "RegisterSpell",
              functionName = "makeFanOfKnivesWeaponHitSpell",
              spellId = 409240,
              Flags = "flags",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "procMask",
              DamageMultiplier = "weaponMultiplier",
              ThreatMultiplier = "1"
            }
          }
        },
        fan_of_knives = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/fan_of_knives.go",
              registrationType = "RegisterSpell",
              functionName = "registerFanOfKnives",
              spellId = 409240,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagCarnage",
              ClassSpellMask = "SpellClassMask_RogueFanOfKnives",
              SpellSchool = "core.SpellSchoolPhysical",
              IgnoreHaste = "true"
            }
          }
        },
        master_of_subtlety = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/master_of_subtlety.go",
              registrationType = "RegisterAura",
              functionName = "registerMasterOfSubtlety",
              auraDuration = {
                raw = "effectDuration",
                seconds = nil
              },
              label = "Master of Subtlety"
            }
          }
        },
        feint = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/feint.go",
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
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMH",
              ThreatMultiplier = "1",
              IgnoreHaste = "true"
            }
          }
        },
        stealth = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/stealth.go",
              registrationType = "RegisterAura",
              functionName = "registerStealthAura",
              spellId = 1787,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Stealth"
            }
          }
        },
        premeditation = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/premeditation.go",
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
				Duration: time.Minute * 2,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120
              },
              Flags = "core.SpellFlagAPL",
              IgnoreHaste = "true"
            }
          }
        },
        preparation = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/preparation.go",
              registrationType = "RegisterSpell",
              functionName = "registerPreparationCD",
              spellId = 14185,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 10,
			},
			IgnoreHaste: true,
		}]],
              cooldown = {
                raw = "time.Minute * 10",
                seconds = 600
              },
              Flags = "core.SpellFlagAPL",
              IgnoreHaste = "true"
            }
          }
        },
        naxxramas_damage6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage6PBonus",
              spellId = 1219291,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        undead_slaying = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage6PBonus",
              spellId = 1219291,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        naxxramas_tank6_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_7.go",
              registrationType = "RegisterSpell",
              functionName = "applyNaxxramasTank6PBonus",
              spellId = 400023,
              cast = [[{
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute,
			},
		}]],
              cooldown = {
                raw = "time.Minute",
                seconds = 60
              },
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        main_gauche = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/main_gauche.go",
              registrationType = "RegisterAura",
              functionName = "registerMainGaucheSpell",
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Main Gauche Buff"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/main_gauche.go",
              registrationType = "RegisterAura",
              functionName = "registerMainGaucheSpell",
              spellId = 462752,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Main Gauche Sinister Strike Discount"
            }
          }
        },
        main_gauche_sinister_strike_discount = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/main_gauche.go",
              registrationType = "RegisterAura",
              functionName = "registerMainGaucheSpell",
              spellId = 462752,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Main Gauche Sinister Strike Discount"
            }
          }
        },
        make_crimson_tempest_hit = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/crimson_tempest.go",
              registrationType = "RegisterSpell",
              functionName = "makeCrimsonTempestHitSpell",
              spellId = 436611,
              Flags = "core.SpellFlagMeleeMetrics | SpellFlagCarnage",
              ClassSpellMask = "ClassSpellMask_RogueCrimsonTempestHit",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "procMask",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Crimson Tempest"
            }
          }
        },
        crimson_tempest = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/crimson_tempest.go",
              registrationType = "RegisterSpell",
              functionName = "makeCrimsonTempestHitSpell",
              spellId = 436611,
              Flags = "core.SpellFlagMeleeMetrics | SpellFlagCarnage",
              ClassSpellMask = "ClassSpellMask_RogueCrimsonTempestHit",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "procMask",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Crimson Tempest"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/crimson_tempest.go",
              registrationType = "RegisterSpell",
              functionName = "registerCrimsonTempestSpell",
              spellId = 412096,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
              Flags = "rogue.finisherFlags()",
              ClassSpellMask = "ClassSpellMask_RogueCrimsonTempest",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              IgnoreHaste = "true"
            }
          }
        },
        t1_tank4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Tank4PBonus",
              spellId = 457437,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Vanish"
            }
          }
        },
        poisons = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyPoisons",
              label = "Apply Sebacious on pull (PK Swap)"
            }
          }
        },
        sebacious_on_pull_pk_swap = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyPoisons",
              label = "Apply Sebacious on pull (PK Swap)"
            }
          }
        },
        deadly_brew_instant = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyDeadlyBrewInstant",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Deadly Brew (Instant)"
            }
          }
        },
        deadly_brew_deadly = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyDeadlyBrewDeadly",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Deadly Brew (Deadly)"
            }
          }
        },
        instant_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyInstantPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Instant Poison"
            }
          }
        },
        deadly_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyDeadlyPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Deadly Poison"
            }
          }
        },
        wound_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyWoundPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Wound Poison"
            }
          }
        },
        occult_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyOccultPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Occult Poison Trigger"
            }
          }
        },
        occult_poison_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyOccultPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Occult Poison Trigger"
            }
          }
        },
        sebacious_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applySebaciousPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Sebacious Poison Trigger"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerSebaciousPoisonSpell",
              auraDuration = {
                raw = "core.SebaciousPoisonDuration",
                seconds = nil
              },
              label = "Sebacious Poison Wrapper"
            }
          }
        },
        sebacious_poison_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applySebaciousPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Sebacious Poison Trigger"
            }
          }
        },
        atrophic_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyAtrophicPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Atrophic Poison Trigger"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerAtrophicPoisonSpell",
              auraDuration = {
                raw = "core.AtrophicPoisonDuration",
                seconds = nil
              },
              label = "Atrophic Poison Wrapper"
            }
          }
        },
        atrophic_poison_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyAtrophicPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Atrophic Poison Trigger"
            }
          }
        },
        numbing_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyNumbingPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Numbing Poison Trigger"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerNumbingPoisonSpell",
              auraDuration = {
                raw = "core.NumbingPoisonDuration",
                seconds = nil
              },
              label = "Numbing Poison Wrapper"
            }
          }
        },
        numbing_poison_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "applyNumbingPoison",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Numbing Poison Trigger"
            }
          }
        },
        sebacious_poison_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerSebaciousPoisonSpell",
              auraDuration = {
                raw = "core.SebaciousPoisonDuration",
                seconds = nil
              },
              label = "Sebacious Poison Wrapper"
            }
          }
        },
        atrophic_poison_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerAtrophicPoisonSpell",
              auraDuration = {
                raw = "core.AtrophicPoisonDuration",
                seconds = nil
              },
              label = "Atrophic Poison Wrapper"
            }
          }
        },
        numbing_poison_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterAura",
              functionName = "registerNumbingPoisonSpell",
              auraDuration = {
                raw = "core.NumbingPoisonDuration",
                seconds = nil
              },
              label = "Numbing Poison Wrapper"
            }
          }
        },
        make_wound_poison = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterSpell",
              functionName = "makeWoundPoison",
              spellId = 13219,
              Flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagDeadlyBrewed | SpellFlagRoguePoison",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        make_sebacious_poison = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterSpell",
              functionName = "makeSebaciousPoison",
              spellId = 439500,
              Flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagDeadlyBrewed | SpellFlagRoguePoison",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        make_atrophic_poison = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterSpell",
              functionName = "makeAtrophicPoison",
              spellId = 439473,
              Flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagDeadlyBrewed | SpellFlagRoguePoison",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        make_numbing_poison = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/poisons.go",
              registrationType = "RegisterSpell",
              functionName = "makeNumbingPoison",
              spellId = 439472,
              Flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagDeadlyBrewed | SpellFlagRoguePoison",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        blunderbuss = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/blunderbuss.go",
              registrationType = "RegisterSpell",
              functionName = "registerBlunderbussSpell",
              spellId = 436564,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 15,
			},
			IgnoreHaste: true,
		}]],
              cooldown = {
                raw = "time.Second * 15",
                seconds = 15
              },
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | SpellFlagCarnage",
              ClassSpellMask = "SpellClassMask_RogueBlunderbuss",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskRangedSpecial",
              DamageMultiplier = "1",
              ThreatMultiplier = "2",
              IgnoreHaste = "true"
            }
          }
        },
        saber_slash = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/saber_slash.go",
              registrationType = "RegisterAura",
              functionName = "registerSaberSlashSpell",
              label = "Saber Slash DoT Damage Amp"
            }
          }
        },
        regicide_rogue = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideRogueEffect",
              spellId = 1231424,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            }
          }
        },
        coup = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideRogueEffect",
              spellId = 1231424,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            }
          }
        },
        envenom = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/envenom.go",
              registrationType = "RegisterAura",
              functionName = "registerEnvenom",
              label = "Envenom"
            }
          }
        },
        evasion = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/evasion.go",
              registrationType = "RegisterSpell",
              functionName = "RegisterEvasionSpell",
              spellId = 5277,
              cast = [[{
			DefaultCast: core.Cast{},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: []time.Duration{time.Minute * 5, time.Minute*5 - time.Second*45, time.Minute*5 - time.Second*90}[rogue.Talents.Endurance],
			},
			IgnoreHaste: true,
		}]],
              cooldown = {
                raw = "[]time.Duration{time.Minute * 5",
                seconds = nil
              },
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "SpellClassMask_RogueEvasion",
              SpellSchool = "core.SpellSchoolPhysical",
              IgnoreHaste = "true"
            }
          }
        },
        scarlet_enclave_tank6_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveTank6PBonus",
              spellId = 1226957,
              Flags = "core.SpellFlagNoLifecycleCallbacks"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveTank6PBonus",
              spellId = 1226957,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Float Like a Butterfly, Sting Like a Bee"
            }
          }
        },
        float_like_a_butterfly_sting_like_a_bee = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/item_sets_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveTank6PBonus",
              spellId = 1226957,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Float Like a Butterfly, Sting Like a Bee"
            }
          }
        },
        thistle_tea = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/thistle_tea.go",
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
          }
        },
        combat_potency = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
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
        focused_attacks = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
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
        honor_among_thieves = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerHonorAmongThieves",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Honor Among Thieves"
            }
          }
        },
        blade_dance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerBladeDance",
              spellId = 462230,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Defender's Resolve"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerBladeDance",
              auraDuration = {
                raw = "rogue.bladeDanceDurations[5]",
                seconds = nil
              },
              label = "Blade Dance"
            }
          }
        },
        defender_s_resolve = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerBladeDance",
              spellId = 462230,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Defender's Resolve"
            }
          }
        },
        just_a_flesh_wound = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyJustAFleshWound",
              label = "Just a Flesh Wound"
            }
          }
        },
        rolling_with_the_punches = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyRollingWithThePunches",
              spellId = 400015,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Rolling with the Punches Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyRollingWithThePunches",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Rolling with the Punches"
            }
          }
        },
        cutthroat = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerCutthroat",
              spellId = 462707,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Cutthroat"
            }
          }
        },
        unfair_advantage = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/unfair_advantage.go",
              registrationType = "RegisterSpell",
              functionName = "applyUnfairAdvantage",
              spellId = 432274,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "1",
              ThreatMultiplier = "1.5"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/unfair_advantage.go",
              registrationType = "RegisterAura",
              functionName = "applyUnfairAdvantage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Unfair Advantage Trigger"
            }
          }
        },
        unfair_advantage_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/unfair_advantage.go",
              registrationType = "RegisterAura",
              functionName = "applyUnfairAdvantage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Unfair Advantage Trigger"
            }
          }
        },
        cold_blood = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerColdBloodCD",
              spellId = 14177,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Cold Blood"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
            }
          }
        },
        seal_fate = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
        initiative = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
        blade_flurry = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerBladeFlurryCD",
              spellId = 22482,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
              ClassSpellMask = "ClassSpellMask_RogueBladeFlurry",
              IgnoreHaste = "true"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerBladeFlurryCD",
              spellId = 13877,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Blade Flurry"
            }
          }
        },
        adrenaline_rush = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerAdrenalineRushCD",
              spellId = 13750,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Adrenaline Rush"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/rogue/talents.go",
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
              ClassSpellMask = "ClassSpellMask_RogueAdrenalineRush",
              IgnoreHaste = "true"
            }
          }
        }
      },
      druid = {
        barkskin = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/barkskin.go",
              registrationType = "RegisterAura",
              functionName = "registerBarkskinCD",
              spellId = 22812,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Barkskin"
            }
          }
        },
        savage_roar = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/savage_roar.go",
              registrationType = "RegisterAura",
              functionName = "applySavageRoar",
              spellId = 407988,
              label = "Savage Roar Aura"
            }
          }
        },
        cat_form = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/forms.go",
              registrationType = "RegisterAura",
              functionName = "registerCatFormSpell",
              spellId = 768,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Cat Form"
            }
          }
        },
        bear_form = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/forms.go",
              registrationType = "RegisterAura",
              functionName = "registerBearFormSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Bear Form"
            }
          }
        },
        moonkin_form = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/forms.go",
              registrationType = "RegisterAura",
              functionName = "registerMoonkinFormSpell",
              spellId = 24858,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Moonkin Form"
            }
          }
        },
        naxxramas_feral6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasFeral6PBonus",
              spellId = 1218479,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        undead_slaying = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasFeral6PBonus",
              spellId = 1218479,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        new_frenzied_regen_spell_config = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/frenzied_regeneration.go",
              registrationType = "RegisterAura",
              functionName = "newFrenziedRegenSpellConfig",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Frenzied Regeneration"
            }
          }
        },
        frenzied_regeneration = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/frenzied_regeneration.go",
              registrationType = "RegisterAura",
              functionName = "newFrenziedRegenSpellConfig",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Frenzied Regeneration"
            }
          }
        },
        enrage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/enrage.go",
              registrationType = "RegisterAura",
              functionName = "registerEnrageSpell",
              spellId = 5229,
              auraDuration = {
                raw = "10 * time.Second",
                seconds = 10
              },
              label = "Enrage Aura"
            }
          }
        },
        t2_balance6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Balance6PBonus",
              spellId = 467088,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Astral Power"
            }
          }
        },
        astral_power = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Balance6PBonus",
              spellId = 467088,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Astral Power"
            }
          }
        },
        t2_guardian2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Guardian2PBonus",
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "2P Cleave Buff"
            }
          }
        },
        ["2_p_cleave"] = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Guardian2PBonus",
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "2P Cleave Buff"
            }
          }
        },
        berserk = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/berserk.go",
              registrationType = "RegisterAura",
              functionName = "applyBerserk",
              spellId = 417141,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Berserk"
            }
          }
        },
        starsurge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/starsurge.go",
              registrationType = "RegisterAura",
              functionName = "applyStarsurge",
              spellId = 417157,
              auraDuration = {
                raw = "starfireAuraDuration",
                seconds = nil
              },
              label = "Starsurge"
            }
          }
        },
        new_bloodbark_cleave_item = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/items.go",
              registrationType = "RegisterAura",
              functionName = "newBloodbarkCleaveItem",
              spellId = 436482,
              auraDuration = {
                raw = "20 * time.Second",
                seconds = 20
              },
              label = "Bloodbark Cleave"
            }
          }
        },
        bloodbark_cleave = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/items.go",
              registrationType = "RegisterAura",
              functionName = "newBloodbarkCleaveItem",
              spellId = 436482,
              auraDuration = {
                raw = "20 * time.Second",
                seconds = 20
              },
              label = "Bloodbark Cleave"
            }
          }
        },
        scarlet_enclave_balance6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveBalance6PBonus",
              spellId = 1226105,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Sunsurge"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveBalance6PBonus",
              spellId = 1226106,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Moonsurge"
            }
          }
        },
        sunsurge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveBalance6PBonus",
              spellId = 1226105,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Sunsurge"
            }
          }
        },
        moonsurge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveBalance6PBonus",
              spellId = 1226106,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Moonsurge"
            }
          }
        },
        scarlet_enclave_guardian6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveGuardian6PBonus",
              spellId = 1226127,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Savage Flurry"
            }
          }
        },
        savage_flurry = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveGuardian6PBonus",
              spellId = 1226127,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Savage Flurry"
            }
          }
        },
        gale_winds = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyGaleWinds",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Gale Winds"
            }
          }
        },
        gore = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyGore",
              label = "Gore Trigger"
            }
          }
        },
        gore_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyGore",
              label = "Gore Trigger"
            }
          }
        },
        fury_of_storm_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFuryOfStormRage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Fury Of Stormrage"
            }
          }
        },
        fury_of_stormrage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFuryOfStormRage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Fury Of Stormrage"
            }
          }
        },
        eclipse = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEclipse",
              spellId = 408250,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Solar Eclipse proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEclipse",
              spellId = 408255,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Lunar Eclipse proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEclipse",
              spellId = 408248,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Eclipse"
            }
          }
        },
        solar_eclipse = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEclipse",
              spellId = 408250,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Solar Eclipse proc"
            }
          }
        },
        lunar_eclipse = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEclipse",
              spellId = 408255,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Lunar Eclipse proc"
            }
          }
        },
        elunes_fires = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyElunesFires",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Elune's Fires"
            }
          }
        },
        elune_s_fires = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyElunesFires",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Elune's Fires"
            }
          }
        },
        dreamstate = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDreamstate",
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Dreamstate Mana Regen"
            }
          }
        },
        dreamstate_mana_regen = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDreamstate",
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Dreamstate Mana Regen"
            }
          }
        },
        dreamstate_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDreamstate",
              label = "Dreamstate Trigger"
            }
          }
        },
        taq_guardian2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQGuardian2PBonus",
              spellId = 1213188,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Guardian 2P Bonus Proc"
            }
          }
        },
        guardian_2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQGuardian2PBonus",
              spellId = 1213188,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Guardian 2P Bonus Proc"
            }
          }
        },
        tigers_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/tigers_fury.go",
              registrationType = "RegisterAura",
              functionName = "registerTigersFurySpell",
              auraDuration = {
                raw = "6 * time.Second",
                seconds = 6
              },
              label = "Tiger's Fury Aura"
            }
          }
        },
        tiger_s_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/tigers_fury.go",
              registrationType = "RegisterAura",
              functionName = "registerTigersFurySpell",
              auraDuration = {
                raw = "6 * time.Second",
                seconds = 6
              },
              label = "Tiger's Fury Aura"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/tigers_fury.go",
              registrationType = "RegisterAura",
              functionName = "registerTigersFurySpellKotJ",
              spellId = 417045,
              auraDuration = {
                raw = "6 * time.Second",
                seconds = 6
              },
              label = "Tiger's Fury Aura"
            }
          }
        },
        tigers_fury_spell_kot_j = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/tigers_fury.go",
              registrationType = "RegisterAura",
              functionName = "registerTigersFurySpellKotJ",
              spellId = 417045,
              auraDuration = {
                raw = "6 * time.Second",
                seconds = 6
              },
              label = "Tiger's Fury Aura"
            }
          }
        },
        make_queue_spells_and = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/maul.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Maul Queue Aura-"
            }
          }
        },
        maul_queue_aura = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/maul.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Maul Queue Aura-"
            }
          }
        },
        survival_instincts = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/survival_instincts.go",
              registrationType = "RegisterAura",
              functionName = "applySurvivalInstincts",
              spellId = 408024,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Survival Instincts"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/survival_instincts.go",
              registrationType = "RegisterAura",
              functionName = "applySurvivalInstincts",
              label = "Survival Instincts - Passive"
            }
          }
        },
        survival_instincts_passive = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/survival_instincts.go",
              registrationType = "RegisterAura",
              functionName = "applySurvivalInstincts",
              label = "Survival Instincts - Passive"
            }
          }
        },
        natures_grace = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNaturesGrace",
              spellId = 16886,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Natures Grace Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNaturesGrace",
              label = "Natures Grace"
            }
          }
        },
        natures_swiftness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
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
        primal_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
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
        blood_frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyBloodFrenzy",
              label = "Blood Frenzy"
            }
          }
        },
        furor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFuror",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Furor"
            }
          }
        },
        omen_of_clarity = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyOmenOfClarity",
              spellId = 16870,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            }
          }
        },
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyOmenOfClarity",
              spellId = 16870,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            }
          }
        },
        moonfury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMoonfury",
              label = "Moonfury"
            }
          }
        },
        improved_moonfire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedMoonfire",
              label = "Improved moonfire"
            }
          }
        },
        vengeance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVengeance",
              label = "Vengeance"
            }
          }
        },
        moonglow = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMoonglow",
              label = "Moonglow"
            }
          }
        }
      },
      items_sets = {
        const = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/common/sod/items_sets/phase_8.go",
              registrationType = "RegisterAura",
              functionName = "const",
              spellId = 1231556,
              label = "Tools of the Nathrezim"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/common/sod/items_sets/phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "const",
              spellId = 1231557,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagSuppressWeaponProcs",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHAuto",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/common/sod/items_sets/phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "const",
              spellId = 1231558,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagSuppressWeaponProcs",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHAuto",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        tools_of_the_nathrezim = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/common/sod/items_sets/phase_8.go",
              registrationType = "RegisterAura",
              functionName = "const",
              spellId = 1231556,
              label = "Tools of the Nathrezim"
            }
          }
        }
      },
      guardians = {
        acid_spit = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/common/guardians/emerald_dragon_whelp.go",
              registrationType = "RegisterSpell",
              functionName = "registerAcidSpitSpell",
              spellId = 9591,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
              Flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagResetAttackSwing",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        }
      },
      encounters = {
        spells = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 23513,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              ProcMask = "core.ProcMaskEmpty",
              label = "Essence of the Red"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 367987,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              ProcMask = "core.ProcMaskEmpty",
              label = "Burning Adrenaline"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 469261,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              Flags = "core.SpellFlagIgnoreResists",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              label = "Burning Adrenaline (Tank)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 19983,
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
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 23462,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 3,
			},
		}]],
              cooldown = {
                raw = "time.Second * 3",
                seconds = 3
              },
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 23461,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Millisecond * 3240, // Next server tick after cast complete
				CastTime: time.Millisecond * 2000,
			},
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 9,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.Unit.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
			},
		}]],
              cooldown = {
                raw = "time.Second * 9",
                seconds = 9
              },
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              label = "Flame Breath"
            }
          }
        },
        essence_of_the_red = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 23513,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              ProcMask = "core.ProcMaskEmpty",
              label = "Essence of the Red"
            }
          }
        },
        burning_adrenaline = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 367987,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              ProcMask = "core.ProcMaskEmpty",
              label = "Burning Adrenaline"
            }
          }
        },
        burning_adrenaline_tank = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 469261,
              cast = [[{
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Minute * 4,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 4",
                seconds = 240
              },
              Flags = "core.SpellFlagIgnoreResists",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              label = "Burning Adrenaline (Tank)"
            }
          }
        },
        flame_breath = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/blackwing_lair.go",
              registrationType = "RegisterSpell",
              functionName = "registerSpells",
              spellId = 23461,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Millisecond * 3240, // Next server tick after cast complete
				CastTime: time.Millisecond * 2000,
			},
			CD: core.Cooldown{
				Timer:    ai.Target.NewTimer(),
				Duration: time.Second * 9,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.Unit.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
			},
		}]],
              cooldown = {
                raw = "time.Second * 9",
                seconds = 9
              },
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              label = "Flame Breath"
            }
          }
        }
      },
      scarlet_enclave = {
        scarlet_dominion = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/scarlet_enclave/scarlet_enclave.go",
              registrationType = "RegisterAura",
              functionName = "registerScarletDominionAura",
              spellId = 1232014,
              label = "Scarlet Dominion"
            }
          }
        }
      },
      naxxramas = {
        summon_spore = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/loatheb_ai.go",
              registrationType = "RegisterAura",
              functionName = "registerSummonSpore",
              spellId = 29232,
              auraDuration = {
                raw = "time.Second * 90",
                seconds = 90
              },
              label = "Fungal Bloom"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/loatheb_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonSpore",
              spellId = 29234,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 4240, // Next server tick after cast complete
			},
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 13,
			},
		}]],
              cooldown = {
                raw = "time.Second * 13",
                seconds = 13
              },
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        fungal_bloom = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/loatheb_ai.go",
              registrationType = "RegisterAura",
              functionName = "registerSummonSpore",
              spellId = 29232,
              auraDuration = {
                raw = "time.Second * 90",
                seconds = 90
              },
              label = "Fungal Bloom"
            }
          }
        },
        remove_curse = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/loatheb_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerRemoveCurse",
              spellId = 30281,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 4240, // Next server tick after cast complete
			},
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30
              },
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        authority_of_the_frozen_wastes = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/naxxramas.go",
              registrationType = "RegisterAura",
              functionName = "registerAuthorityOfTheFrozenWastesAura",
              spellId = 1218283,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Authority of the Frozen Wastes"
            }
          }
        },
        hateful_strike_primer = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/patchwerk_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerHatefulStrikePrimerSpell",
              spellId = 28307,
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
              ProcMask = "core.ProcMaskRanged"
            }
          }
        },
        hateful_strike = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/patchwerk_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerHatefulStrikeSpell",
              spellId = 28308,
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
              DamageMultiplier = "1"
            }
          }
        },
        frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/patchwerk_ai.go",
              registrationType = "RegisterAura",
              functionName = "registerFrenzySpell",
              spellId = 28131,
              auraDuration = {
                raw = "5 * time.Minute",
                seconds = 300
              },
              label = "Frenzy"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/patchwerk_ai.go",
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
          }
        },
        chain_lightning = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/thaddius_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerChainLightning",
              spellId = 28167,
              cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
              cooldown = {
                raw = "time.Second * 8",
                seconds = 8
              },
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1"
            }
          }
        },
        polarity = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/thaddius_ai.go",
              registrationType = "RegisterAura",
              functionName = "registerPolarity",
              spellId = 28059,
              auraDuration = {
                raw = "time.Minute * 1",
                seconds = 60
              },
              label = "Polarity Stacks"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/thaddius_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerPolarity",
              spellId = 28089,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Millisecond * 4240, // Next server tick after cast complete
				CastTime: time.Millisecond * 3000,
			},
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 30,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.Unit.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, false)
			},
		}]],
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30
              },
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        polarity_stacks = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/encounters/naxxramas/thaddius_ai.go",
              registrationType = "RegisterAura",
              functionName = "registerPolarity",
              spellId = 28059,
              auraDuration = {
                raw = "time.Minute * 1",
                seconds = 60
              },
              label = "Polarity Stacks"
            }
          }
        }
      },
      shaman = {
        molten_blast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/molten_blast.go",
              registrationType = "RegisterAura",
              functionName = "applyMoltenBlast",
              label = "Molten Blast Reset Trigger"
            }
          }
        },
        molten_blast_reset_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/molten_blast.go",
              registrationType = "RegisterAura",
              functionName = "applyMoltenBlast",
              label = "Molten Blast Reset Trigger"
            }
          }
        },
        feral_spirit = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/feral_spirit.go",
              registrationType = "RegisterAura",
              functionName = "registerFeralSpiritCD",
              auraDuration = {
                raw = "time.Second * 45",
                seconds = 45
              },
              label = "Feral Spirit"
            }
          }
        },
        phase4 = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pvp.go",
              registrationType = "RegisterAura",
              functionName = "applyPhase4PvP4PBonus",
              spellId = 22804,
              label = "Shaman Shock Crit Bonus"
            }
          }
        },
        shaman_shock_crit_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pvp.go",
              registrationType = "RegisterAura",
              functionName = "applyPhase4PvP4PBonus",
              spellId = 22804,
              label = "Shaman Shock Crit Bonus"
            }
          }
        },
        frostbrand_debuff = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/frostbrand_weapon.go",
              registrationType = "RegisterAura",
              functionName = "FrostbrandDebuffAura",
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Frostbrand Attack-"
            }
          }
        },
        frostbrand_attack = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/frostbrand_weapon.go",
              registrationType = "RegisterAura",
              functionName = "FrostbrandDebuffAura",
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Frostbrand Attack-"
            }
          }
        },
        frostbrand_imbue = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/frostbrand_weapon.go",
              registrationType = "RegisterAura",
              functionName = "RegisterFrostbrandImbue",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Frostbrand Imbue"
            }
          }
        },
        water_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/water_shield.go",
              registrationType = "RegisterAura",
              functionName = "registerWaterShieldSpell",
              auraDuration = {
                raw = "time.Minute * 10",
                seconds = 600
              },
              label = "Water Shield"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/water_shield.go",
              registrationType = "RegisterSpell",
              functionName = "registerWaterShieldSpell",
              spellId = 408511,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagNoMetrics",
              SpellSchool = "core.SpellSchoolNature"
            }
          }
        },
        naxxramas_elemental6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasElemental6PBonus",
              spellId = 1219370,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        undead_slaying = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasElemental6PBonus",
              spellId = 1219370,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasEnhancement6PBonus",
              spellId = 1219370,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        naxxramas_enhancement6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasEnhancement6PBonus",
              spellId = 1219370,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        shamanistic_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/shamanistic_rage.go",
              registrationType = "RegisterAura",
              functionName = "registerShamanisticRageCD",
              spellId = 425336,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Shamanistic Rage"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/shamanistic_rage.go",
              registrationType = "RegisterSpell",
              functionName = "registerShamanisticRageCD",
              majorCooldown = {
                type = "core.CooldownTypeMana",
                priority = nil
              },
              spellId = 425336,
              cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              ClassSpellMask = "ClassSpellMask_ShamanShamanisticRage",
              IgnoreHaste = "true"
            }
          }
        },
        t2_tank2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Tank2PBonus",
              spellId = 467891,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Shield Block"
            }
          }
        },
        shield_block = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Tank2PBonus",
              spellId = 467891,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Shield Block"
            }
          }
        },
        t2_tank4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Tank4PBonus",
              spellId = 467910,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Elemental Shield"
            }
          }
        },
        elemental_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Tank4PBonus",
              spellId = 467910,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Elemental Shield"
            }
          }
        },
        flametongue_imbue = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/flametongue_weapon.go",
              registrationType = "RegisterAura",
              functionName = "RegisterFlametongueImbue",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Flametongue Imbue"
            }
          }
        },
        ancestral_guidance = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/ancestral_guidance.go",
              registrationType = "RegisterSpell",
              functionName = "applyAncestralGuidance",
              spellId = 409337,
              Flags = "core.SpellFlagIgnoreResists",
              ClassSpellMask = "ClassSpellMask_ShamanAncestralGuidanceDamage",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/ancestral_guidance.go",
              registrationType = "RegisterSpell",
              functionName = "applyAncestralGuidance",
              spellId = 409333,
              Flags = "core.SpellFlagHelpful",
              ClassSpellMask = "ClassSpellMask_ShamanAncestralGuidanceHeal",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellHealing"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/ancestral_guidance.go",
              registrationType = "RegisterAura",
              functionName = "applyAncestralGuidance",
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Ancestral Guidance"
            }
          }
        },
        mercy_shaman = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyShamanEffect",
              spellId = 1231498,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        mercy_by_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyShamanEffect",
              spellId = 1231498,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        crimson_cleaver_shaman = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverShamanEffect",
              spellId = 1231456,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        crimson_crusade = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverShamanEffect",
              spellId = 1231456,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        rolling_thunder = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/rolling_thunder.go",
              registrationType = "RegisterSpell",
              functionName = "registerRollingThunder",
              spellId = 432129,
              ClassSpellMask = "ClassSpellMask_ShamanRollingThunder",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/rolling_thunder.go",
              registrationType = "RegisterAura",
              functionName = "registerRollingThunder",
              label = "Rolling Thunder Trigger"
            }
          }
        },
        rolling_thunder_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/rolling_thunder.go",
              registrationType = "RegisterAura",
              functionName = "registerRollingThunder",
              label = "Rolling Thunder Trigger"
            }
          }
        },
        earth_shield = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/earth_shield.go",
              registrationType = "RegisterSpell",
              functionName = "registerEarthShieldSpell",
              spellId = 49284,
              cast = [[{
	// 		DefaultCast: core.Cast{
	// 			GCD: core.GCDDefault,
	// 		},
	// 	}]],
              Flags = "core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Earth Shield"
            }
          }
        },
        scarlet_enclave_elemental2_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveElemental2PBonus",
              spellId = 1226972,
              Flags = "core.SpellFlagTreatAsPeriodic | core.SpellFlagPureDot | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_ShamanFlameShock",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Flame Shock (2pT4)"
            }
          }
        },
        flame_shock_2p_t4 = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveElemental2PBonus",
              spellId = 1226972,
              Flags = "core.SpellFlagTreatAsPeriodic | core.SpellFlagPureDot | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_ShamanFlameShock",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Flame Shock (2pT4)"
            }
          }
        },
        scarlet_enclave_elemental4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveElemental4PBonus",
              spellId = 1233835,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Thunder and Lava"
            }
          }
        },
        thunder_and_lava = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveElemental4PBonus",
              spellId = 1233835,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Thunder and Lava"
            }
          }
        },
        mental_dexterity = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMentalDexterity",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Mental Dexterity Proc"
            }
          }
        },
        storm_earth_and_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyStormEarthAndFire",
              label = "Storm, Earth, and Fire"
            }
          }
        },
        dual_wield_spec = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDualWieldSpec",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "DW Spec Trigger"
            }
          }
        },
        dw_spec_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDualWieldSpec",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "DW Spec Trigger"
            }
          }
        },
        shield_mastery = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              spellId = 408525,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Shield Mastery Block"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              label = "Shield Mastery Trigger"
            }
          }
        },
        shield_mastery_block = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              spellId = 408525,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Shield Mastery Block"
            }
          }
        },
        shield_mastery_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              label = "Shield Mastery Trigger"
            }
          }
        },
        two_handed_mastery = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyTwoHandedMastery",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Two-Handed Mastery Proc"
            }
          }
        },
        two_handed_mastery_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyTwoHandedMastery",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Two-Handed Mastery Trigger"
            }
          }
        },
        static_shocks = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyStaticShocks",
              label = "Static Shocks"
            }
          }
        },
        maelstrom_weapon = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMaelstromWeapon",
              spellId = 408505,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "MaelstromWeapon Proc"
            }
          }
        },
        power_surge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPowerSurge",
              spellId = 415105,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Power Surge Proc (Damage)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPowerSurge",
              spellId = 468526,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Power Surge Proc (Heal)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPowerSurge",
              label = "Power Surge"
            }
          }
        },
        power_surge_proc_damage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPowerSurge",
              spellId = 415105,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Power Surge Proc (Damage)"
            }
          }
        },
        power_surge_proc_heal = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPowerSurge",
              spellId = 468526,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Power Surge Proc (Heal)"
            }
          }
        },
        way_of_earth = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyWayOfEarth",
              label = "Way of Earth"
            }
          }
        },
        spirit_of_the_alpha = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySpiritOfTheAlpha",
              spellId = 443320,
              label = "Loyal Beta"
            }
          }
        },
        loyal_beta = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySpiritOfTheAlpha",
              spellId = 443320,
              label = "Loyal Beta"
            }
          }
        },
        taq_tank2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQTank2PBonus",
              spellId = 1213934,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Stormbraced"
            }
          }
        },
        stormbraced = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQTank2PBonus",
              spellId = 1213934,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Stormbraced"
            }
          }
        },
        taq_enhancement4_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_6.go",
              registrationType = "RegisterSpell",
              functionName = "applyTAQEnhancement4PBonus",
              spellId = 1213915,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Burning"
            }
          }
        },
        burning = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/item_sets_pve_phase_6.go",
              registrationType = "RegisterSpell",
              functionName = "applyTAQEnhancement4PBonus",
              spellId = 1213915,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Burning"
            }
          }
        },
        stormstrike = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/stormstrike.go",
              registrationType = "RegisterSpell",
              functionName = "registerStormstrikeSpell",
              spellId = 17364,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_ShamanStormstrike",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial"
            }
          }
        },
        new_stormstrike_hit = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/stormstrike.go",
              registrationType = "RegisterSpell",
              functionName = "newStormstrikeHitSpell",
              spellId = 17364,
              Flags = "flags",
              ClassSpellMask = "ClassSpellMask_ShamanStormstrikeHit",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "procMask",
              DamageMultiplier = "damageMultiplier",
              ThreatMultiplier = "1"
            }
          }
        },
        elemental_focus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              spellId = 16246,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              label = "Elemental Focus Trigger"
            }
          }
        },
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              spellId = 16246,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            }
          }
        },
        elemental_focus_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              label = "Elemental Focus Trigger"
            }
          }
        },
        elemental_devastation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
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
        elemental_mastery = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerElementalMasteryCD",
              spellId = 16166,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Elemental Mastery"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
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
              }
            }
          }
        },
        natures_swiftness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerNaturesSwiftnessCD",
              spellId = 16188,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Natures Swiftness"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
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
              }
            }
          }
        },
        flurry = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFlurry",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Flurry Proc Trigger"
            }
          }
        },
        flurry_proc_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFlurry",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Flurry Proc Trigger"
            }
          }
        }
      },
      hunter = {
        new_furious_howl = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/pet_abilities.go",
              registrationType = "RegisterSpell",
              functionName = "newFuriousHowl",
              majorCooldown = {
                type = "core.CooldownTypeDPS",
                priority = nil
              },
              spellId = 64495,
              cast = [[{
// 			CD: core.Cooldown{
// 				Timer:    hp.NewTimer(),
// 				Duration: time.Second * 40,
// 			},
// 		}]],
              cooldown = {
                raw = "time.Second * 40",
                seconds = 40
              }
            }
          }
        },
        steady_shot = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/steady_shot.go",
              registrationType = "RegisterSpell",
              functionName = "registerSteadyShotSpell",
              spellId = 437123,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2000,
			},
			ModifyCast: func(_ *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / hunter.RangedSwingSpeed())
			},
		}]],
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_HunterSteadyShot",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskRangedSpecial",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true"
            }
          }
        },
        chimera_shot = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/chimera_shot.go",
              registrationType = "RegisterSpell",
              functionName = "registerChimeraShotSpell",
              spellId = 409433,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6
              },
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreResists | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_HunterChimeraShot",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskRangedSpecial",
              DamageMultiplier = "1.35",
              ThreatMultiplier = "1",
              IgnoreHaste = "true"
            }
          }
        },
        naxxramas_melee6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasMelee6PBonus",
              spellId = 1218587,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        undead_slaying = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasMelee6PBonus",
              spellId = 1218587,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasRanged6PBonus",
              spellId = 1218587,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        naxxramas_ranged6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasRanged6PBonus",
              spellId = 1218587,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        aspect_of_the_viper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/aspects.go",
              registrationType = "RegisterAura",
              functionName = "registerAspectOfTheViperSpell",
              spellId = 415423,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Aspect of the Viper"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/aspects.go",
              registrationType = "RegisterSpell",
              functionName = "registerAspectOfTheViperSpell",
              spellId = 415423,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
              Flags = "core.SpellFlagAPL"
            }
          }
        },
        t2_melee2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Melee2PBonus",
              spellId = 467331,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Clever Strikes"
            }
          }
        },
        clever_strikes = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Melee2PBonus",
              spellId = 467331,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Clever Strikes"
            }
          }
        },
        kill_command = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/kill_command.go",
              registrationType = "RegisterAura",
              functionName = "registerKillCommand",
              spellId = 409379,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Kill Command"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/kill_command.go",
              registrationType = "RegisterSpell",
              functionName = "registerKillCommand",
              spellId = 409379,
              cast = [[{
// 			CD: core.Cooldown{
// 				Timer:    hunter.NewTimer(),
// 				Duration: time.Second * time.Duration(60*cooldownModifier),
// 			},
// 		}]],
              cooldown = {
                raw = "time.Second * time.Duration(60*cooldownModifier)",
                seconds = nil
              },
              Flags = "core.SpellFlagNoOnCastComplete",
              SpellSchool = "core.SpellSchoolPhysical"
            }
          }
        },
        flanking_strike = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/flanking_strike.go",
              registrationType = "RegisterAura",
              functionName = "registerFlankingStrikeSpell",
              spellId = 415320,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Flanking Strike Buff"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/flanking_strike.go",
              registrationType = "RegisterSpell",
              functionName = "registerFlankingStrikeSpell",
              spellId = 415320,
              Flags = "core.SpellFlagMeleeMetrics",
              ClassSpellMask = "ClassSpellMask_HunterPetFlankingStrike",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "1"
            }
          }
        },
        t1_melee2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Melee2PBonus",
              spellId = 458403,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Stalker"
            }
          }
        },
        stalker = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Melee2PBonus",
              spellId = 458403,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Stalker"
            }
          }
        },
        t1_ranged6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Ranged6PBonus",
              spellId = 456382,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Precision"
            }
          }
        },
        precision = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Ranged6PBonus",
              spellId = 456382,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Precision"
            }
          }
        },
        chimera_shot_serpent_sting = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/serpent_sting.go",
              registrationType = "RegisterSpell",
              functionName = "chimeraShotSerpentStingSpell",
              spellId = 409493,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_HunterChimeraSerpent",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskRangedProc | core.ProcMaskRangedDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        make_queue_spells_and = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/raptor_strike.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Raptor Strike Queued"
            }
          }
        },
        raptor_strike_queued = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/raptor_strike.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Raptor Strike Queued"
            }
          }
        },
        regicide_hunter = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideHunterEffect",
              spellId = 1231765,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            }
          }
        },
        coup = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideHunterEffect",
              spellId = 1231765,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            }
          }
        },
        mercy_hunter = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyHunterEffect",
              spellId = 1235361,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        mercy_by_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyHunterEffect",
              spellId = 1235361,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        crimson_cleaver_hunter = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverHunterEffect",
              spellId = 1235341,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        crimson_crusade = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverHunterEffect",
              spellId = 1235341,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        rapid_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/rapid_fire.go",
              registrationType = "RegisterAura",
              functionName = "registerRapidFire",
              spellId = 3045,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Rapid Fire"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/rapid_fire.go",
              registrationType = "RegisterSpell",
              functionName = "registerRapidFire",
              spellId = 3045,
              cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: cooldown,
			},
			SharedCD: core.Cooldown{
				Timer:    hunter.GetAttackSpeedBuffCD(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              }
            }
          }
        },
        explosive_shot = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/explosive_shot.go",
              registrationType = "RegisterSpell",
              functionName = "registerExplosiveShotSpell",
              spellId = 409552,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6
              },
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_HunterExplosiveShot",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskRangedSpecial",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true"
            }
          }
        },
        focus_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/focus_fire.go",
              registrationType = "RegisterAura",
              functionName = "registerFocusFireSpell",
              spellId = 428728,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Focus Fire Frenzy (Hunter)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/focus_fire.go",
              registrationType = "RegisterAura",
              functionName = "registerFocusFireSpell",
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Focus Fire"
            }
          }
        },
        focus_fire_frenzy_hunter = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/focus_fire.go",
              registrationType = "RegisterAura",
              functionName = "registerFocusFireSpell",
              spellId = 428728,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Focus Fire Frenzy (Hunter)"
            }
          }
        },
        focus_fire_frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/focus_fire.go",
              registrationType = "RegisterAura",
              functionName = "registerFocusFireSpell",
              spellId = 428728,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Focus Fire Frenzy"
            }
          }
        },
        scarlet_enclave_melee4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveMelee4PBonus",
              spellId = 1226357,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Wicked Fast"
            }
          }
        },
        wicked_fast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveMelee4PBonus",
              spellId = 1226357,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Wicked Fast"
            }
          }
        },
        scarlet_enclave_ranged4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRanged4PBonus",
              spellId = 1226136,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Wicked Shot"
            }
          }
        },
        wicked_shot = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRanged4PBonus",
              spellId = 1226136,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Wicked Shot"
            }
          }
        },
        scarlet_enclave_ranged6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRanged6PBonus",
              spellId = 1233451,
              auraDuration = {
                raw = "time.Minute * 5",
                seconds = 300
              },
              label = "Trick Shots"
            }
          }
        },
        trick_shots = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRanged6PBonus",
              spellId = 1233451,
              auraDuration = {
                raw = "time.Minute * 5",
                seconds = 300
              },
              label = "Trick Shots"
            }
          }
        },
        runes = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRunes",
              label = "Beastmastery Rune Focus"
            }
          }
        },
        beastmastery_rune_focus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRunes",
              label = "Beastmastery Rune Focus"
            }
          }
        },
        invigoration = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterSpell",
              functionName = "applyInvigoration",
              spellId = 437999,
              SpellSchool = "core.SpellSchoolNature"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyInvigoration",
              label = "Invigoration"
            }
          }
        },
        expose_weakness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyExposeWeakness",
              spellId = 409507,
              auraDuration = {
                raw = "time.Second * 7",
                seconds = 7
              },
              label = "Expose Weakness Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyExposeWeakness",
              label = "Expose Weakness"
            }
          }
        },
        sniper_training = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySniperTraining",
              spellId = 415399,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Sniper Training"
            }
          }
        },
        cobra_strikes = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyCobraStrikes",
              spellId = 425714,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Cobra Strikes"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyCobraStrikes",
              label = "Cobra Strikes Trigger"
            }
          }
        },
        cobra_strikes_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyCobraStrikes",
              label = "Cobra Strikes Trigger"
            }
          }
        },
        lock_and_load = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyLockAndLoad",
              spellId = 415413,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Lock And Load"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyLockAndLoad",
              label = "Lock And Load Trigger"
            }
          }
        },
        lock_and_load_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyLockAndLoad",
              label = "Lock And Load Trigger"
            }
          }
        },
        raptor_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyRaptorFury",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Raptor Fury Buff"
            }
          }
        },
        cobra_slayer = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyCobraSlayer",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Cobra Slayer"
            }
          }
        },
        hit_and_run = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHitAndRun",
              spellId = 440533,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Hit And Run"
            }
          }
        },
        improved_volley = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedVolley",
              spellId = 440520,
              label = "Improved Volley"
            }
          }
        },
        carve = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/carve.go",
              registrationType = "RegisterSpell",
              functionName = "registerCarveSpell",
              spellId = 425711,
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
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_HunterCarve",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial"
            }
          }
        },
        new_carve_hit = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/carve.go",
              registrationType = "RegisterSpell",
              functionName = "newCarveHitSpell",
              spellId = 425711,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
              ClassSpellMask = "ClassSpellMask_HunterCarveHit",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "procMask",
              DamageMultiplier = "damageMultiplier",
              ThreatMultiplier = "1"
            }
          }
        },
        frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFrenzy",
              spellId = 19625,
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Frenzy Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
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
        bestial_wrath = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerBestialWrathCD",
              spellId = 19574,
              auraDuration = {
                raw = "time.Second * 18",
                seconds = 18
              },
              label = "Bestial Wrath Pet"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
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
				Duration: time.Minute * 2,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 2",
                seconds = 120
              },
              Flags = "core.SpellFlagAPL"
            }
          }
        },
        bestial_wrath_pet = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerBestialWrathCD",
              spellId = 19574,
              auraDuration = {
                raw = "time.Second * 18",
                seconds = 18
              },
              label = "Bestial Wrath Pet"
            }
          }
        },
        mongoose_bite = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/mongoose_bite.go",
              registrationType = "RegisterAura",
              functionName = "registerMongooseBiteSpell",
              spellId = 5302,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Defensive State"
            }
          }
        },
        defensive_state = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/hunter/mongoose_bite.go",
              registrationType = "RegisterAura",
              functionName = "registerMongooseBiteSpell",
              spellId = 5302,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Defensive State"
            }
          }
        }
      },
      priest = {
        flash_heal = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/flash_heal.go",
              registrationType = "RegisterSpell",
              functionName = "registerFlashHealSpell",
              spellId = 10917,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD:      core.GCDDefault,
// 				CastTime: time.Millisecond * 1500,
// 			},
// 		}]],
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 + .02*float64(priest.Talents.SpiritualHealing)",
              ThreatMultiplier = "1 - []float64{0"
            }
          }
        },
        vampiric_embrace = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/vampiric_embrace.go",
              registrationType = "RegisterAura",
              functionName = "registerVampiricEmbraceSpell",
              spellId = 15286,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Vampiric Embrace (Health) - "
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/vampiric_embrace.go",
              registrationType = "RegisterSpell",
              functionName = "registerVampiricEmbraceSpell",
              spellId = 15286,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_PriestVampiricEmbrace",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        vampiric_embrace_health = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/vampiric_embrace.go",
              registrationType = "RegisterAura",
              functionName = "registerVampiricEmbraceSpell",
              spellId = 15286,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Vampiric Embrace (Health) - "
            }
          }
        },
        shadowfiend = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowfiendSpell",
              spellId = 401977,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Shadowfiend"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowfiendSpell",
              spellId = 401977,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_PriestShadowFiend",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        new_shadowfiend = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterAura",
              functionName = "NewShadowfiend",
              label = "Autoattack mana regen"
            }
          }
        },
        autoattack_mana_regen = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterAura",
              functionName = "NewShadowfiend",
              label = "Autoattack mana regen"
            }
          }
        },
        shadow_crawl = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowCrawlSpell",
              spellId = 401990,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Shadowcrawl"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowCrawlSpell",
              spellId = 401990,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 6,
			},
		}]],
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        shadowcrawl = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadowfiend.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowCrawlSpell",
              spellId = 401990,
              auraDuration = {
                raw = "time.Second * 5",
                seconds = 5
              },
              label = "Shadowcrawl"
            }
          }
        },
        shadow_word_death = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/shadow_word_death.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowWordDeathSpell",
              spellId = 401955,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              Flags = "core.SpellFlagBinary | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_PriestShadowWordDeath",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        power_word_shield = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/power_word_shield.go",
              registrationType = "RegisterSpell",
              functionName = "registerPowerWordShieldSpell",
              spellId = 48066,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD: core.GCDDefault,
// 			},
// 			CD: cd,
// 		}]],
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 *",
              ThreatMultiplier = "1 - []float64{0",
              label = "Power Word Shield"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/power_word_shield.go",
              registrationType = "RegisterAura",
              functionName = "registerPowerWordShieldSpell",
              spellId = 6788,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Weakened Soul"
            }
          }
        },
        weakened_soul = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/power_word_shield.go",
              registrationType = "RegisterAura",
              functionName = "registerPowerWordShieldSpell",
              spellId = 6788,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Weakened Soul"
            }
          }
        },
        renew = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/renew.go",
              registrationType = "RegisterSpell",
              functionName = "registerRenewSpell",
              spellId = 25315,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD: core.GCDDefault,
// 			},
// 		}]],
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "priest.renewHealingMultiplier()",
              ThreatMultiplier = "1 - []float64{0",
              label = "Renew"
            }
          }
        },
        vampiric_touch = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/vampiric_touch.go",
              registrationType = "RegisterAura",
              functionName = "registerVampiricTouchSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Vampiric Touch (Mana)"
            }
          }
        },
        vampiric_touch_mana = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/vampiric_touch.go",
              registrationType = "RegisterAura",
              functionName = "registerVampiricTouchSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Vampiric Touch (Mana)"
            }
          }
        },
        t2_healer4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Healer4PBonus",
              spellId = 467543,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Deliverance"
            }
          }
        },
        deliverance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/item_sets_pve_phase_5.go",
              registrationType = "RegisterAura",
              functionName = "applyT2Healer4PBonus",
              spellId = 467543,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Deliverance"
            }
          }
        },
        t1_shadow6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Shadow6PBonus",
              spellId = 456549,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Melting Faces"
            }
          }
        },
        melting_faces = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Shadow6PBonus",
              spellId = 456549,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Melting Faces"
            }
          }
        },
        circle_of_healing = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/circle_of_healing.go",
              registrationType = "RegisterSpell",
              functionName = "registerCircleOfHealingSpell",
              spellId = 401946,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD: core.GCDDefault,
// 			},
// 			CD: core.Cooldown{
// 				Timer:    priest.NewTimer(),
// 				Duration: time.Second * 6,
// 			},
// 		}]],
              cooldown = {
                raw = "time.Second * 6",
                seconds = 6
              },
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 + .02*float64(priest.Talents.SpiritualHealing)",
              ThreatMultiplier = "1 - []float64{0"
            }
          }
        },
        power_infusion = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/power_infusion.go",
              registrationType = "RegisterSpell",
              functionName = "registerPowerInfusionCD",
              majorCooldown = {
                type = "core.CooldownTypeMana",
                priority = "core.CooldownPriorityBloodlust"
              },
              spellId = 10060,
              cast = [[{
	// 		CD: core.Cooldown{
	// 			Timer:    priest.NewTimer(),
	// 			Duration: time.Duration(float64(core.PowerInfusionCD)),
	// 		},
	// 	}]],
              cooldown = {
                raw = "time.Duration(float64(core.PowerInfusionCD))",
                seconds = nil
              },
              Flags = "SpellFlagPriest | core.SpellFlagHelpful"
            }
          }
        },
        new_mind_sear_tick = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/mind_sear.go",
              registrationType = "RegisterSpell",
              functionName = "newMindSearTickSpell",
              spellId = 413260,
              ClassSpellMask = "ClassSpellMask_PriestMindSear",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        prayer_of_mending = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/prayer_of_mending.go",
              registrationType = "RegisterSpell",
              functionName = "registerPrayerOfMendingSpell",
              spellId = 48113,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD: core.GCDDefault,
// 			},
// 			CD: core.Cooldown{
// 				Timer:    priest.NewTimer(),
// 				Duration: time.Second * 10,
// 			},
// 		}]],
              cooldown = {
                raw = "time.Second * 10",
                seconds = 10
              },
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 + .02*float64(priest.Talents.SpiritualHealing)",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/prayer_of_mending.go",
              registrationType = "RegisterAura",
              functionName = "makePrayerOfMendingAura",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "PrayerOfMending"
            }
          }
        },
        make_prayer_of_mending = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/prayer_of_mending.go",
              registrationType = "RegisterAura",
              functionName = "makePrayerOfMendingAura",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "PrayerOfMending"
            }
          }
        },
        dispersion = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/dispersion.go",
              registrationType = "RegisterAura",
              functionName = "registerDispersionSpell",
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Dispersion"
            }
          }
        },
        homunculi = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/homunculi.go",
              registrationType = "RegisterAura",
              functionName = "registerHomunculiSpell",
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Homunculi"
            }
          }
        },
        prayer_of_healing = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/prayer_of_healing.go",
              registrationType = "RegisterSpell",
              functionName = "registerPrayerOfHealingSpell",
              spellId = 48072,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD:      core.GCDDefault,
// 				CastTime: time.Second * 3,
// 			},
// 		}]],
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 + .02*float64(priest.Talents.SpiritualHealing)",
              ThreatMultiplier = "1 - []float64{0"
            }
          }
        },
        greater_heal = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/greater_heal.go",
              registrationType = "RegisterSpell",
              functionName = "registerGreaterHealSpell",
              spellId = 48063,
              cast = [[{
// 			DefaultCast: core.Cast{
// 				GCD:      core.GCDDefault,
// 				CastTime: time.Second*3 - time.Millisecond*100*time.Duration(priest.Talents.DivineFury),
// 			},
// 		}]],
              Flags = "SpellFlagPriest | core.SpellFlagHelpful | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1 + .02*float64(priest.Talents.SpiritualHealing)",
              ThreatMultiplier = "1 - []float64{0"
            }
          }
        },
        new_mind_spike = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/mind_spike.go",
              registrationType = "RegisterAura",
              functionName = "newMindSpikeAura",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Mind Spike"
            }
          }
        },
        mind_spike = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/mind_spike.go",
              registrationType = "RegisterAura",
              functionName = "newMindSpikeAura",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Mind Spike"
            }
          }
        },
        pain_and_suffering = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPainAndSuffering",
              label = "Pain and Suffering Trigger"
            }
          }
        },
        pain_and_suffering_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPainAndSuffering",
              label = "Pain and Suffering Trigger"
            }
          }
        },
        surge_of_light = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySurgeOfLight",
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Surge of Light Proc"
            }
          }
        },
        surge_of_light_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySurgeOfLight",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Surge of Light Trigger"
            }
          }
        },
        eye_of_the_void = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/eye_of_the_void.go",
              registrationType = "RegisterAura",
              functionName = "registerEyeOfTheVoidCD",
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Eye of the Void"
            }
          }
        },
        make_penance = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/penance.go",
              registrationType = "RegisterSpell",
              functionName = "makePenanceSpell",
              spellId = 402284,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              Flags = "flags",
              ClassSpellMask = "ClassSpellMask_PriestPenance | classSpellMask",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "procMask",
              DamageMultiplier = "1",
              ThreatMultiplier = "0",
              label = "Penance"
            }
          }
        },
        penance = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/penance.go",
              registrationType = "RegisterSpell",
              functionName = "makePenanceSpell",
              spellId = 402284,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              Flags = "flags",
              ClassSpellMask = "ClassSpellMask_PriestPenance | classSpellMask",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "procMask",
              DamageMultiplier = "1",
              ThreatMultiplier = "0",
              label = "Penance"
            }
          }
        },
        inspiration = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyInspiration",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Inspiration Talent"
            }
          }
        },
        inspiration_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyInspiration",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Inspiration Talent"
            }
          }
        },
        spirit_tap = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "applySpiritTap",
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Spirit Tap"
            }
          }
        },
        darkness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDarkness",
              label = "Darkness"
            }
          }
        },
        inner_focus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerInnerFocus",
              spellId = 14751,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Inner Focus"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
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
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_PriestInnerFocus"
            }
          }
        },
        shadowform = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowform",
              spellId = 15473,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Shadowform"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/priest/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowform",
              spellId = 15473,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
		}]],
              Flags = "core.SpellFlagAPL"
            }
          }
        }
      },
      warlock = {
        haunt = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/haunt.go",
              registrationType = "RegisterAura",
              functionName = "registerHauntSpell",
              spellId = 403501,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Haunt-"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/haunt.go",
              registrationType = "RegisterSpell",
              functionName = "registerHauntSpell",
              spellId = 403501,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 12,
			},
		}]],
              cooldown = {
                raw = "time.Second * 12",
                seconds = 12
              },
              Flags = "core.SpellFlagAPL | core.SpellFlagBinary | core.SpellFlagResetAttackSwing | WarlockFlagAffliction",
              ClassSpellMask = "ClassSpellMask_WarlockHaunt",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        demon_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonArmor",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Demon Armor"
            }
          }
        },
        fel_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyFelArmor",
              spellId = 403619,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Fel Armor"
            }
          }
        },
        immolation_aura = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/immolation_aura.go",
              registrationType = "RegisterSpell",
              functionName = "registerImmolationAuraSpell",
              spellId = 427725,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_WarlockImmolationAuraProc",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/immolation_aura.go",
              registrationType = "RegisterAura",
              functionName = "registerImmolationAuraSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Immolation Aura"
            }
          }
        },
        immolation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/immolation_aura.go",
              registrationType = "RegisterAura",
              functionName = "registerImmolationAuraSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Immolation Aura"
            }
          }
        },
        curse_of_recklessness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfRecklessnessSpell",
              auraDuration = {
                raw = "core.CurseOfRecklessnessDuration",
                seconds = nil
              },
              label = "Curse of Recklessness Wrapper"
            }
          }
        },
        curse_of_recklessness_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfRecklessnessSpell",
              auraDuration = {
                raw = "core.CurseOfRecklessnessDuration",
                seconds = nil
              },
              label = "Curse of Recklessness Wrapper"
            }
          }
        },
        curse_of_elements = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfElementsSpell",
              auraDuration = {
                raw = "core.CurseOfElementsDuration",
                seconds = nil
              },
              label = "Curse of Elements Wrapper"
            }
          }
        },
        curse_of_elements_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfElementsSpell",
              auraDuration = {
                raw = "core.CurseOfElementsDuration",
                seconds = nil
              },
              label = "Curse of Elements Wrapper"
            }
          }
        },
        curse_of_shadow = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfShadowSpell",
              auraDuration = {
                raw = "core.CurseOfShadowDuration",
                seconds = nil
              },
              label = "Curse of Shadow Wrapper"
            }
          }
        },
        curse_of_shadow_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerCurseOfShadowSpell",
              auraDuration = {
                raw = "core.CurseOfShadowDuration",
                seconds = nil
              },
              label = "Curse of Shadow Wrapper"
            }
          }
        },
        amplify_curse = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterAura",
              functionName = "registerAmplifyCurseSpell",
              spellId = 18288,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Amplify Curse"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterSpell",
              functionName = "registerAmplifyCurseSpell",
              spellId = 18288,
              cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: 3 * time.Minute,
			},
		}]],
              cooldown = {
                raw = "3 * time.Minute",
                seconds = 180
              },
              Flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              SpellSchool = "core.SpellSchoolShadow"
            }
          }
        },
        curse_of_doom = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterSpell",
              functionName = "registerCurseOfDoomSpell",
              spellId = 449432,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 60,
			},
		}]],
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60
              },
              Flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              ClassSpellMask = "ClassSpellMask_WarlockCurseOfDoom",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              label = "CurseofDoom"
            }
          }
        },
        curseof_doom = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/curses.go",
              registrationType = "RegisterSpell",
              functionName = "registerCurseOfDoomSpell",
              spellId = 449432,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 60,
			},
		}]],
              cooldown = {
                raw = "time.Second * 60",
                seconds = 60
              },
              Flags = "core.SpellFlagAPL | WarlockFlagAffliction",
              ClassSpellMask = "ClassSpellMask_WarlockCurseOfDoom",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              label = "CurseofDoom"
            }
          }
        },
        infernal_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/infernal_armor.go",
              registrationType = "RegisterAura",
              functionName = "registerInfernalArmorCD",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Infernal Armor"
            }
          }
        },
        incinerate = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/incinerate.go",
              registrationType = "RegisterAura",
              functionName = "registerIncinerateSpell",
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Incinerate Aura"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/incinerate.go",
              registrationType = "RegisterSpell",
              functionName = "registerIncinerateSpell",
              spellId = 412758,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: IncinerateCastTime,
			},
		}]],
              Flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | core.SpellFlagBinary | WarlockFlagDestruction",
              ClassSpellMask = "ClassSpellMask_WarlockIncinerate",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        t2_tank4_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_5.go",
              registrationType = "RegisterSpell",
              functionName = "applyT2Tank4PBonus",
              spellId = 468062,
              Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "0"
            }
          }
        },
        t2_tank6_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_5.go",
              registrationType = "RegisterSpell",
              functionName = "applyT2Tank6PBonus",
              spellId = 470279,
              Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Demonic Aegis"
            }
          }
        },
        demonic_aegis = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_5.go",
              registrationType = "RegisterSpell",
              functionName = "applyT2Tank6PBonus",
              spellId = 470279,
              Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Demonic Aegis"
            }
          }
        },
        chaos_bolt = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/chaos_bolt.go",
              registrationType = "RegisterSpell",
              functionName = "registerChaosBoltSpell",
              spellId = 403629,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 12,
			},
		}]],
              cooldown = {
                raw = "time.Second * 12",
                seconds = 12
              },
              Flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagDestruction",
              ClassSpellMask = "ClassSpellMask_WarlockChaosBolt",
              SpellSchool = "core.SpellSchoolArcane | core.SpellSchoolFire | core.SpellSchoolFrost | core.SpellSchoolNature | core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        t1_tank6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Tank6PBonus",
              spellId = 457643,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Soul Fire!"
            }
          }
        },
        soul_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Tank6PBonus",
              spellId = 457643,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Soul Fire!"
            }
          }
        },
        shadow_cleave = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/shadow_cleave.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowCleaveSpell",
              label = "Shadow Cleave ISB Trigger"
            }
          }
        },
        shadow_cleave_isb_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/shadow_cleave.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowCleaveSpell",
              label = "Shadow Cleave ISB Trigger"
            }
          }
        },
        demonic_grace = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/demonic_grace.go",
              registrationType = "RegisterAura",
              functionName = "registerDemonicGraceSpell",
              spellId = 425463,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Demonic Grace Aura"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/demonic_grace.go",
              registrationType = "RegisterSpell",
              functionName = "registerDemonicGraceSpell",
              spellId = 425463,
              cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20
              },
              Flags = "core.SpellFlagAPL | core.SpellFlagResetAttackSwing | WarlockFlagDemonology",
              ClassSpellMask = "ClassSpellMask_WarlockDemonicGrace"
            }
          }
        },
        summon_demon = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 427733,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockSummonFelguard",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 691,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockSummonFelhunter",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 688,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockSummonImp",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 712,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockSummonSuccubus",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 697,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockSummonVoidwalker",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        metamorphosis = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/metamorphosis.go",
              registrationType = "RegisterAura",
              functionName = "registerMetamorphosisSpell",
              spellId = 403789,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Metamorphosis Aura"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/metamorphosis.go",
              registrationType = "RegisterSpell",
              functionName = "registerMetamorphosisSpell",
              spellId = 403789,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
              Flags = "core.SpellFlagAPL | WarlockFlagDemonology"
            }
          }
        },
        fel_domination = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/fel_domination.go",
              registrationType = "RegisterAura",
              functionName = "registerFelDominationCD",
              spellId = 18708,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Fel Domination"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/fel_domination.go",
              registrationType = "RegisterSpell",
              functionName = "registerFelDominationCD",
              majorCooldown = {
                type = "core.CooldownTypeUnknown",
                priority = nil
              },
              spellId = 18708,
              cast = [[{
			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Minute * 15,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 15",
                seconds = 900
              },
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        felguard_cleave = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/felguard.go",
              registrationType = "RegisterSpell",
              functionName = "registerFelguardCleaveSpell",
              spellId = 427744,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
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
              ClassSpellMask = "ClassSpellMask_WarlockSummonFelguardCleave",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "wp.AutoAttacks.MHConfig().DamageMultiplier",
              ThreatMultiplier = "1"
            }
          }
        },
        felguard_demonic_frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/felguard.go",
              registrationType = "RegisterAura",
              functionName = "registerFelguardDemonicFrenzyAura",
              spellId = 460907,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Demonic Frenzy"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/felguard.go",
              registrationType = "RegisterAura",
              functionName = "registerFelguardDemonicFrenzyAura",
              label = "Demonic Frenzy Trigger"
            }
          }
        },
        demonic_frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/felguard.go",
              registrationType = "RegisterAura",
              functionName = "registerFelguardDemonicFrenzyAura",
              spellId = 460907,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Demonic Frenzy"
            }
          }
        },
        demonic_frenzy_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/felguard.go",
              registrationType = "RegisterAura",
              functionName = "registerFelguardDemonicFrenzyAura",
              label = "Demonic Frenzy Trigger"
            }
          }
        },
        shadowflame = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/shadowflame.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowflameSpell",
              label = "Shadowflame ISB Trigger"
            }
          }
        },
        shadowflame_isb_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/shadowflame.go",
              registrationType = "RegisterAura",
              functionName = "registerShadowflameSpell",
              label = "Shadowflame ISB Trigger"
            }
          }
        },
        scarlet_enclave_damage2_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveDamage2PBonus",
              spellId = 1227180,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagIgnoreTargetModifiers",
              SpellSchool = "core.SpellSchoolShadow | core.SpellSchoolFire",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Burning"
            }
          }
        },
        burning = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveDamage2PBonus",
              spellId = 1227180,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagIgnoreTargetModifiers",
              SpellSchool = "core.SpellSchoolShadow | core.SpellSchoolFire",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              label = "Burning"
            }
          }
        },
        scarlet_enclave_damage6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveDamage6PBonus",
              spellId = 1227200,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Wickedness"
            }
          }
        },
        wickedness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveDamage6PBonus",
              spellId = 1227200,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Wickedness"
            }
          }
        },
        scarlet_enclave_tank4_p_bonus = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_8.go",
              registrationType = "RegisterSpell",
              functionName = "applyScarletEnclaveTank4PBonus",
              spellId = 1227207,
              Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "0"
            }
          }
        },
        vengeance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyVengeance",
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Vengeance"
            }
          }
        },
        backdraft = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBackdraft",
              spellId = 427714,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Backdraft"
            }
          }
        },
        decimation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDecimation",
              spellId = 440873,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Decimation"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDecimation",
              label = "Decimation Trigger"
            }
          }
        },
        decimation_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDecimation",
              label = "Decimation Trigger"
            }
          }
        },
        mark_of_chaos = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMarkOfChaos",
              auraDuration = {
                raw = "mocAura.Duration",
                seconds = nil
              },
              label = "Mark of Chaos Wrapper"
            }
          }
        },
        mark_of_chaos_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMarkOfChaos",
              auraDuration = {
                raw = "mocAura.Duration",
                seconds = nil
              },
              label = "Mark of Chaos Wrapper"
            }
          }
        },
        shadow_bolt_volley = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShadowBoltVolley",
              label = "Shadow Bolt Volley"
            }
          }
        },
        invocation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyInvocation",
              label = "Invocation"
            }
          }
        },
        dance_of_the_wicked = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDanceOfTheWicked",
              spellId = 412800,
              auraDuration = {
                raw = "15 * time.Second",
                seconds = 15
              },
              label = "Dance of the Wicked Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDanceOfTheWicked",
              label = "Dance of the Wicked"
            }
          }
        },
        demonic_knowledge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicKnowledge",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Demonic Knowledge"
            }
          }
        },
        grimoire_of_synergy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyGrimoireOfSynergy",
              label = "Grimoire of Synergy Trigger"
            }
          }
        },
        grimoire_of_synergy_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyGrimoireOfSynergy",
              label = "Grimoire of Synergy Trigger"
            }
          }
        },
        shadow_and_flame = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShadowAndFlame",
              spellId = 426311,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Shadow and Flame proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShadowAndFlame",
              label = "Shadow and Flame"
            }
          }
        },
        taq_damage4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage4PBonus",
              spellId = 1214088,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Infernalist"
            }
          }
        },
        infernalist = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage4PBonus",
              spellId = 1214088,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Infernalist"
            }
          }
        },
        raq_tank3_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyRAQTank3PBonus",
              spellId = 1214156,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Spreading Pain"
            }
          }
        },
        spreading_pain = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyRAQTank3PBonus",
              spellId = 1214156,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Spreading Pain"
            }
          }
        },
        firestone = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFirestone",
              label = "Firestone Proc"
            }
          }
        },
        nightfall = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              spellId = 17941,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Nightfall Shadow Trance"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              label = "Nightfall Hidden Aura"
            }
          }
        },
        nightfall_shadow_trance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              spellId = 17941,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Nightfall Shadow Trance"
            }
          }
        },
        nightfall_hidden = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              label = "Nightfall Hidden Aura"
            }
          }
        },
        master_summoner = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMasterSummoner",
              label = "Master Summoner Hidden Aura"
            }
          }
        },
        master_summoner_hidden = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMasterSummoner",
              label = "Master Summoner Hidden Aura"
            }
          }
        },
        soul_link = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterSpell",
              functionName = "applySoulLink",
              spellId = 19028,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
              Flags = "core.SpellFlagAPL"
            }
          }
        },
        demonic_sacrifice = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18789,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Burning Wish"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18790,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Fel Stamina"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18791,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Touch of Shadow"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18792,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Fel Energy"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterSpell",
              functionName = "applyDemonicSacrifice",
              spellId = 18788,
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_WarlockDemonicSacrifice",
              SpellSchool = "core.SpellSchoolShadow"
            }
          }
        },
        burning_wish = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18789,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Burning Wish"
            }
          }
        },
        fel_stamina = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18790,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Fel Stamina"
            }
          }
        },
        touch_of_shadow = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18791,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Touch of Shadow"
            }
          }
        },
        fel_energy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDemonicSacrifice",
              spellId = 18792,
              auraDuration = {
                raw = "30 * time.Minute",
                seconds = 1800
              },
              label = "Fel Energy"
            }
          }
        },
        improved_shadow_bolt = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedShadowBolt",
              auraDuration = {
                raw = "core.ISBDuration",
                seconds = nil
              },
              label = "Improved Shadow Bolt Wrapper"
            }
          }
        },
        improved_shadow_bolt_wrapper = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedShadowBolt",
              auraDuration = {
                raw = "core.ISBDuration",
                seconds = nil
              },
              label = "Improved Shadow Bolt Wrapper"
            }
          }
        },
        isb_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedShadowBolt",
              label = "ISB Trigger"
            }
          }
        }
      },
      paladin = {
        aura_mastery = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/aura_mastery.go",
              registrationType = "RegisterAura",
              functionName = "registerAuraMastery",
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Aura Mastery"
            }
          }
        },
        rv = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/righteous_vengeance.go",
              registrationType = "RegisterAura",
              functionName = "registerRV",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Righteous Vengeance"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/righteous_vengeance.go",
              registrationType = "RegisterSpell",
              functionName = "registerRV",
              spellId = 440675,
              cast = [[{
			IgnoreHaste: true,
		}]],
              Flags = "core.SpellFlagPureDot | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnCastComplete",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true",
              label = "Righteous Vengeance"
            }
          }
        },
        righteous_vengeance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/righteous_vengeance.go",
              registrationType = "RegisterAura",
              functionName = "registerRV",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Righteous Vengeance"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/righteous_vengeance.go",
              registrationType = "RegisterSpell",
              functionName = "registerRV",
              spellId = 440675,
              cast = [[{
			IgnoreHaste: true,
		}]],
              Flags = "core.SpellFlagPureDot | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnCastComplete",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true",
              label = "Righteous Vengeance"
            }
          }
        },
        paladin_t1_prot4_p = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterSpell",
              functionName = "applyPaladinT1Prot4P",
              spellId = 456540,
              Flags = "core.SpellFlagHelpful",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        paladin_taq_prot4_p = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinTAQProt4P",
              spellId = 1213415,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Shielded in Righteousness"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterSpell",
              functionName = "applyPaladinTAQProt4P",
              spellId = 19968,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_PaladinHolyLight",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskSpellHealing",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true"
            }
          }
        },
        shielded_in_righteousness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinTAQProt4P",
              spellId = 1213415,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Shielded in Righteousness"
            }
          }
        },
        paladin_t2_ret6_p = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinT2Ret6P",
              spellId = 467530,
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Swift Judgement"
            }
          }
        },
        swift_judgement = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinT2Ret6P",
              spellId = 467530,
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Swift Judgement"
            }
          }
        },
        paladin_taq_ret4_p = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinTAQRet4P",
              spellId = 1217927,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Excommunication"
            }
          }
        },
        excommunication = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve.go",
              registrationType = "RegisterAura",
              functionName = "applyPaladinTAQRet4P",
              spellId = 1217927,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Excommunication"
            }
          }
        },
        seal_of_the_crusader = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/sotc.go",
              registrationType = "RegisterAura",
              functionName = "registerSealOfTheCrusader",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Seal of the Crusader"
            }
          }
        },
        divine_favor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/divine_favor.go",
              registrationType = "RegisterAura",
              functionName = "registerDivineFavor",
              spellId = 20216,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Divine Favor"
            }
          }
        },
        avenging_wrath = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/avenging_wrath.go",
              registrationType = "RegisterAura",
              functionName = "registerAvengingWrath",
              spellId = 407788,
              auraDuration = {
                raw = "time.Second * 20",
                seconds = 20
              },
              label = "Avenging Wrath"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/avenging_wrath.go",
              registrationType = "RegisterSpell",
              functionName = "registerAvengingWrath",
              spellId = 407788,
              cast = [[{
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
              cooldown = {
                raw = "time.Minute * 3",
                seconds = 180
              },
              Flags = "core.SpellFlagAPL | SpellFlag_Forbearance",
              ClassSpellMask = "ClassSpellMask_PaladinAvengingWrath"
            }
          }
        },
        seal_of_command = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/soc.go",
              registrationType = "RegisterAura",
              functionName = "registerSealOfCommand",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Seal of Command"
            }
          }
        },
        crimson_cleaver_paladin = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverPaladinEffect",
              spellId = 1235348,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        crimson_crusade = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverPaladinEffect",
              spellId = 1235348,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        holy_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/holy_shield.go",
              registrationType = "RegisterAura",
              functionName = "registerHolyShield",
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Holy Shield"
            }
          }
        },
        seal_of_righteousness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/sor.go",
              registrationType = "RegisterAura",
              functionName = "registerSealOfRighteousness",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Seal of Righteousness"
            }
          }
        },
        blessing_of_sanctuary = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/blessing_of_sanctuary.go",
              registrationType = "RegisterAura",
              functionName = "registerBlessingOfSanctuary",
              label = "Blessing of Sanctuary Trigger"
            }
          }
        },
        blessing_of_sanctuary_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/blessing_of_sanctuary.go",
              registrationType = "RegisterAura",
              functionName = "registerBlessingOfSanctuary",
              label = "Blessing of Sanctuary Trigger"
            }
          }
        },
        seal_of_martyrdom = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/som.go",
              registrationType = "RegisterSpell",
              functionName = "registerSealOfMartyrdom",
              spellId = 407803,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | SpellFlag_RV | core.SpellFlagBatchStartAttackMacro",
              ClassSpellMask = "ClassSpellMask_PaladinJudgementOfMartyrdom",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "0.85 * paladin.getWeaponSpecializationModifier() * paladin.improvedSoR()",
              ThreatMultiplier = "1"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/som.go",
              registrationType = "RegisterSpell",
              functionName = "registerSealOfMartyrdom",
              spellId = 407799,
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagSuppressWeaponProcs",
              ClassSpellMask = "ClassSpellMask_PaladinSealOfMartyrdom",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "0.5 * paladin.getWeaponSpecializationModifier() * paladin.improvedSoR()",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/som.go",
              registrationType = "RegisterAura",
              functionName = "registerSealOfMartyrdom",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Seal of Martyrdom"
            }
          }
        },
        holy_power = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "registerHolyPowerAura",
              spellId = 1226461,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Holy Power"
            }
          }
        },
        scarlet_enclave_retribution6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRetribution6PBonus",
              spellId = 1226464,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Templar"
            }
          }
        },
        templar = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveRetribution6PBonus",
              spellId = 1226464,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Templar"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveShockadin6PBonus",
              spellId = 1240574,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Templar"
            }
          }
        },
        scarlet_enclave_shockadin6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveShockadin6PBonus",
              spellId = 1240574,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Templar"
            }
          }
        },
        scarlet_enclave_protection2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveProtection2PBonus",
              spellId = 1226466,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Righteous Shield"
            }
          }
        },
        righteous_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveProtection2PBonus",
              spellId = 1226466,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Righteous Shield"
            }
          }
        },
        scarlet_enclave_protection6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveProtection6PBonus",
              spellId = 1233525,
              auraDuration = {
                raw = "time.Second * 35",
                seconds = 35
              },
              label = "Avenging Shield"
            }
          }
        },
        avenging_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveProtection6PBonus",
              spellId = 1233525,
              auraDuration = {
                raw = "time.Second * 35",
                seconds = 35
              },
              label = "Avenging Shield"
            }
          }
        },
        scarlet_enclave_holy2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveHoly2PBonus",
              spellId = 1226451,
              auraDuration = {
                raw = "time.Second * 60",
                seconds = 60
              },
              label = "Emergency"
            }
          }
        },
        emergency = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveHoly2PBonus",
              spellId = 1226451,
              auraDuration = {
                raw = "time.Second * 60",
                seconds = 60
              },
              label = "Emergency"
            }
          }
        },
        the_art_of_war = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerTheArtOfWar",
              spellId = 426157,
              auraDuration = {
                raw = "time.Millisecond * 250",
                seconds = 0
              },
              label = "The Art of War Delay"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterSpell",
              functionName = "registerTheArtOfWar",
              spellId = 426157,
              Flags = "core.SpellFlagPassiveSpell"
            }
          }
        },
        the_art_of_war_delay = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerTheArtOfWar",
              spellId = 426157,
              auraDuration = {
                raw = "time.Millisecond * 250",
                seconds = 0
              },
              label = "The Art of War Delay"
            }
          }
        },
        sheath_of_light = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerSheathOfLight",
              spellId = 426159,
              auraDuration = {
                raw = "time.Second * 60",
                seconds = 60
              },
              label = "Sheath of Light"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerSheathOfLight",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Sheath of Light (rune)"
            }
          }
        },
        sheath_of_light_rune = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerSheathOfLight",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Sheath of Light (rune)"
            }
          }
        },
        shock_and_awe = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerShockAndAwe",
              spellId = 462832,
              auraDuration = {
                raw = "time.Second * 60",
                seconds = 60
              },
              label = "Shock and Awe"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerShockAndAwe",
              spellId = 1239543,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Sunlight"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterSpell",
              functionName = "registerShockAndAwe",
              spellId = 1239548,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_PaladinSunlight",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskEmpty",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        sunlight = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerShockAndAwe",
              spellId = 1239543,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Sunlight"
            }
          }
        },
        guarded_by_the_light = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerGuardedByTheLight",
              spellId = 415058,
              auraDuration = {
                raw = "time.Second*15 + 1",
                seconds = nil
              },
              label = "Guarded by the Light"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerGuardedByTheLight",
              spellId = 415755,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Guarded by the Light (rune)"
            }
          }
        },
        guarded_by_the_light_rune = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerGuardedByTheLight",
              spellId = 415755,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Guarded by the Light (rune)"
            }
          }
        },
        purifying_power = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyPurifyingPower",
              label = "Purifying Power"
            }
          }
        },
        aegis = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerAegis",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Redoubt Aegis Trigger"
            }
          }
        },
        redoubt_aegis_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerAegis",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Redoubt Aegis Trigger"
            }
          }
        },
        malleable_protection = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerMalleableProtection",
              auraDuration = {
                raw = "time.Second * duration",
                seconds = nil
              },
              label = "Divine Protection"
            }
          }
        },
        divine_protection = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/runes.go",
              registrationType = "RegisterAura",
              functionName = "registerMalleableProtection",
              auraDuration = {
                raw = "time.Second * duration",
                seconds = nil
              },
              label = "Divine Protection"
            }
          }
        },
        judgement = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/judgement.go",
              registrationType = "RegisterSpell",
              functionName = "registerJudgement",
              spellId = 20271,
              cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * (10 - time.Duration(paladin.Talents.ImprovedJudgement)),
			},
		}]],
              cooldown = {
                raw = "time.Second * (10 - time.Duration(paladin.Talents.ImprovedJudgement))",
                seconds = nil
              },
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagCastTimeNoGCD",
              ClassSpellMask = "ClassSpellMask_PaladinJudgement",
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskEmpty",
              IgnoreHaste = "true"
            }
          }
        },
        redoubt = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyRedoubt",
              spellId = 20134,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Redoubt"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyRedoubt",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Redoubt Crit Trigger"
            }
          }
        },
        redoubt_crit_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyRedoubt",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Redoubt Crit Trigger"
            }
          }
        },
        vengeance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVengeance",
              spellId = 20059,
              auraDuration = {
                raw = "time.Second * 8",
                seconds = 8
              },
              label = "Vengeance Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVengeance",
              label = "Vengeance"
            }
          }
        },
        vindication = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVindication",
              spellId = 26021,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Vindication Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVindication",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Vindication Talent"
            }
          }
        },
        vindication_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVindication",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Vindication Talent"
            }
          }
        },
        improved_lay_on_hands = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedLayOnHands",
              auraDuration = {
                raw = "time.Minute * 2",
                seconds = 120
              },
              label = "Lay on Hands"
            }
          }
        },
        lay_on_hands = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedLayOnHands",
              auraDuration = {
                raw = "time.Minute * 2",
                seconds = 120
              },
              label = "Lay on Hands"
            }
          }
        },
        forbearance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/paladin/forbearance.go",
              registrationType = "RegisterAura",
              functionName = "registerForbearance",
              spellId = 25771,
              auraDuration = {
                raw = "time.Minute * 1",
                seconds = 60
              },
              label = "Forbearance"
            }
          }
        }
      },
      mage = {
        frost_ice_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostIceArmor",
              label = "Ice Armor"
            }
          }
        },
        ice_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostIceArmor",
              label = "Ice Armor"
            }
          }
        },
        mage_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyMageArmor",
              label = "Mage Armor"
            }
          }
        },
        molten_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyMoltenArmor",
              label = "Molten Armor"
            }
          }
        },
        icy_veins = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/icy_veins.go",
              registrationType = "RegisterAura",
              functionName = "registerIcyVeinsSpell",
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Icy Veins"
            }
          }
        },
        arcane_blast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/arcane_blast.go",
              registrationType = "RegisterAura",
              functionName = "registerArcaneBlastSpell",
              spellId = 400573,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Arcane Blast Aura"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/arcane_blast.go",
              registrationType = "RegisterSpell",
              functionName = "registerArcaneBlastSpell",
              spellId = 400574,
              cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: castTime,
			},
		}]],
              Flags = "core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_MageArcaneBlast",
              SpellSchool = "core.SpellSchoolArcane",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        naxxramas_damage4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage4PBonus",
              spellId = 1218701,
              auraDuration = {
                raw = "time.Second * 45",
                seconds = 45
              },
              label = "Evoker"
            }
          }
        },
        evoker = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage4PBonus",
              spellId = 1218701,
              auraDuration = {
                raw = "time.Second * 45",
                seconds = 45
              },
              label = "Evoker"
            }
          }
        },
        counterspell = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/counterspell.go",
              registrationType = "RegisterSpell",
              functionName = "registerCounterspellSpell",
              spellId = 2139,
              cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
              cooldown = {
                raw = "time.Second * 30",
                seconds = 30
              },
              Flags = "core.SpellFlagAPL | core.SpellFlagCastTimeNoGCD",
              ClassSpellMask = "ClassSpellMask_MageCounterSpell",
              SpellSchool = "core.SpellSchoolArcane",
              ProcMask = "core.ProcMaskSpellDamage"
            }
          }
        },
        ignite = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
              registrationType = "RegisterSpell",
              functionName = "applyIgnite",
              spellId = 12654,
              cast = [[{
			IgnoreHaste: true,
		}]],
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_MageIgnite",
              SpellSchool = "core.SpellSchoolFire",
              ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1",
              IgnoreHaste = "true",
              label = "Ignite"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
              registrationType = "RegisterAura",
              functionName = "applyIgnite",
              label = "Ignite Trigger"
            }
          }
        },
        ignite_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ignite.go",
              registrationType = "RegisterAura",
              functionName = "applyIgnite",
              label = "Ignite Trigger"
            }
          }
        },
        frozen_orb = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/frozen_orb.go",
              registrationType = "RegisterAura",
              functionName = "registerFrozenOrbCD",
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Frozen Orb"
            }
          }
        },
        frozen_orb_tick = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/frozen_orb.go",
              registrationType = "RegisterSpell",
              functionName = "registerFrozenOrbTickSpell",
              spellId = 440809,
              Flags = "SpellFlagChillSpell | core.SpellFlagNotAProc | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagBinary",
              ClassSpellMask = "ClassSpellMask_MageFrozenOrbTick",
              SpellSchool = "core.SpellSchoolFrost",
              ProcMask = "core.ProcMaskSpellProc | core.ProcMaskSpellDamageProc",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        t1_damage4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 456398,
              auraDuration = {
                raw = "auraDuration",
                seconds = nil
              },
              label = "S03 - Item - T1 - Mage - Damage 4P Bonus (Arcane)"
            }
          }
        },
        s03_item_t1_mage_damage_4_p_bonus_arcane = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 456398,
              auraDuration = {
                raw = "auraDuration",
                seconds = nil
              },
              label = "S03 - Item - T1 - Mage - Damage 4P Bonus (Arcane)"
            }
          }
        },
        s03_item_t1_mage_damage_4_p_bonus_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 456398,
              auraDuration = {
                raw = "auraDuration",
                seconds = nil
              },
              label = "S03 - Item - T1 - Mage - Damage 4P Bonus (Fire)"
            }
          }
        },
        s03_item_t1_mage_damage_4_p_bonus_frost = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 456398,
              auraDuration = {
                raw = "auraDuration",
                seconds = nil
              },
              label = "S03 - Item - T1 - Mage - Damage 4P Bonus (Frost)"
            }
          }
        },
        arcane_surge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/arcane_surge.go",
              registrationType = "RegisterAura",
              functionName = "registerArcaneSurgeSpell",
              auraDuration = {
                raw = "auraDuration",
                seconds = nil
              },
              label = "Arcane Surge"
            }
          }
        },
        balefire_bolt = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/balefire_bolt.go",
              registrationType = "RegisterAura",
              functionName = "registerBalefireBoltSpell",
              auraDuration = {
                raw = "buffDuration",
                seconds = nil
              },
              label = "Balefire Bolt (Stacks)"
            }
          }
        },
        balefire_bolt_stacks = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/balefire_bolt.go",
              registrationType = "RegisterAura",
              functionName = "registerBalefireBoltSpell",
              auraDuration = {
                raw = "buffDuration",
                seconds = nil
              },
              label = "Balefire Bolt (Stacks)"
            }
          }
        },
        evocation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/evocation.go",
              registrationType = "RegisterAura",
              functionName = "registerEvocationCD",
              spellId = 12051,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Evocation Regen"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/evocation.go",
              registrationType = "RegisterSpell",
              functionName = "registerEvocationCD",
              spellId = 12051,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: cooldown,
			},
		}]],
              cooldown = {
                raw = "cooldown",
                seconds = nil
              },
              Flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
              ClassSpellMask = "ClassSpellMask_MageEvocation",
              label = "Evocation"
            }
          }
        },
        evocation_regen = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/evocation.go",
              registrationType = "RegisterAura",
              functionName = "registerEvocationCD",
              spellId = 12051,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Evocation Regen"
            }
          }
        },
        ice_lance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ice_lance.go",
              registrationType = "RegisterAura",
              functionName = "registerIceLanceSpell",
              spellId = 1218345,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Glaciate"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ice_lance.go",
              registrationType = "RegisterAura",
              functionName = "registerIceLanceSpell",
              label = "Glaciate"
            }
          }
        },
        glaciate = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ice_lance.go",
              registrationType = "RegisterAura",
              functionName = "registerIceLanceSpell",
              spellId = 1218345,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Glaciate"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/ice_lance.go",
              registrationType = "RegisterAura",
              functionName = "registerIceLanceSpell",
              label = "Glaciate"
            }
          }
        },
        scarlet_enclave_healer2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveHealer2PBonus",
              spellId = 1226406,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Arcane Tunneling"
            }
          }
        },
        arcane_tunneling = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_8.go",
              registrationType = "RegisterAura",
              functionName = "applyScarletEnclaveHealer2PBonus",
              spellId = 1226406,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Arcane Tunneling"
            }
          }
        },
        enlightenment = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEnlightenment",
              spellId = 412326,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enlightenment (Damage)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEnlightenment",
              spellId = 412325,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enlightenment (Mana)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEnlightenment",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enlightenment"
            }
          }
        },
        enlightenment_damage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEnlightenment",
              spellId = 412326,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enlightenment (Damage)"
            }
          }
        },
        enlightenment_mana = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyEnlightenment",
              spellId = 412325,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enlightenment (Mana)"
            }
          }
        },
        fingers_of_frost = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFingersOfFrost",
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Fingers of Frost Proc"
            }
          }
        },
        hot_streak = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHotStreak",
              spellId = 48108,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Hot Streak"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHotStreak",
              spellId = 48108,
              tag = 1,
              auraDuration = {
                raw = "time.Hour",
                seconds = 3600
              },
              label = "Heating Up"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHotStreak",
              label = "Hot Streak Trigger"
            }
          }
        },
        heating_up = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHotStreak",
              spellId = 48108,
              tag = 1,
              auraDuration = {
                raw = "time.Hour",
                seconds = 3600
              },
              label = "Heating Up"
            }
          }
        },
        hot_streak_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyHotStreak",
              label = "Hot Streak Trigger"
            }
          }
        },
        missile_barrage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMissileBarrage",
              spellId = 400589,
              auraDuration = {
                raw = "buffDuration",
                seconds = nil
              },
              label = "Missile Barrage"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMissileBarrage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Missile Barrage Talent"
            }
          }
        },
        missile_barrage_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyMissileBarrage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Missile Barrage Talent"
            }
          }
        },
        brain_freeze = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBrainFreeze",
              spellId = 400730,
              auraDuration = {
                raw = "buffDuration",
                seconds = nil
              },
              label = "Brain Freeze"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBrainFreeze",
              label = "Brain Freeze Trigger"
            }
          }
        },
        brain_freeze_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBrainFreeze",
              label = "Brain Freeze Trigger"
            }
          }
        },
        taq_fire2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQFire2PBonus",
              spellId = 1213317,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Fire Blast"
            }
          }
        },
        fire_blast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQFire2PBonus",
              spellId = 1213317,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Fire Blast"
            }
          }
        },
        arcane_concentration = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyArcaneConcentration",
              spellId = 12577,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            }
          }
        },
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyArcaneConcentration",
              spellId = 12577,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            }
          }
        },
        presence_of_mind = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerPresenceOfMindCD",
              spellId = 12043,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Presence of Mind"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
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
              }
            }
          }
        },
        arcane_power = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerArcanePowerCD",
              spellId = 12042,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Arcane Power"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerArcanePowerCD",
              spellId = 12042,
              cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 180,
			},
		}]],
              cooldown = {
                raw = "time.Second * 180",
                seconds = 180
              },
              ClassSpellMask = "ClassSpellMask_MageArcanePower",
              RelatedSelfBuff = "buffAura"
            }
          }
        },
        master_of_elements = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
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
        combustion = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerCombustionCD",
              spellId = 11129,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Combustion"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerCombustionCD",
              majorCooldown = {
                type = "core.CooldownTypeDPS",
                priority = nil
              },
              spellId = 11129,
              cast = [[{
			CD: cd,
		}]]
            }
          }
        },
        frostbite = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterSpell",
              functionName = "applyFrostbite",
              spellId = 12494,
              Flags = "core.SpellFlagPassiveSpell",
              ClassSpellMask = "ClassSpellMask_MageFrostbite",
              SpellSchool = "core.SpellSchoolFrost",
              ProcMask = "core.ProcMaskSpellProc"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostbite",
              label = "Frostbite Trigger"
            }
          }
        },
        frostbite_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostbite",
              label = "Frostbite Trigger"
            }
          }
        },
        cold_snap = {
          spell = {
            {
              sourceFile = "extern/wowsims-sod/sim/mage/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerColdSnapCD",
              majorCooldown = {
                type = "core.CooldownTypeDPS",
                priority = nil
              },
              spellId = 12472,
              cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Duration(time.Minute * 5),
			},
		}]],
              cooldown = {
                raw = "time.Duration(time.Minute * 5)",
                seconds = nil
              }
            }
          }
        }
      },
      warrior = {
        berserker_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/berserker_rage.go",
              registrationType = "RegisterAura",
              functionName = "registerBerserkerRageSpell",
              spellId = 18499,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Berserker Rage"
            }
          }
        },
        revenge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/revenge.go",
              registrationType = "RegisterAura",
              functionName = "registerRevengeSpell",
              auraDuration = {
                raw = "5 * time.Second",
                seconds = 5
              },
              label = "Revenge"
            }
          }
        },
        revenge_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/revenge.go",
              registrationType = "RegisterAura",
              functionName = "registerRevengeSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Revenge Trigger"
            }
          }
        },
        shield_wall = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/shield_wall.go",
              registrationType = "RegisterAura",
              functionName = "RegisterShieldWallCD",
              spellId = 871,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Shield Wall"
            }
          }
        },
        bloodrage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/bloodrage.go",
              registrationType = "RegisterAura",
              functionName = "registerBloodrageCD",
              spellId = 2687,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Bloodrage"
            }
          }
        },
        shield_block = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/shield_block.go",
              registrationType = "RegisterAura",
              functionName = "RegisterShieldBlockCD",
              spellId = 2565,
              auraDuration = {
                raw = "time.Second * time.Duration(5+[]float64{0",
                seconds = nil
              },
              label = "Shield Block"
            }
          }
        },
        deep_wounds = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/deep_wounds.go",
              registrationType = "RegisterAura",
              functionName = "applyDeepWounds",
              label = "Deep Wounds Talent"
            }
          }
        },
        deep_wounds_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/deep_wounds.go",
              registrationType = "RegisterAura",
              functionName = "applyDeepWounds",
              label = "Deep Wounds Talent"
            }
          }
        },
        naxxramas_damage6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage6PBonus",
              spellId = 1219485,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        undead_slaying = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_7.go",
              registrationType = "RegisterAura",
              functionName = "applyNaxxramasDamage6PBonus",
              spellId = 1219485,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Undead Slaying"
            }
          }
        },
        rampage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/rampage.go",
              registrationType = "RegisterAura",
              functionName = "registerRampage",
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Rampage"
            }
          }
        },
        sweeping_strikes = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/sweeping_strikes.go",
              registrationType = "RegisterAura",
              functionName = "registerSweepingStrikesCD",
              spellId = 12292,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Sweeping Strikes"
            }
          }
        },
        recklessness = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/recklessness.go",
              registrationType = "RegisterAura",
              functionName = "RegisterRecklessnessCD",
              spellId = 1719,
              auraDuration = {
                raw = "DefaultRecklessnessDuration",
                seconds = nil
              },
              label = "Recklessness"
            }
          }
        },
        raging_blow = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/raging_blow.go",
              registrationType = "RegisterAura",
              functionName = "registerRagingBlow",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Raging Blow CDR"
            }
          }
        },
        raging_blow_cdr = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/raging_blow.go",
              registrationType = "RegisterAura",
              functionName = "registerRagingBlow",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Raging Blow CDR"
            }
          }
        },
        t1_damage2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage2PBonus",
              spellId = 464241,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Tactician"
            }
          }
        },
        tactician = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage2PBonus",
              spellId = 464241,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Tactician"
            }
          }
        },
        t1_damage4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457706,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Battle Stance"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457699,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Defensive Stance"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457708,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Berserker Stance"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457819,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Gladiator Stance"
            }
          }
        },
        echoes_of_battle_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457706,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Battle Stance"
            }
          }
        },
        echoes_of_defensive_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457699,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Defensive Stance"
            }
          }
        },
        echoes_of_berserker_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457708,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Berserker Stance"
            }
          }
        },
        echoes_of_gladiator_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage4PBonus",
              spellId = 457819,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Echoes of Gladiator Stance"
            }
          }
        },
        t1_damage6_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage6PBonus",
              spellId = 457816,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Battle Forecast"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage6PBonus",
              spellId = 457814,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Defense Forecast"
            }
          }
        },
        battle_forecast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage6PBonus",
              spellId = 457816,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Battle Forecast"
            }
          }
        },
        defense_forecast = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_4.go",
              registrationType = "RegisterAura",
              functionName = "applyT1Damage6PBonus",
              spellId = 457814,
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Defense Forecast"
            }
          }
        },
        retaliation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/retaliation.go",
              registrationType = "RegisterAura",
              functionName = "registerRetaliationCD",
              spellId = 20230,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Retaliation"
            }
          }
        },
        overpower = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/overpower.go",
              registrationType = "RegisterAura",
              functionName = "registerOverpowerSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Overpower Trigger"
            }
          }
        },
        overpower_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/overpower.go",
              registrationType = "RegisterAura",
              functionName = "registerOverpowerSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Overpower Trigger"
            }
          }
        },
        regicide_warrior = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideWarriorEffect",
              spellId = 1231424,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideWarriorEffect",
              spellId = 1231436,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Regicide"
            }
          }
        },
        coup = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideWarriorEffect",
              spellId = 1231424,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Coup"
            }
          }
        },
        regicide = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyRegicideWarriorEffect",
              spellId = 1231436,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Regicide"
            }
          }
        },
        mercy_warrior = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyWarriorEffect",
              spellId = 1235355,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        mercy_by_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyMercyWarriorEffect",
              spellId = 1235355,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Mercy by Fire"
            }
          }
        },
        crimson_cleaver_warrior = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverWarriorEffect",
              spellId = 1235336,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        crimson_crusade = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/items.go",
              registrationType = "RegisterAura",
              functionName = "ApplyCrimsonCleaverWarriorEffect",
              spellId = 1235336,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Crimson Crusade"
            }
          }
        },
        battle_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerBattleStanceAura",
              spellId = 2457,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Battle Stance"
            }
          }
        },
        defensive_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerDefensiveStanceAura",
              spellId = 71,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Defensive Stance"
            }
          }
        },
        berserker_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerBerserkerStanceAura",
              spellId = 2458,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Berserker Stance"
            }
          }
        },
        gladiator_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerGladiatorStanceAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Gladiator Stance Damage Bonus"
            }
          }
        },
        gladiator_stance_damage_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerGladiatorStanceAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Gladiator Stance Damage Bonus"
            }
          }
        },
        gladiator_stance_shield_validation = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/stances.go",
              registrationType = "RegisterAura",
              functionName = "registerGladiatorStanceAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Gladiator Stance Shield Validation"
            }
          }
        },
        make_queue_spells_and = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/heroic_strike_cleave.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "HS/Cleave Queue Aura-"
            }
          }
        },
        hs_cleave_queue_aura = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/heroic_strike_cleave.go",
              registrationType = "RegisterAura",
              functionName = "makeQueueSpellsAndAura",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "HS/Cleave Queue Aura-"
            }
          }
        },
        shield_mastery = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Shield Mastery Buff"
            }
          }
        },
        shield_mastery_dummy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyShieldMastery",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Shield Mastery Dummy"
            }
          }
        },
        blood_frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBloodFrenzy",
              label = "Blood Frenzy Dummy"
            }
          }
        },
        blood_frenzy_dummy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBloodFrenzy",
              label = "Blood Frenzy Dummy"
            }
          }
        },
        frenzied_assault = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFrenziedAssault",
              spellId = 431046,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Frenzied Assault"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFrenziedAssault",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Frenzied Assault Dummy"
            }
          }
        },
        frenzied_assault_dummy = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFrenziedAssault",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Frenzied Assault Dummy"
            }
          }
        },
        consumed_by_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyConsumedByRage",
              spellId = 425415,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Enrage (Consumed by Rage)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyConsumedByRage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Consumed By Rage Trigger"
            }
          }
        },
        enrage_consumed_by_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyConsumedByRage",
              spellId = 425415,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Enrage (Consumed by Rage)"
            }
          }
        },
        consumed_by_rage_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyConsumedByRage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Consumed By Rage Trigger"
            }
          }
        },
        blood_surge = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyBloodSurge",
              spellId = 413399,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Blood Surge Proc"
            }
          }
        },
        taste_for_blood = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyTasteForBlood",
              spellId = 426969,
              auraDuration = {
                raw = "time.Second * 9",
                seconds = 9
              },
              label = "Taste for Blood"
            }
          }
        },
        sudden_death = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySuddenDeath",
              spellId = 440114,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Sudden Death"
            }
          }
        },
        fresh_meat = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFreshMeat",
              spellId = 14201,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Enrage (Fresh Meat)"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFreshMeat",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Fresh Meat Trigger"
            }
          }
        },
        enrage_fresh_meat = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFreshMeat",
              spellId = 14201,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Enrage (Fresh Meat)"
            }
          }
        },
        fresh_meat_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyFreshMeat",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Fresh Meat Trigger"
            }
          }
        },
        wrecking_crew = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyWreckingCrew",
              spellId = 427066,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Enrage (Wrecking Crew)"
            }
          }
        },
        enrage_wrecking_crew = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applyWreckingCrew",
              spellId = 427066,
              auraDuration = {
                raw = "time.Second * 6",
                seconds = 6
              },
              label = "Enrage (Wrecking Crew)"
            }
          }
        },
        sword_and_board = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySwordAndBoard",
              auraDuration = {
                raw = "5 * time.Second",
                seconds = 5
              },
              label = "Sword And Board"
            }
          }
        },
        single_minded_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySingleMindedFury",
              spellId = 461470,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Single-Minded Fury Attack Speed"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySingleMindedFury",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Single-Minded Fury Trigger"
            }
          }
        },
        single_minded_fury_attack_speed = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySingleMindedFury",
              spellId = 461470,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Single-Minded Fury Attack Speed"
            }
          }
        },
        single_minded_fury_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/runes.go",
              registrationType = "RegisterAura",
              functionName = "applySingleMindedFury",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Single-Minded Fury Trigger"
            }
          }
        },
        taq_damage2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage2PBonus",
              label = "S03 - Item - TAQ - Warrior - Damage 2P Bonus"
            }
          }
        },
        s03_item_taq_warrior_damage_2_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage2PBonus",
              label = "S03 - Item - TAQ - Warrior - Damage 2P Bonus"
            }
          }
        },
        taq_damage4_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage4PBonus",
              spellId = 1214166,
              auraDuration = {
                raw = "time.Second * 3",
                seconds = 3
              },
              label = "Bloodythirsty"
            }
          }
        },
        bloodythirsty = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyTAQDamage4PBonus",
              spellId = 1214166,
              auraDuration = {
                raw = "time.Second * 3",
                seconds = 3
              },
              label = "Bloodythirsty"
            }
          }
        },
        raq_tank3_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyRAQTank3PBonus",
              label = "S03 - Item - RAQ - Warrior - Tank 3P Bonus"
            }
          }
        },
        s03_item_raq_warrior_tank_3_p_bonus = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/item_sets_pve_phase_6.go",
              registrationType = "RegisterAura",
              functionName = "applyRAQTank3PBonus",
              label = "S03 - Item - RAQ - Warrior - Tank 3P Bonus"
            }
          }
        },
        sword_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
        unbridled_wrath = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
        enrage = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyEnrage",
              spellId = 13048,
              auraDuration = {
                raw = "time.Second * 12",
                seconds = 12
              },
              label = "Enrage"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyEnrage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enrage Trigger"
            }
          }
        },
        enrage_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyEnrage",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Enrage Trigger"
            }
          }
        },
        flurry = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFlurry",
              spellId = 12974,
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Flurry Proc"
            },
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
        flurry_proc_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFlurry",
              label = "Flurry Proc Trigger"
            }
          }
        },
        shield_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
        death_wish = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "registerDeathWishCD",
              spellId = 12328,
              auraDuration = {
                raw = "time.Second * 30",
                seconds = 30
              },
              label = "Death Wish"
            }
          }
        },
        last_stand = {
          aura = {
            {
              sourceFile = "extern/wowsims-sod/sim/warrior/talents.go",
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
        }
      }
    },
    consumables = {

    },
    buffs_debuffs = {

    },
    consumables_unparsed = {

    },
    diagnostic = {
      actions = {
        total_found = 23,
        matched = 23,
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
        total_found = 69,
        matched = 69,
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
      }
    },
    go_diagnostic = {
      files_scanned = 563,
      functions_scanned = 3091,
      registrations_found = 889,
      registrations_parsed = 494,
      registrations_missed = {
        {
          file = "sim/rogue/sinister_strike.go",
          ["function"] = "registerSinisterStrikeSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueSinisterStrike, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical,..."
        },
        {
          file = "sim/rogue/slice_and_dice.go",
          ["function"] = "registerSliceAndDice",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueSliceAndDice, 		ActionID:       actionID, 		Flags:          core.SpellFlagAPL, 		MetricSplits:   6,  		EnergyC..."
        },
        {
          file = "sim/rogue/shuriken_toss.go",
          ["function"] = "registerShurikenTossSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: int32(proto.RogueRune_RuneShurikenToss)}, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core.Defense..."
        },
        {
          file = "sim/rogue/backstab.go",
          ["function"] = "registerBackstabSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueBackstab, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		Def..."
        },
        {
          file = "sim/rogue/ghostly_strike.go",
          ["function"] = "registerGhostlyStrikeSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueGhostlyStrike, 		ActionID:       ghostlyStrikeAura.ActionID, 		SpellSchool:    core.SpellSchoolPhysical, 		Def..."
        },
        {
          file = "sim/rogue/item_sets_phase_6.go",
          ["function"] = "applyTAQDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_6.go",
          ["function"] = "applyTAQDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.AdrenalineRush.CD.Duration -= time.Minute * 4 		}, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_6.go",
          ["function"] = "applyTAQTank2PBonus",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Landed()..."
        },
        {
          file = "sim/rogue/item_sets_phase_6.go",
          ["function"] = "applyTAQTank4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Landed()..."
        },
        {
          file = "sim/rogue/item_sets_phase_6.go",
          ["function"] = "applyRAQDamage3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, finisher := range rogue.Finishers { 				finisher.Cost.Multiplier -..."
        },
        {
          file = "sim/rogue/poisoned_knife.go",
          ["function"] = "registerPoisonedKnife",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RoguePoisonedKnife, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RunePoisonedKnife)}, 		SpellScho..."
        },
        {
          file = "sim/rogue/_shiv.go",
          ["function"] = "registerShivSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneShiv)}, 		ClassSpellMask: ClassSpellMask_RogueShiv, 		SpellSchool:    core.SpellS..."
        },
        {
          file = "sim/rogue/garrote.go",
          ["function"] = "registerGarrote",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueGarrote, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		Defe..."
        },
        {
          file = "sim/rogue/expose_armor.go",
          ["function"] = "registerExposeArmorSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueExposeArmor, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical,..."
        },
        {
          file = "sim/rogue/hemorrhage.go",
          ["function"] = "registerHemorrhageSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueHemorrhage, 		ActionID:       actionID, 		SpellSchool:    core.SpellSchoolPhysical, 		DefenseType:    core.Def..."
        },
        {
          file = "sim/rogue/item_sets_phase_7.go",
          ["function"] = "applyNaxxramasDamage6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.OnComboPointsSpent(func(sim *core.Simulation, spell *core.Spell, co..."
        },
        {
          file = "sim/rogue/item_sets_phase_7.go",
          ["function"] = "applyNaxxramasTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_7.go",
          ["function"] = "applyNaxxramasTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_7.go",
          ["function"] = "applyNaxxramasTank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: actionID, 		Label:    fmt.Sprintf("Cheat Death (%s)", label), 		Duration: time.Second * 3, 	}...]]
        },
        {
          file = "sim/rogue/item_sets_phase_7.go",
          ["function"] = "applyNaxxramasTank6PBonus",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if rogue.CurrentHea..."
        },
        {
          file = "sim/rogue/main_gauche.go",
          ["function"] = "registerMainGaucheSpell",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueMainGauche, 		ActionID:       mainGaucheAura.ActionID, 		SpellSchool:    core.SpellSchoolPhysical, 		DefenseTy..."
        },
        {
          file = "sim/rogue/shadowstrike.go",
          ["function"] = "registerShadowstrikeSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueShadowStrike, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneShadowstrike)}, 		SpellSchool..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range rogue.Spellbook { 				if spell.Flags.Matches(SpellF..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:    fmt.Sprintf("Clearcasting (%s)", label), 		ActionID: core.ActionID{SpellID: 457342}, 		Duration: time.Second * 15, 		OnInit: func(aura *...]]
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Damage6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.OnComboPointsSpent(func(sim *core.Simulation, spell *core.Spell, co..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Tank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: core.ActionID{SpellID: 457351}, 		Label:    fmt.Sprintf("Blade Dance (%s)", label), 		Duration: core.NeverExpires, 	}...]]
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Tank2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.BladeDanceAura.ApplyOnGain(func(aura *core.Aura, sim *core.Simulati..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Tank4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			// Override Vanish's Apply Effects to prevent activating stealth 			rogue..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Tank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 457469}, 		Label:    buffLabel, 		Duration: time.Second * 10, 		OnGain: func(aura *core.Aura, sim *core.Simulatio..."
        },
        {
          file = "sim/rogue/item_sets_phase_4.go",
          ["function"] = "applyT1Tank6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.OnComboPointsSpent(func(sim *core.Simulation, spell *core.Spell, co..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "registerDeadlyPoisonSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueDeadlyPoisonTick, 		ActionID:       core.ActionID{SpellID: spellID, Tag: 100}, 		SpellSchool:    core.SpellSch..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "registerOccultPoisonSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueOccultPoisonTick, 		ActionID:       core.ActionID{SpellID: spellID, Tag: 100}, 		SpellSchool:    core.SpellSch..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "makeInstantPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueInstantPoison, 		ActionID:       core.ActionID{SpellID: spellID, Tag: int32(procSource)}, 		SpellSchool:    co..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "makeDeadlyPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: rogue.deadlyPoisonTick.SpellID, Tag: int32(procSource)}, 		Flags:    core.Ternary(procSource == DeadlyBrewProc, c..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "makeOccultPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: rogue.occultPoisonTick.SpellID, Tag: int32(procSource)}, 		Flags:    core.Ternary(procSource == DeadlyBrewProc, c..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Damage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:    fmt.Sprintf("Clearcasting (%s)", label), 		ActionID: core.ActionID{SpellID: 467735}, 		Duration: time.Second * 15, 		OnInit: func(aura *...]]
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Damage2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if (spell.Matches(Clas..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			//Applied after talents in sim so does not stack with elusiveness when ac..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Tank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.OnComboPointsGained(func(sim *core.Simulation) { 				rogue.RollingW..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Tank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.RollingWithThePunchesProcAura.ApplyOnStacksChange(func(aura *core.A..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyT2Tank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.DidDodge() |..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyZGDagger3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_5.go",
          ["function"] = "applyZGDagger5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.Ambush.BonusCritRating += 30 * core.CritRatingPerCritChance 		}, 	}..."
        },
        {
          file = "sim/rogue/saber_slash.go",
          ["function"] = "registerSaberSlashSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueSaberSlash, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneSaberSlash)}, 		SpellSchool:..."
        },
        {
          file = "sim/rogue/rupture.go",
          ["function"] = "registerRupture",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueRupture, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		Defe..."
        },
        {
          file = "sim/rogue/eviscerate.go",
          ["function"] = "registerEviscerate",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueEviscerate, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		D..."
        },
        {
          file = "sim/rogue/mutilate.go",
          ["function"] = "newMutilateHitSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueMutilateHit, 		ActionID:       actionID.WithTag(int32(core.Ternary(isMH, 1, 2))), 		SpellSchool:    core.Spell..."
        },
        {
          file = "sim/rogue/mutilate.go",
          ["function"] = "registerMutilateSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneMutilate)}, 		ClassSpellMask: ClassSpellMask_RogueMutilate, 		SpellSchool:    cor..."
        },
        {
          file = "sim/rogue/ambush.go",
          ["function"] = "registerAmbushSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueAmbush, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		Defen..."
        },
        {
          file = "sim/rogue/envenom.go",
          ["function"] = "registerEnvenom",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueEnvenom, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneEnvenom)}, 		SpellSchool:    core...."
        },
        {
          file = "sim/rogue/between_the_eyes.go",
          ["function"] = "registerBetweenTheEyes",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueBetweentheEyes, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneBetweenTheEyes)}, 		SpellSc..."
        },
        {
          file = "sim/rogue/quick_draw.go",
          ["function"] = "registerQuickDrawSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneQuickDraw)}, 		ClassSpellMask: ClassSpellMask_RogueQuickdraw, 		SpellSchool:    c..."
        },
        {
          file = "sim/rogue/item_sets_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    label, 		ActionID: core.ActionID{SpellID: 1226869}, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spe..."
        },
        {
          file = "sim/rogue/item_sets_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    label, 		ActionID: core.ActionID{SpellID: 1226871}, 	}..."
        },
        {
          file = "sim/rogue/item_sets_phase_8.go",
          ["function"] = "applyScarletEnclaveTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.RollingWithThePunchesProcAura.ApplyOnStacksChange(func(aura *core.A..."
        },
        {
          file = "sim/rogue/item_sets_phase_8.go",
          ["function"] = "applyScarletEnclaveTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.OnComboPointsSpent(func(sim *core.Simulation, spell *core.Spell, co..."
        },
        {
          file = "sim/rogue/item_sets_phase_8.go",
          ["function"] = "applyScarletEnclaveTank6PBonus",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			rogue.RollingWithThePunchesProcAura.ApplyOnStacksChange(func(aura *core.A..."
        },
        {
          file = "sim/rogue/runes.go",
          ["function"] = "registerBladeDance",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_RogueBladeDance, 		ActionID:       core.ActionID{SpellID: int32(proto.RogueRune_RuneBladeDance)}, 		SpellSchool:..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasBalance2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasBalance4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasBalance6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if starfallDot := d..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasFeral2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1218476}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _,..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasFeral4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1218477}, // Tracking in APL 		Label:    label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasFeral6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1218478}, // Tracking in APL 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, sp..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasGuardian2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasGuardian4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasGuardian6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.FrenziedRegenRageThreshold = 15 		}, 		OnSpellHitTaken: func(aura *..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Balance2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Balance4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.Matches(ClassSpellMask_DruidWrath|Cla..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Balance6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Feral2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 467207}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _,..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Feral4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.TigersFuryAura.ApplyOnGain(func(aura *core.Aura, sim *core.Simulati..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Guardian2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Landed()..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Guardian4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range []*DruidSpell{druid.MangleBear, druid.SwipeBear, dr..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Guardian6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyZGBalance3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_5.go",
          ["function"] = "applyZGBalance5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Balance4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Balance6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Feral4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 455872}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.A..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Feral6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 455873}, // Tracking in APL 		Label:    label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Guardian4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 456328}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.C..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Guardian6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 456332}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.B..."
        },
        {
          file = "sim/druid/items.go",
          ["function"] = "newBloodbarkCleaveItem",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{ItemID: itemID},  		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer:    druid.NewTimer(), 				Duration: time.Minute..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveBalance2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnApplyEffects: func(aura *core.Aura, sim *core.Simulation, target *core.Unit, spell *core.Spell) { 			if spell.Matches(ClassSpell..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveBalance4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.StarsurgeAura.MaxStacks += 1 		}, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveBalance6PBonus",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matc..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveFeral2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226109}, 		Label:    label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spe..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveFeral4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226116}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			// Q: wtf is this?? 			//..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveFeral6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226119}, 		Label:    label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveGuardian2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveGuardian4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.BerserkAura.Duration += time.Second * 15 		}, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQBalance2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid.NaturesGraceProcAura.MaxStacks += 1 		}, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQBalance4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQFeral2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1213171}, // Tracking in APL 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			druid...."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQFeral4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1213174}, // Tracking in APL 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, sp..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQGuardian2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if druid.form == Be..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQGuardian4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/druid/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQFeral3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/common/sod/enchant_effects.go",
          ["function"] = "registerDeathKnightDiseaseSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    actionID, 			SpellSchool: core.SpellSchoolPhysical, 			DefenseType: core.DefenseTypeMelee, 			ProcMask:    core.ProcMaskMeleeMHSpeci..."
        },
        {
          file = "sim/shaman/water_totems.go",
          ["function"] = "newHealingStreamTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: healId}, 		SpellSchool: core.SpellSchoolNature, 		ProcMask:    core.ProcMaskSpellHealing, 		Flags:       core...."
        },
        {
          file = "sim/shaman/riptide.go",
          ["function"] = "registerRiptideSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.ShamanRune_RuneBracersRiptide)}, 		ClassSpellMask: ClassSpellMask_ShamanRiptide, 		SpellSchool:..."
        },
        {
          file = "sim/shaman/molten_blast.go",
          ["function"] = "applyMoltenBlast",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.ShamanRune_RuneHandsMoltenBlast)}, 		ClassSpellMask: ClassSpellMask_ShamanMoltenBlast, 		SpellS..."
        },
        {
          file = "sim/shaman/lava_lash.go",
          ["function"] = "applyLavaLash",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_ShamanLavaLash, 		ActionID:       core.ActionID{SpellID: int32(proto.ShamanRune_RuneHandsLavaLash)}, 		SpellSchool:..."
        },
        {
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newSearingTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_ShamanSearingTotemAttack, 		ActionID:       core.ActionID{SpellID: SearingTotemSpellId[rank]}.WithTag(1), 		SpellSc..."
        },
        {
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newMagmaTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_ShamanMagmaTotemAttack, 		ActionID:       core.ActionID{SpellID: MagmaTotemAoeSpellId[rank]}, 		SpellSchool:    cor..."
        },
        {
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newFireNovaTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_ShamanFireNovaTotemAttack, 		ActionID:       core.ActionID{SpellID: FireNovaTotemAoeSpellId[rank]}, 		SpellSchool:..."
        },
        {
          file = "sim/shaman/feral_spirit.go",
          ["function"] = "registerFeralSpiritCD",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_ShamanFeralSpirit,  		ManaCost: core.ManaCostOptions{ 			BaseCost: 0.12, 		}, 		Cast: c..."
        },
        {
          file = "sim/shaman/frostbrand_weapon.go",
          ["function"] = "newFrostbrandImbueSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellId}, 		SpellSchool: core.SpellSchoolFrost, 		DefenseType: core.DefenseTypeMagic, 		ProcMask:    core.Proc..."
        },
        {
          file = "sim/shaman/water_shield.go",
          ["function"] = "registerWaterShieldSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_ShamanWaterShield, 		ProcMask:       core.ProcMaskEmpty, 		Flags:          core.SpellFl..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasElemental2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasElemental4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasElemental6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.ActionID.Tag == CastTagOverload {..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasEnhancement2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasEnhancement4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasEnhancement6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			oldOnRefresh := shaman.MaelstromWeaponAura.OnRefresh 			shaman.MaelstromW..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			if hasRune { 				hitMod..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.shamanisticRageDRMultiplier += shamRageDRBonus 			shaman.Shamanist..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			for _, target := range undeadTargets { 				for _, at := range target.Atta..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Elemental2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if shaman.isShamanD..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Elemental4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			if shaman.LoyalBetaAura == nil { 				return 			}  			shaman.LoyalBetaAura..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Elemental6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.ClearcastingAura.ApplyOnGain(func(aura *core.Aura, sim *core.Simul..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Tank4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.DidBlock(..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Tank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.DidBlock(..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "func",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.staticSHocksProcChance += 0.06 		}, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Enhancement4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Enhancement6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(t26pAura *core.Aura, sim *core.Simulation) { 			for _, aura := range shaman.LightningShieldAuras { 				if aura == nil..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Restoration2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.ProcMask.M..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Restoration4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Restoration6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyZGTank3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_5.go",
          ["function"] = "applyZGTank5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.powerSurgeProcChance += .05 		}, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Elemental4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Elemental6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			flameShockSpells = core.FilterSlice(shaman.FlameShock, func(spell *core.S..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Enhancement4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Enhancement6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.bonusFlurrySpeed += .10 		}, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.DidParry(..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.DidParry(..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range shaman.StoneskinTotem { 				if spell == nil {..."
        },
        {
          file = "sim/shaman/flametongue_weapon.go",
          ["function"] = "newFlametongueImbueSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_ShamanFlametongueProc, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolFire,..."
        },
        {
          file = "sim/shaman/ancestral_guidance.go",
          ["function"] = "applyAncestralGuidance",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_ShamanAncestralGuidance, 		SpellSchool:    core.SpellSchoolNature, 		Flags:          co..."
        },
        {
          file = "sim/shaman/bloodlust.go",
          ["function"] = "registerBloodlustCD",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ // 		ActionID: actionID, // 		Flags:    core.SpellFlagAPL,  // 		ManaCost: core.ManaCostOptions{ // 			BaseCost:   0.26, // 			Multiplier: 1 - 0.02*..."
        },
        {
          file = "sim/shaman/lightning_shield.go",
          ["function"] = "registerNewLightningShieldSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: procSpellId}, 		ClassSpellMask: ClassSpellMask_ShamanLightningShieldProc, 		SpellSchool:    core.SpellSchoo..."
        },
        {
          file = "sim/shaman/lightning_shield.go",
          ["function"] = "registerNewLightningShieldSpell",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:     fmt.Sprintf("Lightning Shield (Rank %d)", rank), 		ActionID:  core.ActionID{SpellID: spellId}, 		Duration:  time.Minute * 10, 		MaxStac...]]
        },
        {
          file = "sim/shaman/lightning_shield.go",
          ["function"] = "registerNewLightningShieldSpell",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellId}, 		ClassSpellMask: ClassSpellMask_ShamanLightningShield, 		ProcMask:       core.ProcMaskEmpty, 		F..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveElemental2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226961}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			if shaman.FlameShock[5] !..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveElemental4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226977}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.overloadProcChance..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveElemental6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226978}, 		Label:    label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveEnhancement2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226984}, 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, re..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveEnhancement4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226986}, 		Label:    label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveEnhancement6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:    label + " - 2h maelstrom bonus", 		Duration: core.NeverExpires, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			shaman.maelst...]]
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveEnhancement6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226997}, 		Label:    label, 		OnInit: func(_ *core.Aura, sim *core.Simulation) { 			shaman.MaelstromWeaponAura.M..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1227153}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.ShieldMasteryAura...."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveTank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1227164}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.ShieldMasteryAura...."
        },
        {
          file = "sim/shaman/ancestral_awakening.go",
          ["function"] = "applyAncestralAwakening",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.ShamanRune_RuneFeetAncestralAwakening)}, 		ClassSpellMask: ClassSpellMask_ShamanAncestralAwaken..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQElemental2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			affectedPushbackSpells := core.FilterSlice( 				core.Flatten( 					[][]*c..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQElemental4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Landed()..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 			Label:      label, 			BuildPhase: core.CharacterBuildPhaseBuffs, 		}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQEnhancement2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/shaman/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQElemental3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			shaman.useLavaBurstCritScaling = true 		}, 	}..."
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "makeFlurryAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:     label, 		ActionID:  core.ActionID{SpellID: spellID}, 		Duration:  core.NeverExpires, 		MaxStacks: 3, 	}..."
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "makeFlurryConsumptionTrigger",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			// Remove a stack...."
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "registerManaTideTotemCD",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ // 		ActionID: core.ManaTideTotemActionID, // 		Cast: core.CastConfig{ // 			DefaultCast: core.Cast{ // 				GCD: time.Second, // 			}, // 			IgnoreH..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newClaw",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetClaw, 		SpellSchool:    core.SpellSchoolPhysical, 		Def..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newBite",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetBite, 		SpellSchool:    core.SpellSchoolPhysical, 		Def..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newLightningBreath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetLightningBreath, 		SpellSchool:    core.SpellSchoolNatu..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newScreech",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetScreech, 		SpellSchool:    core.SpellSchoolPhysical,..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newScorpidPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetScorpidPoison, 		SpellSchool:    core.SpellSchoolNature..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newLavaBreath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: spellID}, 		ClassSpellMask: ClassSpellMask_HunterPetLavaBreath, 		SpellSchool:    core.SpellSchoolFire, 		D..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasMelee2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasMelee4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasMelee6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Target.Mo..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRanged2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRanged4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRanged6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Target.Mo..."
        },
        {
          file = "sim/hunter/aspects.go",
          ["function"] = "createImprovedHawkAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    auraLabel, 		ActionID: actionID, 		Duration: time.Second * 12, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			if isMelee {..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Melee2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Melee4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Melee6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 467334}, // Tracking in APL 		Label:    label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulatio..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Ranged4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: core.ActionID{SpellID: 467312}, 		Label:    label + " Proc", 		Duration: time.Second * 12, 		OnGain: func(aura *core.Aura, sim *core.Sim...]]
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Ranged6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hunter.SerpentStingAPCoeff += 0.25 		}, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyZGBeastmaster3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			oldStatInheritance := hunter.pet.GetStatInheritance() 			hunter.pet.Updat..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_5.go",
          ["function"] = "applyZGBeastmaster5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hunter.pet.AddFocusRegenMultiplier(0.20) 		}, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Melee2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Class..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Melee4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, unit := range sim.Environment.Encounter.TargetUnits { 				for _, a..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Melee6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.ProcMask.Matc..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Ranged4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, unit := range sim.Environment.Encounter.TargetUnits { 				for _, a..."
        },
        {
          file = "sim/hunter/raptor_strike.go",
          ["function"] = "newRaptorStrikeHitSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_HunterRaptorStrikeHit, 		ActionID:       core.ActionID{SpellID: spellID}.WithTag(core.TernaryInt32(isMH, 1, 2)),..."
        },
        {
          file = "sim/hunter/raptor_strike.go",
          ["function"] = "makeQueueSpellsAndAura",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_HunterRaptorStrike, 		ActionID:       hunter.RaptorStrike.WithTag(3), 		Flags:          core.SpellFlagMeleeMetrics..."
        },
        {
          file = "sim/hunter/focus_fire.go",
          ["function"] = "registerFocusFireSpell",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       focusFireActionId, 		Flags:          core.SpellFlagAPL, 		ClassSpellMask: ClassSpellMask_HunterFocusFire, 		ExtraCastCondition: fu..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveMelee6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hunter.RaptorFuryDamageMultiplier += 15 		}, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveRanged6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hunter.MultiShotTargetCount += 2 		}, 	}..."
        },
        {
          file = "sim/hunter/runes.go",
          ["function"] = "applyCatlikeReflexes",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			hunter.AddBuildPhaseSta..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQMelee2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			if hunter.pet != nil { 				hunter.pet.IncreaseMaxFocus(50) 			} 		}, 		On..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQMelee4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQMelee4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 			Label: label, 		}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQRanged2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: TAQRanged2PBonusLabel, 	}..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQRanged4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			if !hunter.HasRune(proto.HunterRune_RuneHelmRapidKilling) { 				return..."
        },
        {
          file = "sim/hunter/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQBeastmastery5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hunter.pet.AddFocusRegenMultiplier(1.00) 		}, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasShadow2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasShadow4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasHealer2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/vampiric_touch.go",
          ["function"] = "registerVampiricTouchSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_PriestVampiricTouch, 		ActionID:       core.ActionID{SpellID: int32(proto.PriestRune_RuneCloakVampiricTouch)}, 		Sp..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Shadow2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Shadow4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matc..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Shadow6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			priest.SpiritTapAura.AttachMultiplicativePseudoStatBuff(&priest.PseudoSta..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Healer2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Healer4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicHealDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.ProcMa..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_5.go",
          ["function"] = "applyZGDiscipline3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/void_plague.go",
          ["function"] = "registerVoidPlagueSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.PriestRune_RuneFeetVoidPlague)}, 		ClassSpellMask: ClassSpellMask_PriestVoidPlague, 		SpellScho..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Shadow4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/priest/dispersion.go",
          ["function"] = "registerDispersionSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionId, 		ClassSpellMask: ClassSpellMask_PriestDispersion,  		Cast: core.CastConfig{ 			DefaultCast: core.Cast{ 				GCD: core.GC..."
        },
        {
          file = "sim/priest/homunculi.go",
          ["function"] = "registerHomunculiSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskEmpty, 		Flags:       core.SpellFlagAPL,  		Cast: core.C..."
        },
        {
          file = "sim/priest/void_zone.go",
          ["function"] = "registerVoidZoneSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.PriestRune_RuneBracersVoidZone)}, 		ClassSpellMask: ClassSpellMask_PriestVoidZone, 		SpellSchoo..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveShadow2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			mindFlay := core.FilterSlice( 				core.Flatten(priest.MindFlay), 				func..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveShadow4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveShadow6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matc..."
        },
        {
          file = "sim/priest/eye_of_the_void.go",
          ["function"] = "registerEyeOfTheVoidCD",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskEmpty, 		Flags:       core.SpellFlagAPL,  		Cast: core.C..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQShadow2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spells := range priest.MindFlay { 				for _, spell := range spells..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQShadow4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/priest/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQShadow3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			priest.PainAndSufferingDoTSpells = append( 				priest.PainAndSufferingDoT..."
        },
        {
          file = "sim/priest/talents.go",
          ["function"] = "applyShadowWeaving",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: core.ShadowWeavingSpellIDs[int(priest.Talents.ShadowWeaving)]}, 		Flags:       core.SpellFlagNoOnCastComplete..."
        },
        {
          file = "sim/warlock/immolation_aura.go",
          ["function"] = "registerImmolationAuraSpell",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.WarlockRune_RuneBracerImmolationAura)}, 		ClassSpellMask: ClassSpellMask_WarlockImmolationAura,..."
        },
        {
          file = "sim/warlock/drain_life.go",
          ["function"] = "getDrainLifeBaseConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    core.ProcMaskSpellHealing, 		Flags:       core.SpellFlag..."
        },
        {
          file = "sim/warlock/item_sets_pvp.go",
          ["function"] = "applyPhase5PvP3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfRecklessnessSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_WarlockCurseOfRecklessness, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolSh..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfElementsSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_WarlockCurseOfElements, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolShadow..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfShadowSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_WarlockCurseOfShadow, 		ActionID:       core.ActionID{SpellID: spellID}, 		SpellSchool:    core.SpellSchoolShadow,..."
        },
        {
          file = "sim/warlock/infernal_armor.go",
          ["function"] = "registerInfernalArmorCD",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_WarlockInfernalArmor, 		SpellSchool:    core.SpellSchoolShadow,  		Cast: core.CastConfi..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: spellConfig.SpellID}, 			ClassSpellMask: spellConfig.ClassMask, 			SpellSchool:    spellConfig.SpellSchool..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			affectedDotSpells = core.FilterSlice( 				core.Flatten([][]*core.Spell{..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range warlock.CurseOfAgony { 				oldApplyEffects := spell..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasTank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if warlock.Vengeanc..."
        },
        {
          file = "sim/warlock/siphon_life.go",
          ["function"] = "getSiphonLifeBaseConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellId}.WithTag(1), 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskSpellHealing, 		Flags:..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Tank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Tank4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Tank6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnReset: func(aura *core.Aura, sim *core.Simulation) { 			shieldIncreaseAmount = 0.0 			currentShieldAmount = 0.0 		}, 		OnSpellHi..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range warlock.Spellbook { 				if spell.Matches(ClassSpell..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matc..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label: label + " - Felguard Bonus", 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) {...]]
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyZGDemonology3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, pet := range warlock.BasePets { 				oldStatInheritance := pet.GetS..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_5.go",
          ["function"] = "applyZGDemonology5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			warlock.masterDemonologistMultiplier += .50 		}, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(_ *core.Aura, _ *core.Simulation) { 			warlock.nightfallProcChance += 0.04 		}, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if icd.IsReady(sim)..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Landed()..."
        },
        {
          file = "sim/warlock/death_coil.go",
          ["function"] = "getDeathCoilBaseConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellId}.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    core.ProcMaskSpellHealing, 		Flag..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if result.Did..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveTank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			warlock.InfernalArmor.RelatedSelfBuff.ApplyOnGain(func(aura *core.Aura, s..."
        },
        {
          file = "sim/warlock/runes.go",
          ["function"] = "applyVengeance",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID,  		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer:    warlock.NewTimer(), 				Duration: time.Minute * 3, 			}, 		},..."
        },
        {
          file = "sim/warlock/runes.go",
          ["function"] = "applyInvocation",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: spellConfig.SpellID}, 			ClassSpellMask: spellConfig.ClassMask, 			SpellSchool:    spellConfig.SpellSchool..."
        },
        {
          file = "sim/warlock/runes.go",
          ["function"] = "applyGrimoireOfSynergy",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 			Label:                 fmt.Sprintf("Grimoire of Synergy Trigger (%s)", pet.Name), 			OnSpellHitDealt:       handlerFunc(petProcAura), 			OnPeriod...]]
        },
        {
          file = "sim/warlock/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, target := range warlock.Env.Encounter.TargetUnits { 				warlock.Im..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQDamage4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			warlock.maintainBuffsOnSacrifice = true 		}, 	}..."
        },
        {
          file = "sim/warlock/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQTank3PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.Matches(ClassSpellMask_WarlockShadowC..."
        },
        {
          file = "sim/warlock/talents.go",
          ["function"] = "applyFirestone",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: spellId}, 			SpellSchool: core.SpellSchoolFire, 			DefenseType: core.DefenseTypeMagic, 			ProcMask:    core.P..."
        },
        {
          file = "sim/warlock/imp.go",
          ["function"] = "registerImpFireboltSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_WarlockSummonImpFireBolt, 		ActionID:       core.ActionID{SpellID: spellId}, 		SpellSchool:    core.SpellSchoolFire..."
        },
        {
          file = "sim/warlock/succubus.go",
          ["function"] = "registerSuccubusLashOfPainSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_WarlockSummonSuccubusLashOfPain, 		ActionID:       core.ActionID{SpellID: spellId}, 		SpellSchool:    core.SpellSch..."
        },
        {
          file = "sim/paladin/aura_mastery.go",
          ["function"] = "registerAuraMastery",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID, 		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer:    paladin.NewTimer(), 				Duration: time.Minute * 2, 			}, 		}, 		A..."
        },
        {
          file = "sim/paladin/crusader_strike.go",
          ["function"] = "registerCrusaderStrike",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolHoly, 		DefenseType: core.DefenseTypeMelee, 		ProcMask:    core.ProcMaskMeleeMHSpecial, 		Fl..."
        },
        {
          file = "sim/paladin/shield_of_righteousness.go",
          ["function"] = "registerShieldOfRighteousness",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.PaladinRune_RuneCloakShieldOfRighteousness)}, 		SpellSchool:    core.SpellSchoolHoly, 		Defense..."
        },
        {
          file = "sim/paladin/avengers_shield.go",
          ["function"] = "registerAvengersShield",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.PaladinRune_RuneLegsAvengersShield)}, 		ClassSpellMask: ClassSpellMask_PaladinAvengersShield,..."
        },
        {
          file = "sim/paladin/lay_on_hands.go",
          ["function"] = "registerLayOnHands",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ProcMask:       core.ProcMaskSpellHealing, 		Flags:          core.SpellFlagAPL | core.SpellFlagMCD, 		SpellSchool:..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "func",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      bonusLabel, 		ActionID:   core.ActionID{SpellID: PaladinT1Prot2P}, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT1Prot6P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT1Prot6P}, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for i, value..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Prot2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Prot2P}, 		OnInit: func(_ *core.Aura, _ *core.Simulation) { 			for i, hsAura :=..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Prot4P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Prot4P}, 		OnInit: func(_ *core.Aura, _ *core.Simulation) { 			for i, hsAura :=..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinTAQProt2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:   core.ActionID{SpellID: PaladinTAQProt2P}, 		Label:      bonusLabel, 		BuildPhase: core.CharacterBuildPhaseBuffs, 		OnGain: func(aura *..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinTAQProt4P",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTAQProt4P}, 		Label:    bonusLabel, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT1Holy4P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      bonusLabel, 		ActionID:   core.ActionID{SpellID: PaladinT1Holy4P}, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Holy2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Holy2P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Holy4P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Holy4P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT1Ret4P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      bonusLabel, 		ActionID:   core.ActionID{SpellID: PaladinT1Ret4P}, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT1Ret6P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT1Ret6P}, 		OnReset: func(aura *core.Aura, sim *core.Simulation) { 			paladin.ling..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Ret2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Ret2P}, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			// Made to en..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Ret4P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Ret4P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinT2Ret6P",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinT2Ret6P}, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			originalApply..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinTAQRet2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinTAQRet2P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinTAQRet4P",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinTAQRet4P}, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *c..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinZG2P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      bonusLabel, 		ActionID:   core.ActionID{SpellID: PaladinZG2P}, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinZG3P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinZG3P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinZG5P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinZG5P}, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve.go",
          ["function"] = "applyPaladinRAQ3P",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    bonusLabel, 		ActionID: core.ActionID{SpellID: PaladinRAQ3P}, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			if !paladin.has..."
        },
        {
          file = "sim/paladin/hammer_of_wrath.go",
          ["function"] = "registerHammerOfWrath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:     core.ActionID{SpellID: rank.spellID}, 			SpellSchool:  core.SpellSchoolHoly, 			DefenseType:  core.DefenseTypeRanged, 			ProcMask:..."
        },
        {
          file = "sim/paladin/consecration.go",
          ["function"] = "registerConsecration",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMagic, 			ProcMask:    c..."
        },
        {
          file = "sim/paladin/sotc.go",
          ["function"] = "registerSealOfTheCrusader",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.judge.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMagic, 			ProcMask..."
        },
        {
          file = "sim/paladin/sotc.go",
          ["function"] = "registerSealOfTheCrusader",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL | core.SpellFlagBatchStartAttackMacro,  			Re..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRetribution2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinT3Ret2P}, 		Label:    label, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRetribution4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinT3Ret4P}, 		Label:    label, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasRetribution6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinT3Ret6P}, 		Label:    label, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			damageMod.Activate..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:   core.ActionID{SpellID: PaladinT3Prot2P}, 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinT3Prot4P}, 		Label:    label, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinT3Prot6P}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			// Implemented in..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasHoly2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/paladin/holy_wrath.go",
          ["function"] = "registerHolyWrath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ClassSpellMask: ClassSpellMask_PaladinHolyWrath, 			ActionID:       core.ActionID{SpellID: rank.spellID}, 			SpellSchool:    core.SpellSchoolHoly..."
        },
        {
          file = "sim/paladin/holy_shock.go",
          ["function"] = "registerHolyShock",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMagic, 			ProcMask:    c..."
        },
        {
          file = "sim/paladin/divine_favor.go",
          ["function"] = "registerDivineFavor",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: aura.ActionID, 		Cast: core.CastConfig{ 			CD: cd, 		}, 		ApplyEffects: func(sim *core.Simulation, _ *core.Unit, _ *core.Spell) { 			aur..."
        },
        {
          file = "sim/paladin/exorcism.go",
          ["function"] = "registerExorcism",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMagic, 			ProcMask:    c..."
        },
        {
          file = "sim/paladin/soc.go",
          ["function"] = "registerSealOfCommand",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.judge.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMelee, 			ProcMask..."
        },
        {
          file = "sim/paladin/soc.go",
          ["function"] = "registerSealOfCommand",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: rank.proc.spellID}, 			SpellSchool:    core.SpellSchoolHoly, 			DefenseType:    core.DefenseTypeMelee,..."
        },
        {
          file = "sim/paladin/soc.go",
          ["function"] = "registerSealOfCommand",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL | core.SpellFlagBatchStartAttackMacro,  			Re..."
        },
        {
          file = "sim/paladin/hammer_of_the_righteous.go",
          ["function"] = "registerHammerOfTheRighteous",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.PaladinRune_RuneWristHammerOfTheRighteous)}, 		SpellSchool:    core.SpellSchoolHoly, 		DefenseT..."
        },
        {
          file = "sim/paladin/divine_storm.go",
          ["function"] = "registerDivineStorm",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_PaladinDivineStorm, 		SpellSchool:    core.SpellSchoolPhysical, 		DefenseType:    core...."
        },
        {
          file = "sim/paladin/holy_shield.go",
          ["function"] = "registerHolyShield",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: procID}, 			ClassSpellMask: ClassSpellMask_PaladinHolyShieldProc, 			SpellSchool:    core.SpellSchoolHoly,..."
        },
        {
          file = "sim/paladin/holy_shield.go",
          ["function"] = "registerHolyShield",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: spellID}, 			ClassSpellMask: ClassSpellMask_PaladinHolyShield, 			Flags:          core.SpellFlagAPL, 			Re..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.judge.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMagic, 			ProcMask..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: rank.proc.spellID}, 			SpellSchool:    core.SpellSchoolHoly, 			DefenseType:    core.DefenseTypeMelee,..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL | core.SpellFlagBatchStartAttackMacro,  			Re..."
        },
        {
          file = "sim/paladin/blessing_of_sanctuary.go",
          ["function"] = "registerBlessingOfSanctuary",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 				ActionID:    actionID, 				SpellSchool: core.SpellSchoolHoly, 				DefenseType: core.DefenseTypeMagic, 				ProcMask:    core.ProcMaskSpellDamage,..."
        },
        {
          file = "sim/paladin/som.go",
          ["function"] = "registerSealOfMartyrdom",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    aura.ActionID, 		SpellSchool: core.SpellSchoolHoly, 		Flags:       core.SpellFlagAPL | core.SpellFlagBatchStartAttackMacro,  		ManaCo..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveRetribution2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSERet2P}, 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.S..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDps4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSERet4P}, 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.S..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveRetribution6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSERet6P}, 		Label:    label, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveShockadin2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEShock2P}, 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveShockadin6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEShock6P}, 		Label:    label, 	}..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEProt2P}, 		Label:    label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core...."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEProt4P}, 		Label:    label, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			damageMod.Activa..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEProt6P}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			paladin.avenging..."
        },
        {
          file = "sim/paladin/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveHoly2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: PaladinTSEHoly2P}, 		Label:    label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.S..."
        },
        {
          file = "sim/paladin/runes.go",
          ["function"] = "registerMalleableProtection",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_PaladinDivineProtection, 		Flags:          core.SpellFlagAPL | SpellFlag_Forbearance,..."
        },
        {
          file = "sim/mage/icy_veins.go",
          ["function"] = "registerIcyVeinsSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolFrost,  		ManaCost: core.ManaCostOptions{ 			BaseCost: manaCost, 		}, 		Cast: core.CastConfi..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1218700}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			hot := mage.Evocation.Sel..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1218995}, 		Label:    label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			oldProcIgnite := mage.pro..."
        },
        {
          file = "sim/mage/frostfire_bolt.go",
          ["function"] = "registerFrostfireBoltSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_MageFrostfireBolt, 		SpellSchool:    core.SpellSchoolFrost | core.SpellSchoolFire, 		De..."
        },
        {
          file = "sim/mage/spellfrost_bolt.go",
          ["function"] = "registerSpellfrostBoltSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneBeltSpellfrostBolt)}, 		ClassSpellMask: ClassSpellMask_MageSpellfrostBolt, 		Spell..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			fireballSpells := mage.GetSpellsMatchingClassMask(ClassSpellMask_MageFire..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 467399}, 		Label:    label, 		OnReset: func(aura *core.Aura, sim *core.Simulation) { 			bonusDamage = 0 		}, 		On..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Healer4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			mage.ArcaneBlastMissileBarrageChance += .10 		}, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyZGFrost3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			mage.FingersOfFrostProcChance += .15 		}, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_5.go",
          ["function"] = "applyZGFrost5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/mage/arcane_missiles.go",
          ["function"] = "getArcaneMissilesTickSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_MageArcaneMissilesTick, 		ActionID:       core.ActionID{SpellID: spellId}.WithTag(1), 		SpellSchool:    core.SpellS..."
        },
        {
          file = "sim/mage/frozen_orb.go",
          ["function"] = "registerFrozenOrbCD",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ClassSpellMask: ClassSpellMask_MageFrozenOrb, 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneCloakFrozenOrb)}, 		SpellSchool:..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage4PBonus",
          registration_index = 4,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.SpellSchool.Matches(core.SpellSchoolP..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:   core.ActionID{SpellID: 456402}, 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 		OnGain: func(aura *core.Aura, sim..."
        },
        {
          file = "sim/mage/living_bomb.go",
          ["function"] = "registerLivingBombSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID.WithTag(1), 		ClassSpellMask: ClassSpellMask_MageLivingBombExplosion, 		SpellSchool:    core.SpellSchoolFire, 		DefenseTy..."
        },
        {
          file = "sim/mage/living_bomb.go",
          ["function"] = "registerLivingBombSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_MageLivingBomb, 		SpellSchool:    core.SpellSchoolFire, 		ProcMask:       core.ProcMask..."
        },
        {
          file = "sim/mage/arcane_surge.go",
          ["function"] = "registerArcaneSurgeSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		ClassSpellMask: ClassSpellMask_MageArcaneSurge, 		SpellSchool:    core.SpellSchoolArcane, 		DefenseType:    core.Defen..."
        },
        {
          file = "sim/mage/mass_regeneration.go",
          ["function"] = "registerMassRegenerationSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneLegsMassRegeneration)}, 		ClassSpellMask: ClassSpellMask_MageMassRegeneration, 		S..."
        },
        {
          file = "sim/mage/balefire_bolt.go",
          ["function"] = "registerBalefireBoltSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneBracersBalefireBolt)}, 		ClassSpellMask: ClassSpellMask_MageBalefireBolt, 		SpellS..."
        },
        {
          file = "sim/mage/ice_barrier.go",
          ["function"] = "newIceBarrierSpellConfig",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: core.ActionID{SpellID: spellID}, 		Label:    fmt.Sprintf("Ice Barrier (Rank %d)", rank), 		Duration: time.Minute, 		OnGain: func(aura *c...]]
        },
        {
          file = "sim/mage/arcane_barrage.go",
          ["function"] = "registerArcaneBarrageSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneCloakArcaneBarrage)}, 		ClassSpellMask: ClassSpellMask_MageArcaneBarrage, 		SpellS..."
        },
        {
          file = "sim/mage/ice_lance.go",
          ["function"] = "registerIceLanceSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneHandsIceLance)}, 		ClassSpellMask: ClassSpellMask_MageIceLance, 		SpellSchool:..."
        },
        {
          file = "sim/mage/deep_freeze.go",
          ["function"] = "registerDeepFreezeSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneHelmDeepFreeze)}, 		ClassSpellMask: ClassSpellMask_MageDeepFreeze, 		SpellSchool:..."
        },
        {
          file = "sim/mage/living_flame.go",
          ["function"] = "registerLivingFlameSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: int32(proto.MageRune_RuneLegsLivingFlame)}, 		ClassSpellMask: ClassSpellMask_MageLivingFlame, 		SpellSchool..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226423}, 		Label:    label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226446}, 		Label:    label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226432}, 		Label:    label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveHealer2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: 1226407}, 		Label:    label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveHealer4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveHealer6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			mage.ArcanePower.RelatedSelfBuff.ApplyOnGain(func(aura *core.Aura, sim *c..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQFire4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQArcane2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			mage.ArcaneBlastDamageMultiplier += 0.10 		}, 	}..."
        },
        {
          file = "sim/mage/item_sets_pve_phase_6.go",
          ["function"] = "applyRAQFire3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			dotSpells = core.FilterSlice(mage.Spellbook, func(spell *core.Spell) bool..."
        },
        {
          file = "sim/mage/talents.go",
          ["function"] = "applyShatter",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 				Label:    fmt.Sprintf("Shatter (%s)", mage.LogLabel()), 				Duration: core.NeverExpires, 			}...]]
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasDamage6PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.ProcMask.M..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		BuildPhase: core.CharacterBuildPhaseBuffs, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_7.go",
          ["function"] = "applyNaxxramasProtection6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitTaken: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if warrior.LastStan..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Damage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			affectedSpells = warrior.GetSpellsMatchingClassMask(ClassSpellMask_Warrio..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Protection2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.ProcMask.M..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Protection4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyT2Protection6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if !spell.ProcMask...."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyZGGladiator3PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_5.go",
          ["function"] = "applyZGGladiator5PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			idx := slices.IndexFunc(warrior.GladiatorStanceAura.ExclusiveEffects, fun..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage2PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.Matches(StanceCodes) { 				tacticianA..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage4PBonus",
          registration_index = 5,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			if spell.Matches(StanceCodes) { 				switch war..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Damage6PBonus",
          registration_index = 3,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnCastComplete: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell) { 			switch spell.ClassSpellMask { 			case ClassSpe..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_4.go",
          ["function"] = "applyT1Tank6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			warrior.CleaveTargetCount += 1 			warrior.bloodSurgeClassMask |= ClassSpe..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID:  core.ActionID{SpellID: 1227232}, 		Label:     label + " Stacking Buff", // TODO: Find real buff 		Duration:  time.Second * 15, 		MaxSta...]]
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveDamage6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnPeriodicDamageDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matc..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: core.ActionID{SpellID: 1227242}, // TODO: Find real spell 		Label:    label + " Strength buff", 		Duration: DefaultRecklessnessDuration...]]
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			for _, spell := range []*WarriorSpell{warrior.Recklessness, warrior.Retal..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_8.go",
          ["function"] = "applyScarletEnclaveProtection6PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID:  core.ActionID{SpellID: 1227245}, // TODO: Find real spell 		Label:     label + " Stacking Buff", 		Duration:  time.Second * 15, 		MaxSt...]]
        },
        {
          file = "sim/warrior/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQDamage4PBonus",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if (spell.Matches(C..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank2PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnInit: func(aura *core.Aura, sim *core.Simulation) { 			warrior.ThunderClap.CD.Duration = 0 		}, 	}..."
        },
        {
          file = "sim/warrior/item_sets_pve_phase_6.go",
          ["function"] = "applyTAQTank4PBonus",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(aura *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			if spell.Matches(Cl..."
        },
        {
          file = "sim/warrior/talents.go",
          ["function"] = "makeFlurryAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:     label, 		ActionID:  core.ActionID{SpellID: spellID}, 		Duration:  core.NeverExpires, 		MaxStacks: 3, 	}..."
        },
        {
          file = "sim/warrior/talents.go",
          ["function"] = "makeFlurryConsumptionTrigger",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label: label, 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell *core.Spell, result *core.SpellResult) { 			// Remove a stack...."
        }
      }
    }
  }
