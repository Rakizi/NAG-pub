-- Generated schema for classic on 2025-07-03 22:04:29
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['vanilla'] = {
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
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
                  sourceFile = "extern/wowsims-classic/sim/priest/power_infusion.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/vampiric_embrace.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/vampiric_embrace.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerVampiricEmbraceSpell",
                  spellId = 15286,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                  Flags = "SpellFlagPriest | core.SpellFlagAPL",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyDarkness",
                  label = "Darkness"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerShadowform",
                  spellId = 15473,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
		}]],
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
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
          juju_ember = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          juju_chill = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          juju_escape = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          juju_flurry = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          raptor_punch = {
            id = 6,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "bogling_root",
          "juju_ember",
          "juju_chill",
          "juju_escape",
          "juju_flurry",
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
          shadow_protection = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          shadow_resistance_aura = {
            id = 35,
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
            id = 32,
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
            id = 33,
            type = "bool",
            label = "optional"
          },
          battle_squawk = {
            id = 34,
            type = "int32",
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
          "thorns",
          "devotion_aura",
          "stoneskin_totem",
          "retribution_aura",
          "sanctity_aura",
          "battle_squawk"
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
          "sayges_fortune",
          "spirit_of_zandalar",
          "songflower_serenade",
          "warchiefs_blessing",
          "fengus_ferocity",
          "moldars_moxie",
          "slipkiks_savvy"
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
            id = 25,
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
            id = 22,
            type = "bool",
            label = "optional"
          },
          stormstrike = {
            id = 23,
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
          thunder_clap = {
            id = 16,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          thunderfury = {
            id = 24,
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
          hunters_mark = {
            id = 19,
            type = "enum",
            label = "optional",
            enum_type = "TristateEffect"
          },
          gift_of_arthas = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          crystal_yield = {
            id = 20,
            type = "bool",
            label = "optional"
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
          "winters_chill",
          "improved_shadow_bolt",
          "improved_scorch",
          "shadow_weaving",
          "stormstrike",
          "expose_armor",
          "sunder_armor",
          "curse_of_weakness",
          "curse_of_recklessness",
          "demoralizing_roar",
          "demoralizing_shout",
          "thunder_clap",
          "thunderfury",
          "insect_swarm",
          "scorpid_sting",
          "hunters_mark",
          "gift_of_arthas",
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
          "random_suffix",
          "enchant"
        }
      },
      SimItem = {
        fields = {
          id = {
            id = 1,
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
          bonus_physical_damage = {
            id = 19,
            type = "double",
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
          }
        },
        oneofs = {

        },
        field_order = {
          "id",
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
          "bonus_physical_damage",
          "set_name",
          "set_id",
          "weapon_skills"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "items",
          "random_suffixes",
          "enchants"
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
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "AgilityElixir"
          },
          mana_regen_elixir = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "ManaRegenElixir"
          },
          strength_buff = {
            id = 5,
            type = "enum",
            label = "optional",
            enum_type = "StrengthBuff"
          },
          attack_power_buff = {
            id = 6,
            type = "enum",
            label = "optional",
            enum_type = "AttackPowerBuff"
          },
          spell_power_buff = {
            id = 7,
            type = "enum",
            label = "optional",
            enum_type = "SpellPowerBuff"
          },
          shadow_power_buff = {
            id = 8,
            type = "enum",
            label = "optional",
            enum_type = "ShadowPowerBuff"
          },
          fire_power_buff = {
            id = 9,
            type = "enum",
            label = "optional",
            enum_type = "FirePowerBuff"
          },
          frost_power_buff = {
            id = 10,
            type = "enum",
            label = "optional",
            enum_type = "FrostPowerBuff"
          },
          filler_explosive = {
            id = 11,
            type = "enum",
            label = "optional",
            enum_type = "Explosive"
          },
          main_hand_imbue = {
            id = 12,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          off_hand_imbue = {
            id = 13,
            type = "enum",
            label = "optional",
            enum_type = "WeaponImbue"
          },
          default_potion = {
            id = 14,
            type = "enum",
            label = "optional",
            enum_type = "Potions"
          },
          default_conjured = {
            id = 15,
            type = "enum",
            label = "optional",
            enum_type = "Conjured"
          },
          bogling_root = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          pet_agility_consumable = {
            id = 17,
            type = "int32",
            label = "optional"
          },
          pet_strength_consumable = {
            id = 18,
            type = "int32",
            label = "optional"
          },
          dragon_breath_chili = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          misc_consumes = {
            id = 20,
            type = "message",
            label = "optional",
            message_type = "MiscConsumes"
          },
          zanza_buff = {
            id = 21,
            type = "enum",
            label = "optional",
            enum_type = "ZanzaBuff"
          },
          armor_elixir = {
            id = 22,
            type = "enum",
            label = "optional",
            enum_type = "ArmorElixir"
          },
          health_elixir = {
            id = 23,
            type = "enum",
            label = "optional",
            enum_type = "HealthElixir"
          },
          alcohol = {
            id = 24,
            type = "enum",
            label = "optional",
            enum_type = "Alcohol"
          },
          pet_attack_power_consumable = {
            id = 25,
            type = "int32",
            label = "optional"
          },
          pet_misc_consumes = {
            id = 27,
            type = "message",
            label = "optional",
            message_type = "PetMiscConsumes"
          },
          sapper_explosive = {
            id = 28,
            type = "enum",
            label = "optional",
            enum_type = "SapperExplosive"
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
          "filler_explosive",
          "main_hand_imbue",
          "off_hand_imbue",
          "default_potion",
          "default_conjured",
          "bogling_root",
          "pet_agility_consumable",
          "pet_strength_consumable",
          "dragon_breath_chili",
          "misc_consumes",
          "zanza_buff",
          "armor_elixir",
          "health_elixir",
          "alcohol",
          "pet_attack_power_consumable",
          "pet_misc_consumes",
          "sapper_explosive"
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
      APLValueMaxHealth = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

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
      APLValueMaxMana = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

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
      APLValueCurrentAttackPower = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

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
      APLValueCurrentSealRemainingTime = {
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
          max_health = {
            id = 76,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxHealth",
            uiLabel = "Max Health",
            submenu = {
              "Resources"
            },
            shortDescription = "Maximum amount of Health.",
            fields = {

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
          max_mana = {
            id = 75,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxMana",
            uiLabel = "Max Mana",
            submenu = {
              "Resources"
            },
            shortDescription = "Maximum amount of Mana.",
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
            uiLabel = "Energy",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available Energy.",
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
            id = 72,
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
          current_attack_power = {
            id = 77,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentAttackPower",
            uiLabel = "Current Attack Power",
            submenu = {
              "Stats"
            },
            shortDescription = "Current Attack Power includuing temporary bonuses.",
            fields = {

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
            id = 73,
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
            id = 74,
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
            id = 69,
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
            id = 70,
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
            id = 71,
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
            "current_health",
            "current_health_percent",
            "max_health",
            "current_mana",
            "current_mana_percent",
            "max_mana",
            "current_rage",
            "current_energy",
            "current_combo_points",
            "time_to_energy_tick",
            "energy_threshold",
            "current_attack_power",
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
            "warlock_should_recast_drain_soul",
            "warlock_should_refresh_corruption",
            "warlock_current_pet_mana",
            "warlock_current_pet_mana_percent",
            "warlock_pet_is_active",
            "current_seal_remaining_time"
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
          "current_health",
          "current_health_percent",
          "max_health",
          "current_mana",
          "current_mana_percent",
          "max_mana",
          "current_rage",
          "current_energy",
          "current_combo_points",
          "time_to_energy_tick",
          "energy_threshold",
          "current_attack_power",
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
          "warlock_should_recast_drain_soul",
          "warlock_should_refresh_corruption",
          "warlock_current_pet_mana",
          "warlock_current_pet_mana_percent",
          "warlock_pet_is_active",
          "current_seal_remaining_time"
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/deep_wounds.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/sweeping_strikes.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFlurry",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Flurry"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyArcaneConcentration",
                  spellId = 12577,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Clearcasting"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyArcaneConcentration",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Arcane Concentration"
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
				Duration: time.Second * 180,
			},
		}]],
                  cooldown = {
                    raw = "time.Second * 180",
                    seconds = 180
                  },
                  Flags = "core.SpellFlagNoOnCastComplete"
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
              aura = {
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
                  registrationType = "RegisterAura",
                  functionName = "applyIgnite",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Ignite Talent"
                }
              },
              spell = {
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyIgnite",
                  spellId = 12654,
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyIgnite",
                  spellId = 12654,
                  cast = [[{
			IgnoreHaste: true,
		}]],
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage",
                  SpellSchool = "core.SpellSchoolFire",
                  ProcMask = "core.ProcMaskSpellProc",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1",
                  IgnoreHaste = "true",
                  label = "Ignite"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyIgnite",
                  spellId = 12654,
                  cast = [[{
			IgnoreHaste: true,
		}]],
                  Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage",
                  SpellSchool = "core.SpellSchoolFire",
                  ProcMask = "core.ProcMaskSpellProc",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1",
                  IgnoreHaste = "true",
                  label = "Ignite"
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
            label = "optional"
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
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
				Duration: time.Duration(time.Minute * 10),
			},
		}]],
                  cooldown = {
                    raw = "time.Duration(time.Minute * 10)",
                    seconds = nil
                  },
                  Flags = "core.SpellFlagNoOnCastComplete"
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
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyWintersChill",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Winters Chill Talent"
                }
              }
            }
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
                  sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFrenzy",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Frenzy"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyOmenOfClarity",
                  spellId = 16870,
                  auraDuration = {
                    raw = "time.Second * 15",
                    seconds = 15
                  },
                  label = "Clearcasting"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyOmenOfClarity",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Omen of Clarity"
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  label = "Vengeance"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonglow",
                  label = "Moonglow"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMoonfury",
                  label = "Moonfury"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/forms.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyFuror",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Furor"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
                  Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                  SpellSchool = "core.SpellSchoolPhysical",
                  ProcMask = "core.ProcMaskMeleeMHSpecial",
                  DamageMultiplier = "1.5",
                  ThreatMultiplier = "1"
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
                  registrationType = "RegisterAura",
                  functionName = "applyRiposte",
                  auraDuration = {
                    raw = "time.Second * 5",
                    seconds = 5
                  },
                  label = "Riposte Ready Aura"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                }
              },
              aura = {
                {
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/sword_specialization.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyInitiative",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Initiative"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
            label = "optional",
            goMetadata = {
              aura = {
                {
                  sourceFile = "extern/wowsims-classic/sim/rogue/ghostly_strike.go",
                  registrationType = "RegisterAura",
                  functionName = "registerGhostlyStrikeSpell",
                  spellId = 14278,
                  auraDuration = {
                    raw = "time.Second * 7",
                    seconds = 7
                  },
                  label = "Ghostly Strike Buff"
                }
              }
            }
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/preparation.go",
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
                  sourceFile = "extern/wowsims-classic/sim/rogue/premeditation.go",
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

        },
        oneofs = {

        },
        field_order = {

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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/stormstrike.go",
                  registrationType = "RegisterSpell",
                  functionName = "registerStormstrikeSpell",
                  spellId = 17364,
                  cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
                  cooldown = {
                    raw = "time.Second * 20",
                    seconds = 20
                  },
                  Flags = "SpellFlagShaman | core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
                  SpellSchool = "core.SpellSchoolPhysical",
                  ProcMask = "core.ProcMaskMeleeMHSpecial",
                  DamageMultiplier = "1",
                  ThreatMultiplier = "1"
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/fel_domination.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/fel_domination.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyMasterSummoner",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
                  registrationType = "RegisterSpell",
                  functionName = "applyDemonicSacrifice",
                  spellId = 18788,
                  Flags = "core.SpellFlagAPL",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/divine_favor.go",
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
            label = "optional"
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/blessing_of_sanctuary.go",
                  registrationType = "RegisterAura",
                  functionName = "registerBlessingOfSanctuary",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/holy_shield.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/soc.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
                  label = "Vengeance"
                },
                {
                  sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
                  registrationType = "RegisterAura",
                  functionName = "applyVengeance",
                  auraDuration = {
                    raw = "core.NeverExpires",
                    seconds = -1
                  },
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
          has_buff = {
            id = 5,
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
            id = 21,
            type = "int32",
            label = "optional"
          },
          max_ilvl = {
            id = 22,
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
          favorite_random_suffixes = {
            id = 20,
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
            id = 40,
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
          stormstrike_frequency = {
            id = 47,
            type = "double",
            label = "optional"
          },
          stormstrike_nature_attacker_frequency = {
            id = 48,
            type = "double",
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
            id = 39,
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
            "elemental_shaman",
            "enhancement_shaman",
            "restoration_shaman",
            "warden_shaman",
            "warlock",
            "warrior",
            "tank_warrior"
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
          "talents_string",
          "profession1",
          "profession2",
          "cooldowns",
          "rotation",
          "reaction_time_ms",
          "channel_clip_delay_ms",
          "in_front_of_target",
          "distance_from_target",
          "isb_sb_frequency",
          "isb_crit",
          "isb_warlocks",
          "isb_spriests",
          "stormstrike_frequency",
          "stormstrike_nature_attacker_frequency",
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
          "elemental_shaman",
          "enhancement_shaman",
          "restoration_shaman",
          "warden_shaman",
          "warlock",
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
          weapon_skills = {
            id = 28,
            type = "double",
            label = "repeated"
          },
          bonus_physical_damage = {
            id = 30,
            type = "double",
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
          heroic = {
            id = 20,
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
          "stats",
          "random_suffix_options",
          "weapon_damage_min",
          "weapon_damage_max",
          "weapon_speed",
          "weapon_skills",
          "bonus_physical_damage",
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
            id = 10,
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
            id = 11,
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
        SpecWardenShaman = 21,
        SpecHunter = 8,
        SpecMage = 2,
        SpecHolyPaladin = 20,
        SpecProtectionPaladin = 13,
        SpecRetributionPaladin = 3,
        SpecRogue = 7,
        SpecHealingPriest = 17,
        SpecShadowPriest = 4,
        SpecWarlock = 5,
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
        BonusPhysicalDamage = 30,
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
        PseudoStatBlockValuePerStrength = 29
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
        SapperGoblinSapper = 1
      },
      Explosive = {
        ExplosiveUnknown = 0,
        ExplosiveSolidDynamite = 1,
        ExplosiveDenseDynamite = 2,
        ExplosiveThoriumGrenade = 3,
        ExplosiveGoblinLandMine = 4
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
        ConjuredHealthstone = 4,
        ConjuredGreaterHealthstone = 5,
        ConjuredMajorHealthstone = 6
      },
      Flask = {
        FlaskUnknown = 0,
        FlaskOfTheTitans = 1,
        FlaskOfDistilledWisdom = 2,
        FlaskOfSupremePower = 3,
        FlaskOfChromaticResistance = 4
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
        ElixirOfAgility = 5
      },
      ArmorElixir = {
        ArmorElixirUnknown = 0,
        ElixirOfSuperiorDefense = 1,
        ElixirOfGreaterDefense = 2,
        ElixirOfDefense = 3,
        ElixirOfMinorDefense = 4,
        ScrollOfProtection = 5
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
        LesserArcaneElixir = 3
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
      ZanzaBuff = {
        ZanzaBuffUnknown = 0,
        SpiritOfZanza = 1,
        SheenOfZanza = 2,
        SwiftnessOfZanza = 3,
        ROIDS = 4,
        GroundScorpokAssay = 5,
        CerebralCortexCompound = 6,
        GizzardGum = 7,
        LungJuiceCocktail = 8
      },
      WeaponImbue = {
        WeaponImbueUnknown = 0,
        MinorWizardOil = 13,
        LesserWizardOil = 14,
        WizardOil = 20,
        BrilliantWizardOil = 2,
        BlessedWizardOil = 24,
        MinorManaOil = 15,
        LesserManaOil = 16,
        BrilliantManaOil = 1,
        SolidSharpeningStone = 17,
        DenseSharpeningStone = 3,
        ElementalSharpeningStone = 4,
        ConsecratedSharpeningStone = 23,
        SolidWeightstone = 18,
        DenseWeightstone = 19,
        ShadowOil = 21,
        FrostOil = 22,
        Windfury = 8,
        RockbiterWeapon = 9,
        FlametongueWeapon = 10,
        FrostbrandWeapon = 11,
        WindfuryWeapon = 12,
        InstantPoison = 5,
        DeadlyPoison = 6,
        WoundPoison = 7
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
        FoodSagefishDelight = 11
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
        EnchantTypeStaff = 4
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
        Martyrdom = 3
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
        RaidMoltenCore = 2717,
        RaidOnyxiasLair = 2159,
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
              sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
              Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "1.5",
              ThreatMultiplier = "1"
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/riposte.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/slice_and_dice.go",
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
        ghostly_strike = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/ghostly_strike.go",
              registrationType = "RegisterAura",
              functionName = "registerGhostlyStrikeSpell",
              spellId = 14278,
              auraDuration = {
                raw = "time.Second * 7",
                seconds = 7
              },
              label = "Ghostly Strike Buff"
            }
          }
        },
        sword_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/sword_specialization.go",
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
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/vanish.go",
              registrationType = "RegisterAura",
              functionName = "registerVanishSpell",
              spellId = 457437,
              auraDuration = {
                raw = "time.Second * 10",
                seconds = 10
              },
              label = "Vanish"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/vanish.go",
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
          }
        },
        feint = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/feint.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/stealth.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/premeditation.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/preparation.go",
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
        instant_poison = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/poisons.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/poisons.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/poisons.go",
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
        make_wound_poison = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/poisons.go",
              registrationType = "RegisterSpell",
              functionName = "makeWoundPoison",
              spellId = 13219,
              Flags = "core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePoison",
              SpellSchool = "core.SpellSchoolNature",
              ProcMask = "core.ProcMaskSpellDamageProc",
              DamageMultiplier = "rogue.getPoisonDamageMultiplier()",
              ThreatMultiplier = "1"
            }
          }
        },
        evasion = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/evasion.go",
              registrationType = "RegisterAura",
              functionName = "RegisterEvasionSpell",
              spellId = 5277,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Evasion"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/evasion.go",
              registrationType = "RegisterSpell",
              functionName = "RegisterEvasionSpell",
              spellId = 5277,
              cast = [[{
			DefaultCast: core.Cast{},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: []time.Duration{time.Minute * 5, time.Minute*5 - time.Second*45, time.Second*5 - time.Second*90}[rogue.Talents.Elusiveness],
			},
			IgnoreHaste: true,
		}]],
              cooldown = {
                raw = "[]time.Duration{time.Minute * 5",
                seconds = nil
              },
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolPhysical",
              IgnoreHaste = "true"
            }
          }
        },
        thistle_tea = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/thistle_tea.go",
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
        cold_blood = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
            }
          },
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/rogue/talents.go",
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
          }
        }
      },
      druid = {
        barkskin = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/barkskin.go",
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
        cat_form = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/forms.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/forms.go",
              registrationType = "RegisterAura",
              functionName = "registerBearFormSpell",
              spellId = 9634,
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
              sourceFile = "extern/wowsims-classic/sim/druid/forms.go",
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
        maul = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/_maul.go",
              registrationType = "RegisterAura",
              functionName = "registerMaulSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Maul Queue Aura"
            }
          }
        },
        maul_queue = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/_maul.go",
              registrationType = "RegisterAura",
              functionName = "registerMaulSpell",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Maul Queue Aura"
            }
          }
        },
        frenzied_regeneration = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/_frenzied_regeneration.go",
              registrationType = "RegisterAura",
              functionName = "registerFrenziedRegenerationCD",
              spellId = 22842,
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
              sourceFile = "extern/wowsims-classic/sim/druid/_enrage.go",
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
        tigers_fury = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/tigers_fury.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/tigers_fury.go",
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
        natures_grace = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNaturesGrace",
              label = "Natures Grace"
            }
          }
        },
        natures_swiftness = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyBloodFrenzy",
              label = "Blood Frenzy"
            }
          }
        },
        furor = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyOmenOfClarity",
              spellId = 16870,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            },
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMoonfury",
              label = "Moonfury"
            }
          }
        },
        improved_moonfire = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedMoonfire",
              label = "Improved moonfire"
            }
          }
        },
        vengeance = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyVengeance",
              label = "Vengeance"
            }
          }
        },
        moonglow = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/druid/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMoonglow",
              label = "Moonglow"
            }
          }
        }
      },
      guardians = {
        acid_spit = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/common/guardians/emerald_dragon_whelp.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/blackwing_lair.go",
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
      naxxramas = {
        hateful_strike = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/encounters/naxxramas/patchwerk10_ai.go",
              registrationType = "RegisterSpell",
              functionName = "registerHatefulStrikeSpell",
              spellId = 59192,
              cast = [[{
			CD: core.Cooldown{
				Timer:    target.NewTimer(),
				Duration: time.Second * 2,
			},
		}]],
              cooldown = {
                raw = "time.Second * 2",
                seconds = 2
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
              sourceFile = "extern/wowsims-classic/sim/encounters/naxxramas/patchwerk10_ai.go",
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
              sourceFile = "extern/wowsims-classic/sim/encounters/naxxramas/patchwerk10_ai.go",
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
        }
      },
      shaman = {
        frostbrand_debuff = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/frostbrand_weapon.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/frostbrand_weapon.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/frostbrand_weapon.go",
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
        windfury_imbue = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/windfury_weapon.go",
              registrationType = "RegisterAura",
              functionName = "RegisterWindfuryImbue",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Windfury Imbue"
            }
          }
        },
        flametongue_imbue = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/flametongue_weapon.go",
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
        rockbiter_imbue = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/rockbiter_weapon.go",
              registrationType = "RegisterAura",
              functionName = "RegisterRockbiterImbue",
              auraDuration = {
                raw = "duration",
                seconds = nil
              },
              label = "Rockbiter Imbue"
            }
          }
        },
        stormstrike = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/stormstrike.go",
              registrationType = "RegisterSpell",
              functionName = "registerStormstrikeSpell",
              spellId = 17364,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 20,
			},
		}]],
              cooldown = {
                raw = "time.Second * 20",
                seconds = 20
              },
              Flags = "SpellFlagShaman | core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
              SpellSchool = "core.SpellSchoolPhysical",
              ProcMask = "core.ProcMaskMeleeMHSpecial",
              DamageMultiplier = "1",
              ThreatMultiplier = "1"
            }
          }
        },
        elemental_focus = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              label = "Elemental Focus Trigger"
            }
          }
        },
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyElementalFocus",
              label = "Elemental Focus Trigger"
            }
          }
        },
        elemental_devastation = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
            }
          }
        },
        natures_swiftness = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
            }
          }
        },
        flurry = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/shaman/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/pet_abilities.go",
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
        get_aspect_of_the_hawk_spell_config = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/aspects.go",
              registrationType = "RegisterAura",
              functionName = "getAspectOfTheHawkSpellConfig",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Aspect of the Hawk"
            }
          }
        },
        aspect_of_the_hawk = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/aspects.go",
              registrationType = "RegisterAura",
              functionName = "getAspectOfTheHawkSpellConfig",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Aspect of the Hawk"
            }
          }
        },
        make_queue_spells_and = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/raptor_strike.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/raptor_strike.go",
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
        rapid_fire = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/rapid_fire.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/rapid_fire.go",
              registrationType = "RegisterSpell",
              functionName = "registerRapidFire",
              spellId = 3045,
              cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
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
        talents = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
              registrationType = "RegisterAura",
              functionName = "ApplyTalents",
              label = "Bestial Discipline"
            }
          }
        },
        bestial_discipline = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
              registrationType = "RegisterAura",
              functionName = "ApplyTalents",
              label = "Bestial Discipline"
            }
          }
        },
        frenzy = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/mongoose_bite.go",
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
              sourceFile = "extern/wowsims-classic/sim/hunter/mongoose_bite.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/flash_heal.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/vampiric_embrace.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/vampiric_embrace.go",
              registrationType = "RegisterSpell",
              functionName = "registerVampiricEmbraceSpell",
              spellId = 15286,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
              Flags = "SpellFlagPriest | core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        vampiric_embrace_health = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/vampiric_embrace.go",
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
        power_word_shield = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/power_word_shield.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/power_word_shield.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/power_word_shield.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/renew.go",
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
        power_infusion = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/power_infusion.go",
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
        prayer_of_healing = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/prayer_of_healing.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/greater_heal.go",
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
        inspiration = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyDarkness",
              label = "Darkness"
            }
          }
        },
        inner_focus = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
            }
          }
        },
        shadowform = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/priest/talents.go",
              registrationType = "RegisterSpell",
              functionName = "registerShadowform",
              spellId = 15473,
              cast = [[{
			DefaultCast: core.Cast{
				GCD: 0,
			},
		}]],
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
            }
          }
        }
      },
      warlock = {
        demon_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/armors.go",
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
        amplify_curse = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
              registrationType = "RegisterSpell",
              functionName = "registerCurseOfDoomSpell",
              spellId = 603,
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
              sourceFile = "extern/wowsims-classic/sim/warlock/curses.go",
              registrationType = "RegisterSpell",
              functionName = "registerCurseOfDoomSpell",
              spellId = 603,
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
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskSpellDamage",
              DamageMultiplier = "1",
              ThreatMultiplier = "1 - 0.1*float64(warlock.Talents.ImprovedDrainSoul)",
              label = "CurseofDoom"
            }
          }
        },
        summon_demon = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 691,
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 688,
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 712,
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            },
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/summon_demon.go",
              registrationType = "RegisterSpell",
              functionName = "registerSummonDemon",
              spellId = 697,
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow",
              ProcMask = "core.ProcMaskEmpty"
            }
          }
        },
        fel_domination = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/fel_domination.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/fel_domination.go",
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
        firestone = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFirestone",
              label = "Firestone Proc"
            }
          }
        },
        nightfall = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              label = "Nightfall Hidden Aura"
            }
          }
        },
        nightfall_shadow_trance = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyNightfall",
              label = "Nightfall Hidden Aura"
            }
          }
        },
        master_summoner = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMasterSummoner",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Master Summoner Hidden Aura"
            }
          }
        },
        master_summoner_hidden = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyMasterSummoner",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Master Summoner Hidden Aura"
            }
          }
        },
        soul_link = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterSpell",
              functionName = "applyDemonicSacrifice",
              spellId = 18788,
              Flags = "core.SpellFlagAPL",
              SpellSchool = "core.SpellSchoolShadow"
            }
          }
        },
        burning_wish = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedShadowBolt",
              label = "ISB Trigger"
            }
          }
        },
        isb_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warlock/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyImprovedShadowBolt",
              label = "ISB Trigger"
            }
          }
        }
      },
      paladin = {
        seal_of_the_crusader = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/sotc.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/divine_favor.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/avenging_wrath.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/avenging_wrath.go",
              registrationType = "RegisterSpell",
              functionName = "registerAvengingWrath",
              majorCooldown = {
                type = "core.CooldownTypeDPS",
                priority = nil
              },
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
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | SpellFlag_Forbearance"
            }
          }
        },
        seal_of_command = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/soc.go",
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
        holy_shield = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/holy_shield.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/sor.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/blessing_of_sanctuary.go",
              registrationType = "RegisterAura",
              functionName = "registerBlessingOfSanctuary",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Blessing of Sanctuary Trigger"
            }
          }
        },
        blessing_of_sanctuary_trigger = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/blessing_of_sanctuary.go",
              registrationType = "RegisterAura",
              functionName = "registerBlessingOfSanctuary",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Blessing of Sanctuary Trigger"
            }
          }
        },
        judgement = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/judgement.go",
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
              SpellSchool = "core.SpellSchoolHoly",
              ProcMask = "core.ProcMaskEmpty",
              IgnoreHaste = "true"
            }
          }
        },
        redoubt = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
        vindication = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/paladin/forbearance.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostIceArmor",
              label = "Ice Armor"
            }
          }
        },
        ice_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyFrostIceArmor",
              label = "Ice Armor"
            }
          }
        },
        mage_armor = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/armors.go",
              registrationType = "RegisterAura",
              functionName = "applyMageArmor",
              label = "Mage Armor"
            }
          }
        },
        counterspell = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/counterspell.go",
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
              Flags = "core.SpellFlagAPL | SpellFlagMage | core.SpellFlagCastTimeNoGCD",
              SpellSchool = "core.SpellSchoolArcane",
              ProcMask = "core.ProcMaskSpellDamage"
            }
          }
        },
        ignite = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
              registrationType = "RegisterAura",
              functionName = "applyIgnite",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Ignite Talent"
            }
          },
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
              registrationType = "RegisterSpell",
              functionName = "applyIgnite",
              spellId = 12654,
              Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | SpellFlagMage"
            }
          }
        },
        ignite_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/ignite.go",
              registrationType = "RegisterAura",
              functionName = "applyIgnite",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Ignite Talent"
            }
          }
        },
        new_blizzard_spell_config = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/blizzard.go",
              registrationType = "RegisterAura",
              functionName = "newBlizzardSpellConfig",
              auraDuration = {
                raw = "time.Millisecond * 1500",
                seconds = 1
              },
              label = "Improved Blizzard"
            }
          }
        },
        improved_blizzard = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/blizzard.go",
              registrationType = "RegisterAura",
              functionName = "newBlizzardSpellConfig",
              auraDuration = {
                raw = "time.Millisecond * 1500",
                seconds = 1
              },
              label = "Improved Blizzard"
            }
          }
        },
        evocation = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/evocation.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/evocation.go",
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
              label = "Evocation"
            }
          }
        },
        evocation_regen = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/evocation.go",
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
        arcane_concentration = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyArcaneConcentration",
              spellId = 12577,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Clearcasting"
            },
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
        clearcasting = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
            }
          }
        },
        arcane_power = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
				Duration: time.Second * 180,
			},
		}]],
              cooldown = {
                raw = "time.Second * 180",
                seconds = 180
              },
              Flags = "core.SpellFlagNoOnCastComplete"
            }
          }
        },
        master_of_elements = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
            }
          }
        },
        cold_snap = {
          spell = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
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
				Duration: time.Duration(time.Minute * 10),
			},
		}]],
              cooldown = {
                raw = "time.Duration(time.Minute * 10)",
                seconds = nil
              },
              Flags = "core.SpellFlagNoOnCastComplete"
            }
          }
        },
        winters_chill = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyWintersChill",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Winters Chill Talent"
            }
          }
        },
        winters_chill_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/mage/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyWintersChill",
              auraDuration = {
                raw = "core.NeverExpires",
                seconds = -1
              },
              label = "Winters Chill Talent"
            }
          }
        }
      },
      warrior = {
        berserker_rage = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/berserker_rage.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/revenge.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/revenge.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/shield_wall.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/bloodrage.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/shield_block.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/deep_wounds.go",
              registrationType = "RegisterAura",
              functionName = "applyDeepWounds",
              label = "Deep Wounds Talent"
            }
          }
        },
        deep_wounds_talent = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/deep_wounds.go",
              registrationType = "RegisterAura",
              functionName = "applyDeepWounds",
              label = "Deep Wounds Talent"
            }
          }
        },
        sweeping_strikes = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/sweeping_strikes.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/recklessness.go",
              registrationType = "RegisterAura",
              functionName = "RegisterRecklessnessCD",
              spellId = 1719,
              auraDuration = {
                raw = "time.Second * 15",
                seconds = 15
              },
              label = "Recklessness"
            }
          }
        },
        overpower = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/overpower.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/overpower.go",
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
        battle_stance = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/stances.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/stances.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/stances.go",
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
        make_queue_spells_and = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/heroic_strike_cleave.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/heroic_strike_cleave.go",
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
        sword_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
              registrationType = "RegisterAura",
              functionName = "applyFlurry",
              label = "Flurry Proc Trigger"
            }
          }
        },
        shield_specialization = {
          aura = {
            {
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
              sourceFile = "extern/wowsims-classic/sim/warrior/talents.go",
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
        total_found = 22,
        matched = 22,
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
        total_found = 65,
        matched = 65,
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
      files_scanned = 380,
      functions_scanned = 2151,
      registrations_found = 253,
      registrations_parsed = 186,
      registrations_missed = {
        {
          file = "sim/rogue/sinister_strike.go",
          ["function"] = "registerSinisterStrikeSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueSinisterStrike, 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType..."
        },
        {
          file = "sim/rogue/slice_and_dice.go",
          ["function"] = "registerSliceAndDice",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:    SpellCode_RogueSliceandDice, 		ActionID:     actionID, 		Flags:        core.SpellFlagAPL, 		MetricSplits: 6,  		EnergyCost: core.Ene..."
        },
        {
          file = "sim/rogue/backstab.go",
          ["function"] = "registerBackstabSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueBackstab, 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core..."
        },
        {
          file = "sim/rogue/ghostly_strike.go",
          ["function"] = "registerGhostlyStrikeSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueGhostlyStrike, 		ActionID:    ghostlyStrikeAura.ActionID, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core..."
        },
        {
          file = "sim/rogue/garrote.go",
          ["function"] = "registerGarrote",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueGarrote, 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core...."
        },
        {
          file = "sim/rogue/expose_armor.go",
          ["function"] = "registerExposeArmorSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:    SpellCode_RogueExposeArmor, 		ActionID:     core.ActionID{SpellID: spellID}, 		SpellSchool:  core.SpellSchoolPhysical, 		DefenseType..."
        },
        {
          file = "sim/rogue/hemorrhage.go",
          ["function"] = "registerHemorrhageSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueHemorrhage, 		ActionID:    actionID, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core.DefenseTypeMelee,..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "registerDeadlyPoisonSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID, Tag: 100}, 		SpellSchool: core.SpellSchoolNature, 		DefenseType: core.DefenseTypeMagic, 		ProcMask:..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "makeInstantPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolNature, 		DefenseType: core.DefenseTypeMagic, 		ProcMask:    core.Pro..."
        },
        {
          file = "sim/rogue/poisons.go",
          ["function"] = "makeDeadlyPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: core.ActionID{SpellID: rogue.deadlyPoisonTick.SpellID}, 		Flags:    core.SpellFlagPoison | core.SpellFlagPassiveSpell | SpellFlagRoguePo..."
        },
        {
          file = "sim/rogue/rupture.go",
          ["function"] = "registerRupture",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:    SpellCode_RogueRupture, 		ActionID:     core.ActionID{SpellID: spellID}, 		SpellSchool:  core.SpellSchoolPhysical, 		DefenseType:  c..."
        },
        {
          file = "sim/rogue/eviscerate.go",
          ["function"] = "registerEviscerate",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:    SpellCode_RogueEviscerate, 		ActionID:     core.ActionID{SpellID: spellID}, 		SpellSchool:  core.SpellSchoolPhysical, 		DefenseType:..."
        },
        {
          file = "sim/rogue/ambush.go",
          ["function"] = "registerAmbushSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_RogueAmbush, 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core.D..."
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
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newSearingTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: SearingTotemAttackSpellId[rank]}, 		SpellSchool: core.SpellSchoolFire, 		DefenseType: core.DefenseTypeMagic,..."
        },
        {
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newMagmaTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_ShamanMagmaTotem, 		ActionID:    core.ActionID{SpellID: MagmaTotemAoeSpellId[rank]}, 		SpellSchool: core.SpellSchoolFire,..."
        },
        {
          file = "sim/shaman/fire_totems.go",
          ["function"] = "newFireNovaTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_ShamanFireNovaTotem, 		ActionID:    core.ActionID{SpellID: FireNovaTotemAoeSpellId[rank]}, 		SpellSchool: core.SpellSchoolF..."
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
          file = "sim/shaman/flametongue_weapon.go",
          ["function"] = "newFlametongueImbueSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolFire, 		DefenseType: core.DefenseTypeMagic, 		ProcMask:    core.ProcM..."
        },
        {
          file = "sim/shaman/air_totems.go",
          ["function"] = "newWindfuryTotemSpellConfig",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		ActionID: core.ActionID{SpellID: WindfuryBuffAuraId[rank]}, 		Label:    fmt.Sprintf("Windfury (Rank %d)", rank), 		Duration: time.Second * 10, 	}...]]
        },
        {
          file = "sim/shaman/air_totems.go",
          ["function"] = "newWindfuryTotemSpellConfig",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:    fmt.Sprintf("Windfury Trigger Dummy (Rank %d)", rank), 		Duration: time.Minute * 2, 		OnGain: func(_ *core.Aura, sim *core.Simulation) {...]]
        },
        {
          file = "sim/shaman/lightning_shield.go",
          ["function"] = "registerNewLightningShieldSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: procSpellId}, 		SpellSchool: core.SpellSchoolNature, 		DefenseType: core.DefenseTypeMagic, 		ProcMask:    core..."
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
          block_preview = "{ 		ActionID:  core.ActionID{SpellID: spellId}, 		SpellCode: SpellCode_ShamanLightningShield, 		ProcMask:  core.ProcMaskEmpty, 		Flags:     core.Spell..."
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "makeFlurryAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:     fmt.Sprintf("Flurry Proc (%d)", spellID), 		ActionID:  core.ActionID{SpellID: spellID}, 		Duration:  core.NeverExpires, 		MaxStacks: 3,...]]
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "makeFlurryConsumptionTrigger",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label: fmt.Sprintf("Flurry Consume Trigger - %d", flurryAura.ActionID.SpellID), 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell...]]
        },
        {
          file = "sim/shaman/talents.go",
          ["function"] = "registerManaTideTotemCD",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ // 		ActionID: core.ManaTideTotemActionID, // 		Flags:    core.SpellFlagNoOnCastComplete, // 		Cast: core.CastConfig{ // 			DefaultCast: core.Cast{..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newClaw",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellCode:   SpellCode_HunterPetClaw, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newBite",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellCode:   SpellCode_HunterPetBite, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: core..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newLightningBreath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellCode:   SpellCode_HunterPetLightningBreath, 		SpellSchool: core.SpellSchoolNature, 		DefenseT..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newScreech",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellCode:   SpellCode_HunterPetScreech, 		SpellSchool: core.SpellSchoolPhysical, 		DefenseType: c..."
        },
        {
          file = "sim/hunter/pet_abilities.go",
          ["function"] = "newScorpidPoison",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellCode:   SpellCode_HunterPetScorpidPoison, 		SpellSchool: core.SpellSchoolNature, 		DefenseTyp..."
        },
        {
          file = "sim/hunter/aspects.go",
          ["function"] = "createImprovedHawkAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    auraLabel, 		ActionID: actionID, 		Duration: time.Second * 12, 		OnGain: func(aura *core.Aura, sim *core.Simulation) { 			aura.Unit.Mult..."
        },
        {
          file = "sim/hunter/raptor_strike.go",
          ["function"] = "newRaptorStrikeHitSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:   SpellCode_HunterRaptorStrikeHit, 		ActionID:    core.ActionID{SpellID: spellID}.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical,..."
        },
        {
          file = "sim/hunter/raptor_strike.go",
          ["function"] = "makeQueueSpellsAndAura",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode: SpellCode_HunterRaptorStrike, 		ActionID:  hunter.RaptorStrike.WithTag(3), 		Flags:     core.SpellFlagMeleeMetrics | core.SpellFlagAPL,..."
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
          file = "sim/warlock/drain_life.go",
          ["function"] = "getDrainLifeBaseConfig",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID.WithTag(1), 		SpellSchool: core.SpellSchoolPhysical, 		ProcMask:    core.ProcMaskSpellHealing, 		Flags:       core.SpellFlag..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfRecklessnessSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskEmpty, 		Flags:       core.SpellF..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfElementsSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskEmpty, 		Flags:       core.SpellF..."
        },
        {
          file = "sim/warlock/curses.go",
          ["function"] = "registerCurseOfShadowSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: spellID}, 		SpellSchool: core.SpellSchoolShadow, 		ProcMask:    core.ProcMaskEmpty, 		Flags:       core.SpellF..."
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
          block_preview = "{ 		ActionID:      core.ActionID{SpellID: spellId}, 		SpellSchool:   core.SpellSchoolFire, 		DefenseType:   core.DefenseTypeMagic, 		ProcMask:      co..."
        },
        {
          file = "sim/warlock/succubus.go",
          ["function"] = "registerSuccubusLashOfPainSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:      core.ActionID{SpellID: spellId}, 		SpellSchool:   core.SpellSchoolShadow, 		DefenseType:   core.DefenseTypeMagic, 		ProcMask:..."
        },
        {
          file = "sim/paladin/lay_on_hands.go",
          ["function"] = "registerLayOnHands",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		ProcMask:    core.ProcMaskSpellHealing, 		Flags:       core.SpellFlagAPL | core.SpellFlagMCD, 		SpellSchool: core.SpellSc..."
        },
        {
          file = "sim/paladin/hammer_of_wrath.go",
          ["function"] = "registerHammerOfWrath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeRanged, 			ProcMask:..."
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
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL,  			RequiredLevel: int(rank.level), 			Rank:..."
        },
        {
          file = "sim/paladin/holy_wrath.go",
          ["function"] = "registerHolyWrath",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			SpellCode:   SpellCode_PaladinHolyWrath, 			ActionID:    core.ActionID{SpellID: rank.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseTy..."
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
          block_preview = "{ 		ActionID: aura.ActionID, 		Flags:    core.SpellFlagNoOnCastComplete, 		Cast: core.CastConfig{ 			CD: cd, 		}, 		ApplyEffects: func(sim *core.Simul..."
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
          block_preview = "{ 			SpellCode:   SpellCode_PaladinJudgementOfCommand, // used in judgement.go 			ActionID:    core.ActionID{SpellID: rank.judge.spellID}, 			SpellSch..."
        },
        {
          file = "sim/paladin/soc.go",
          ["function"] = "registerSealOfCommand",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.proc.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMelee, 			ProcMask:..."
        },
        {
          file = "sim/paladin/soc.go",
          ["function"] = "registerSealOfCommand",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL,  			RequiredLevel: int(rank.level), 			Rank:..."
        },
        {
          file = "sim/paladin/holy_shield.go",
          ["function"] = "registerHolyShield",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: procID}, 			SpellCode:   SpellCode_PaladinHolyShieldProc, 			SpellSchool: core.SpellSchoolHoly, 			DefenseTyp..."
        },
        {
          file = "sim/paladin/holy_shield.go",
          ["function"] = "registerHolyShield",
          registration_index = 3,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:      core.ActionID{SpellID: spellID}, 			SpellCode:     SpellCode_PaladinHolyShield, 			Flags:         core.SpellFlagAPL, 			RequiredLe..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			SpellCode:   SpellCode_PaladinJudgementOfRighteousness, 			ActionID:    core.ActionID{SpellID: rank.judge.spellID}, 			SpellSchool: core.SpellSch..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    core.ActionID{SpellID: rank.proc.spellID}, 			SpellSchool: core.SpellSchoolHoly, 			DefenseType: core.DefenseTypeMelee, 			ProcMask:..."
        },
        {
          file = "sim/paladin/sor.go",
          ["function"] = "registerSealOfRighteousness",
          registration_index = 4,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:    aura.ActionID, 			SpellSchool: core.SpellSchoolHoly, 			Flags:       core.SpellFlagAPL,  			RequiredLevel: int(rank.level), 			Rank:..."
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
          file = "sim/mage/arcane_missiles.go",
          ["function"] = "getArcaneMissilesTickSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		SpellCode:    SpellCode_MageArcaneMissilesTick, 		ActionID:     core.ActionID{SpellID: spellId}.WithTag(1), 		SpellSchool:  core.SpellSchoolArcane..."
        },
        {
          file = "sim/mage/blizzard.go",
          ["function"] = "newBlizzardSpellConfig",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID: core.ActionID{SpellID: impId}, 			ProcMask: core.ProcMaskSpellProc, 			Flags:    SpellFlagMage | core.SpellFlagNoLogs | SpellFlagChillS..."
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
          file = "sim/warrior/talents.go",
          ["function"] = "makeFlurryAura",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label:     fmt.Sprintf("Flurry Proc (%d)", spellID), 		ActionID:  core.ActionID{SpellID: spellID}, 		Duration:  core.NeverExpires, 		MaxStacks: 3,...]]
        },
        {
          file = "sim/warrior/talents.go",
          ["function"] = "makeFlurryConsumptionTrigger",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 		Label: fmt.Sprintf("Flurry Consume Trigger - %d", flurryAura.ActionID.SpellID), 		OnSpellHitDealt: func(_ *core.Aura, sim *core.Simulation, spell...]]
        }
      }
    }
  }
