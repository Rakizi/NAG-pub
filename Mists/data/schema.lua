-- Generated schema for mop on 2025-06-24 15:27:11
local _, ns = ...
ns.protoSchema = ns.protoSchema or {}
ns.protoSchema['mists'] = {
    messages = {
      PriestTalents = {
        fields = {
          void_tendrils = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          psyfiend = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          dominate_mind = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          body_and_soul = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          angelic_feather = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          phantasm = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          from_darkness_comes_light = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          mindbender = {
            id = 8,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/priest/mindbender.go",
                registrationType = "RegisterAura",
                functionName = "registerMindbenderSpell",
                spellId = 123040,
                auraDuration = {
                  raw = "time.Second * 15.0",
                  seconds = 15
                },
                label = "Mindbender"
              }
            }
          },
          solace_and_insanity = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          desperate_prayer = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          spectral_guise = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          angelic_bulwark = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          twist_of_fate = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          power_infusion = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          divine_insight = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          cascade = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          divine_star = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          halo = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "void_tendrils",
          "psyfiend",
          "dominate_mind",
          "body_and_soul",
          "angelic_feather",
          "phantasm",
          "from_darkness_comes_light",
          "mindbender",
          "solace_and_insanity",
          "desperate_prayer",
          "spectral_guise",
          "angelic_bulwark",
          "twist_of_fate",
          "power_infusion",
          "divine_insight",
          "cascade",
          "divine_star",
          "halo"
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
      RppmMod = {
        fields = {
          coefficient = {
            id = 1,
            type = "double",
            label = "optional"
          },
          haste = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          crit = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          spec = {
            id = 4,
            type = "enum",
            label = "optional",
            enum_type = "Spec"
          },
          class_mask = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          ilvl = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {
          mod_type = {
            "haste",
            "crit",
            "spec",
            "class_mask",
            "ilvl"
          }
        },
        field_order = {
          "coefficient",
          "haste",
          "crit",
          "spec",
          "class_mask",
          "ilvl"
        }
      },
      ProcEffect = {
        fields = {
          icd_ms = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          proc_chance = {
            id = 2,
            type = "double",
            label = "optional"
          },
          ppm = {
            id = 3,
            type = "double",
            label = "optional"
          },
          rppm = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "RppmProc"
          }
        },
        oneofs = {
          procRate = {
            "proc_chance",
            "ppm",
            "rppm"
          }
        },
        field_order = {
          "icd_ms",
          "proc_chance",
          "ppm",
          "rppm"
        }
      },
      RppmProc = {
        fields = {
          rate = {
            id = 1,
            type = "double",
            label = "optional"
          },
          mods = {
            id = 4,
            type = "message",
            label = "repeated",
            message_type = "RppmMod"
          }
        },
        oneofs = {

        },
        field_order = {
          "rate",
          "mods"
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
          }
        },
        oneofs = {

        },
        field_order = {
          "stats"
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
          horn_of_winter = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          trueshot_aura = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          battle_shout = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          unholy_aura = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          cackling_howl = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          serpents_swiftness = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          swiftblades_cunning = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          unleashed_rage = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          still_water = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          arcane_brilliance = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          burning_wrath = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          dark_intent = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          moonkin_aura = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          mind_quickening = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          shadow_form = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          elemental_oath = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          leader_of_the_pack = {
            id = 18,
            type = "bool",
            label = "optional"
          },
          terrifying_roar = {
            id = 19,
            type = "bool",
            label = "optional"
          },
          furious_howl = {
            id = 20,
            type = "bool",
            label = "optional"
          },
          legacy_of_the_white_tiger = {
            id = 21,
            type = "bool",
            label = "optional"
          },
          roar_of_courage = {
            id = 22,
            type = "bool",
            label = "optional"
          },
          spirit_beast_blessing = {
            id = 23,
            type = "bool",
            label = "optional"
          },
          blessing_of_might = {
            id = 24,
            type = "bool",
            label = "optional"
          },
          grace_of_air = {
            id = 25,
            type = "bool",
            label = "optional"
          },
          mark_of_the_wild = {
            id = 26,
            type = "bool",
            label = "optional"
          },
          embrace_of_the_shale_spider = {
            id = 27,
            type = "bool",
            label = "optional"
          },
          legacy_of_the_emperor = {
            id = 28,
            type = "bool",
            label = "optional"
          },
          blessing_of_kings = {
            id = 29,
            type = "bool",
            label = "optional"
          },
          qiraji_fortitude = {
            id = 30,
            type = "bool",
            label = "optional"
          },
          power_word_fortitude = {
            id = 31,
            type = "bool",
            label = "optional"
          },
          commanding_shout = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          bloodlust = {
            id = 32,
            type = "bool",
            label = "optional"
          },
          mana_tide_totem_count = {
            id = 33,
            type = "int32",
            label = "optional"
          },
          stormlash_totem_count = {
            id = 34,
            type = "int32",
            label = "optional"
          },
          skull_banner_count = {
            id = 35,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "horn_of_winter",
          "trueshot_aura",
          "battle_shout",
          "unholy_aura",
          "cackling_howl",
          "serpents_swiftness",
          "swiftblades_cunning",
          "unleashed_rage",
          "still_water",
          "arcane_brilliance",
          "burning_wrath",
          "dark_intent",
          "moonkin_aura",
          "mind_quickening",
          "shadow_form",
          "elemental_oath",
          "leader_of_the_pack",
          "terrifying_roar",
          "furious_howl",
          "legacy_of_the_white_tiger",
          "roar_of_courage",
          "spirit_beast_blessing",
          "blessing_of_might",
          "grace_of_air",
          "mark_of_the_wild",
          "embrace_of_the_shale_spider",
          "legacy_of_the_emperor",
          "blessing_of_kings",
          "qiraji_fortitude",
          "power_word_fortitude",
          "commanding_shout",
          "bloodlust",
          "mana_tide_totem_count",
          "stormlash_totem_count",
          "skull_banner_count"
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
          devotion_aura_count = {
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
          }
        },
        oneofs = {

        },
        field_order = {
          "innervate_count",
          "hymn_of_hope_count",
          "unholy_frenzy_count",
          "tricks_of_the_trade",
          "devotion_aura_count",
          "pain_suppression_count",
          "hand_of_sacrifice_count",
          "guardian_spirit_count",
          "rallying_cry_count",
          "shattering_throw_count"
        }
      },
      Debuffs = {
        fields = {
          weakened_blows = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          physical_vulnerability = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          weakened_armor = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          mortal_wounds = {
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
          master_poisoner = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          curse_of_elements = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          necrotic_strike = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          lava_breath = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          spore_cloud = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          slow = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          mind_numbing_poison = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          curse_of_enfeeblement = {
            id = 14,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "weakened_blows",
          "physical_vulnerability",
          "weakened_armor",
          "mortal_wounds",
          "fire_breath",
          "lightning_breath",
          "master_poisoner",
          "curse_of_elements",
          "necrotic_strike",
          "lava_breath",
          "spore_cloud",
          "slow",
          "mind_numbing_poison",
          "curse_of_enfeeblement"
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
          "conjured_id"
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
          },
          challenge_mode = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          tinker = {
            id = 9,
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
          "gems",
          "reforging",
          "upgrade_step",
          "challenge_mode",
          "tinker"
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
            id = 4,
            type = "double",
            label = "optional"
          },
          absorb_frac = {
            id = 5,
            type = "double",
            label = "optional"
          },
          burst_window = {
            id = 3,
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
          items = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "ItemSpec"
          },
          prepull_bonus_stats = {
            id = 2,
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
          execute_proportion_45 = {
            id = 10,
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
          "execute_proportion_45",
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
      APLValueCurrentGenericResource = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

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
      APLValueMaxComboPoints = {
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
      APLValueMaxRage = {
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
      APLValueSpellNumCharges = {
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
      APLValueSpellTimeToCharge = {
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
          min_icd_seconds = {
            id = 4,
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
          min_icd_seconds = {
            id = 4,
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
          min_icd_seconds = {
            id = 4,
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
          min_icd_seconds = {
            id = 4,
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
          min_icd_seconds = {
            id = 4,
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
      APLValueWarlockHandOfGuldanInFlight = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueWarlockHauntInFlight = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

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
      APLValueShamanFireElementalDuration = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueMonkCurrentChi = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueMonkMaxChi = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueBrewmasterMonkCurrentStaggerPercent = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueProtectionPaladinDamageTakenLastGlobal = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      APLValueDotPercentIncrease = {
        fields = {
          spell_id = {
            id = 1,
            type = "message",
            label = "optional",
            message_type = "ActionID"
          },
          target_unit = {
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
            id = 85,
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
            uiLabel = "Current Rage",
            submenu = {
              "Resources",
              "Rage"
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
            uiLabel = "Current Combo Points",
            submenu = {
              "Resources",
              "Combo Points"
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
          current_generic_resource = {
            id = 75,
            type = "message",
            label = "optional",
            message_type = "APLValueCurrentGenericResource",
            uiLabel = "{GENERIC_RESOURCE}",
            submenu = {
              "Resources"
            },
            shortDescription = "Amount of currently available {GENERIC_RESOURCE}.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => SecondaryResource.hasSecondaryResource(player.getSpec())",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          max_health = {
            id = 98,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxHealth",
            uiLabel = "Max Health",
            submenu = {
              "Resources",
              "Health"
            },
            shortDescription = "Amount of currently available maximum Health.",
            fields = {

            }
          },
          max_combo_points = {
            id = 93,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxComboPoints",
            uiLabel = "Max Combo Points",
            submenu = {
              "Resources",
              "Combo Points"
            },
            shortDescription = "Amount of maximum available Combo Points.",
            includeIf = "__func__",
            fields = {

            }
          },
          max_energy = {
            id = 87,
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
            id = 88,
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
          max_rage = {
            id = 102,
            type = "message",
            label = "optional",
            message_type = "APLValueMaxRage",
            uiLabel = "Max Rage",
            submenu = {
              "Resources",
              "Rage"
            },
            shortDescription = "Amount of maximum available Rage.",
            includeIf = "__func__",
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
            id = 89,
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
            id = 90,
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
            id = 91,
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
            id = 92,
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
          spell_num_charges = {
            id = 96,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellNumCharges",
            uiLabel = "Number of Charges",
            submenu = {
              "Spell"
            },
            shortDescription = "The number of charges that are currently available for the spell.",
            fields = {
              {
                field = "spellId",
                configType = "actionId"
              }
            }
          },
          spell_time_to_charge = {
            id = 97,
            type = "message",
            label = "optional",
            message_type = "APLValueSpellTimeToCharge",
            uiLabel = "Time to next Charge",
            submenu = {
              "Spell"
            },
            shortDescription = "The time until the next charge is available. 0 if spell has all charges avaialable.",
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
            id = 82,
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
            id = 84,
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
          dot_percent_increase = {
            id = 101,
            type = "message",
            label = "optional",
            message_type = "APLValueDotPercentIncrease",
            uiLabel = "Dot Damage Increase %",
            submenu = {
              "DoT"
            },
            shortDescription = "How much stronger a new DoT would be compared to the old.",
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
          warlock_hand_of_guldan_in_flight = {
            id = 59,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockHandOfGuldanInFlight",
            uiLabel = "Hand of Guldan in Flight",
            submenu = {
              "Warlock"
            },
            shortDescription = "Returns |cffffcc00True|r if the impact of Hand of Guldan currenty is in flight.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecDemonologyWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          warlock_haunt_in_flight = {
            id = 60,
            type = "message",
            label = "optional",
            message_type = "APLValueWarlockHauntInFlight",
            uiLabel = "Haunt In Flight",
            submenu = {
              "Warlock"
            },
            shortDescription = "Returns |cffffcc00True|r if Haunt currently is in flight.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() == Spec.SpecAfflictionWarlock",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

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
          },
          monk_current_chi = {
            id = 94,
            type = "message",
            label = "optional",
            message_type = "APLValueMonkCurrentChi",
            uiLabel = "Current Chi",
            submenu = {
              "Resources",
              "Chi"
            },
            shortDescription = "Amount of currently available Chi.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassMonk",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          monk_max_chi = {
            id = 95,
            type = "message",
            label = "optional",
            message_type = "APLValueMonkMaxChi",
            uiLabel = "Max Chi",
            submenu = {
              "Resources",
              "Chi"
            },
            shortDescription = "Amount of maximum available Chi.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getClass() === Class.ClassMonk",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          brewmaster_monk_current_stagger_percent = {
            id = 99,
            type = "message",
            label = "optional",
            message_type = "APLValueBrewmasterMonkCurrentStaggerPercent",
            uiLabel = "Current Stagger (%)",
            submenu = {
              "Tank"
            },
            shortDescription = "Amount of current Stagger, as a percentage.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() === Spec.SpecBrewmasterMonk",
            prepullOnly = false,
            combatOnly = false,
            specSpecific = true,
            fields = {

            }
          },
          protection_paladin_damage_taken_last_global = {
            id = 100,
            type = "message",
            label = "optional",
            message_type = "APLValueProtectionPaladinDamageTakenLastGlobal",
            uiLabel = "Damage Taken Last Global",
            submenu = {
              "Tank"
            },
            shortDescription = "Amount of damage taken in the last 1.5s.",
            includeIf = "(player: Player<any>, _isPrepull: boolean) => player.getSpec() === Spec.SpecProtectionPaladin",
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
            "current_generic_resource",
            "max_health",
            "max_combo_points",
            "max_energy",
            "max_focus",
            "max_rage",
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
            "spell_num_charges",
            "spell_time_to_charge",
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
            "dot_percent_increase",
            "sequence_is_complete",
            "sequence_is_ready",
            "sequence_time_to_ready",
            "channel_clip_delay",
            "input_delay",
            "front_of_target",
            "totem_remaining_time",
            "cat_excess_energy",
            "cat_new_savage_roar_duration",
            "warlock_hand_of_guldan_in_flight",
            "warlock_haunt_in_flight",
            "druid_current_eclipse_phase",
            "mage_current_combustion_dot_estimate",
            "shaman_fire_elemental_duration",
            "monk_current_chi",
            "monk_max_chi",
            "brewmaster_monk_current_stagger_percent",
            "protection_paladin_damage_taken_last_global"
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
          "current_generic_resource",
          "max_health",
          "max_combo_points",
          "max_energy",
          "max_focus",
          "max_rage",
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
          "spell_num_charges",
          "spell_time_to_charge",
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
          "dot_percent_increase",
          "sequence_is_complete",
          "sequence_is_ready",
          "sequence_time_to_ready",
          "channel_clip_delay",
          "input_delay",
          "front_of_target",
          "totem_remaining_time",
          "cat_excess_energy",
          "cat_new_savage_roar_duration",
          "warlock_hand_of_guldan_in_flight",
          "warlock_haunt_in_flight",
          "druid_current_eclipse_phase",
          "mage_current_combustion_dot_estimate",
          "shaman_fire_elemental_duration",
          "monk_current_chi",
          "monk_max_chi",
          "brewmaster_monk_current_stagger_percent",
          "protection_paladin_damage_taken_last_global"
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
            includeIf = "(player: Player<any>, _isPrepull: boolean) => (player.getRaid()!.size() > 1) || player.shouldEnableTargetDummies()",
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
          juggernaut = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          double_time = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          warbringer = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          enraged_regeneration = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          second_wind = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          impending_victory = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          staggering_shout = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          piercing_howl = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          disrupting_shout = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          bladestorm = {
            id = 10,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
                registrationType = "RegisterSpell",
                functionName = "registerBladestorm",
                majorCooldown = {
                  type = "core.CooldownTypeDPS",
                  priority = nil
                },
                spellId = 46924,
                tag = 0,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
                cooldown = {
                  raw = "time.Minute * 1",
                  seconds = 60
                },
                Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
                ClassSpellMask = "SpellMaskBladestorm",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskEmpty",
                DamageMultiplier = "1.0",
                CritMultiplier = "war.DefaultCritMultiplier()",
                label = "Bladestorm"
              }
            }
          },
          shockwave = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          dragon_roar = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          mass_spell_reflection = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          safeguard = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          vigilance = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          avatar = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerAvatar",
                spellId = 107574,
                auraDuration = {
                  raw = "24 * time.Second",
                  seconds = 24
                },
                label = "Avatar"
              }
            }
          },
          bloodbath = {
            id = 17,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerBloodbath",
                spellId = 12292,
                auraDuration = {
                  raw = "12 * time.Second",
                  seconds = 12
                },
                label = "Bloodbath"
              }
            }
          },
          storm_bolt = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "juggernaut",
          "double_time",
          "warbringer",
          "enraged_regeneration",
          "second_wind",
          "impending_victory",
          "staggering_shout",
          "piercing_howl",
          "disrupting_shout",
          "bladestorm",
          "shockwave",
          "dragon_roar",
          "mass_spell_reflection",
          "safeguard",
          "vigilance",
          "avatar",
          "bloodbath",
          "storm_bolt"
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
          roiling_blood = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          plague_leech = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          unholy_blight = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          lichborne = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          anti_magic_zone = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          purgatory = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          deaths_advance = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          chilblains = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          asphyxiate = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          death_pact = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          death_siphon = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          conversion = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          blood_tap = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          runic_empowerment = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          runic_corruption = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          gorefiends_grasp = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          remorseless_winter = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          desecrated_ground = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "roiling_blood",
          "plague_leech",
          "unholy_blight",
          "lichborne",
          "anti_magic_zone",
          "purgatory",
          "deaths_advance",
          "chilblains",
          "asphyxiate",
          "death_pact",
          "death_siphon",
          "conversion",
          "blood_tap",
          "runic_empowerment",
          "runic_corruption",
          "gorefiends_grasp",
          "remorseless_winter",
          "desecrated_ground"
        }
      },
      DeathKnightOptions = {
        fields = {
          starting_runic_power = {
            id = 1,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "starting_runic_power"
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
          presence_of_mind = {
            id = 1,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerPresenceOfMind",
                spellId = 12043,
                auraDuration = {
                  raw = "time.Hour",
                  seconds = 3600
                },
                label = "Presence of Mind"
              }
            }
          },
          blazing_speed = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          ice_floes = {
            id = 3,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerIceFloes",
                spellId = 108839,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Ice Floes"
              }
            }
          },
          temporal_shield = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          flameglow = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          ice_barrier = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          ring_of_frost = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          ice_ward = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          frostjaw = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          greater_invisibility = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          cauterize = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          cold_snap = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          nether_tempest = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/nether_tempest.go",
                registrationType = "RegisterSpell",
                functionName = "registerNetherTempest",
                spellId = 114923,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
                Flags = "core.SpellFlagAPL",
                ClassSpellMask = "MageSpellNetherTempest",
                SpellSchool = "core.SpellSchoolArcane",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1",
                CritMultiplier = "mage.DefaultCritMultiplier()",
                ThreatMultiplier = "1",
                label = "Nether Tempest"
              }
            }
          },
          living_bomb = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/living_bomb.go",
                registrationType = "RegisterSpell",
                functionName = "registerLivingBomb",
                spellId = 44457,
                tag = 1,
                ClassSpellMask = "MageSpellLivingBombDot",
                SpellSchool = "core.SpellSchoolFire",
                ProcMask = "core.ProcMaskSpellDamage",
                DamageMultiplier = "1",
                CritMultiplier = "mage.DefaultCritMultiplier()",
                ThreatMultiplier = "1",
                label = "LivingBomb"
              }
            }
          },
          frost_bomb = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/frost_bomb.go",
                registrationType = "RegisterSpell",
                functionName = "registerFrostBomb",
                spellId = 112948,
                cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
                cooldown = {
                  raw = "time.Second * 10",
                  seconds = 10
                },
                Flags = "core.SpellFlagAPL",
                ClassSpellMask = "MageSpellFrostBomb",
                SpellSchool = "core.SpellSchoolFrost",
                ProcMask = "core.ProcMaskEmpty",
                label = "FrostBomb"
              }
            }
          },
          invocation = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          rune_of_power = {
            id = 17,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerRuneOfPower",
                spellId = 116011,
                auraDuration = {
                  raw = "time.Minute",
                  seconds = 60
                },
                label = "Rune of Power"
              }
            }
          },
          incanters_ward = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "presence_of_mind",
          "blazing_speed",
          "ice_floes",
          "temporal_shield",
          "flameglow",
          "ice_barrier",
          "ring_of_frost",
          "ice_ward",
          "frostjaw",
          "greater_invisibility",
          "cauterize",
          "cold_snap",
          "nether_tempest",
          "living_bomb",
          "frost_bomb",
          "invocation",
          "rune_of_power",
          "incanters_ward"
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
          posthaste = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          narrow_escape = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          crouching_tiger_hidden_chimera = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          binding_shot = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          wyvern_sting = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          intimidation = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          exhilaration = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          aspect_of_the_iron_hawk = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          spirit_bond = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          fervor = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          dire_beast = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          thrill_of_the_hunt = {
            id = 12,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/hunter/talents.go",
                registrationType = "RegisterAura",
                functionName = "applyThrillOfTheHunt",
                spellId = 109306,
                auraDuration = {
                  raw = "time.Second * 12",
                  seconds = 12
                },
                label = "Thrill of the Hunt"
              }
            }
          },
          a_murder_of_crows = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          blink_strikes = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          lynx_rush = {
            id = 15,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/hunter/lynx_rush.go",
                registrationType = "RegisterSpell",
                functionName = "RegisterLynxRushSpell",
                spellId = 120697,
                cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 0,
			},
		}]],
                Flags = "core.SpellFlagMeleeMetrics",
                ClassSpellMask = "HunterSpellLynxRush",
                SpellSchool = "core.SpellSchoolPhysical",
                ProcMask = "core.ProcMaskProc",
                DamageMultiplier = "1",
                CritMultiplier = "1",
                label = "Lynx Rush"
              }
            }
          },
          glaive_toss = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          powershot = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          barrage = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "posthaste",
          "narrow_escape",
          "crouching_tiger_hidden_chimera",
          "binding_shot",
          "wyvern_sting",
          "intimidation",
          "exhilaration",
          "aspect_of_the_iron_hawk",
          "spirit_bond",
          "fervor",
          "dire_beast",
          "thrill_of_the_hunt",
          "a_murder_of_crows",
          "blink_strikes",
          "lynx_rush",
          "glaive_toss",
          "powershot",
          "barrage"
        }
      },
      HunterOptions = {
        fields = {
          pet_type = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PetType"
          },
          pet_spec = {
            id = 3,
            type = "enum",
            label = "optional",
            enum_type = "PetSpec"
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
          },
          glaive_toss_success = {
            id = 9,
            type = "double",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "pet_type",
          "pet_spec",
          "pet_uptime",
          "time_to_trap_weave_ms",
          "use_hunters_mark",
          "use_aq_tier",
          "use_naxx_tier",
          "glaive_toss_success"
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
      DruidTalents = {
        fields = {
          feline_swiftness = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          displacer_beast = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          wild_charge = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          yseras_gift = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          renewal = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          cenarion_ward = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          faerie_swarm = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          mass_entanglement = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          typhoon = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          soul_of_the_forest = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          incarnation = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          force_of_nature = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          disorienting_roar = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          ursols_vortex = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          mighty_bash = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          heart_of_the_wild = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          dream_of_cenarius = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          natures_vigil = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "feline_swiftness",
          "displacer_beast",
          "wild_charge",
          "yseras_gift",
          "renewal",
          "cenarion_ward",
          "faerie_swarm",
          "mass_entanglement",
          "typhoon",
          "soul_of_the_forest",
          "incarnation",
          "force_of_nature",
          "disorienting_roar",
          "ursols_vortex",
          "mighty_bash",
          "heart_of_the_wild",
          "dream_of_cenarius",
          "natures_vigil"
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
      MonkTalents = {
        fields = {
          celerity = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          tigers_lust = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          momentum = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          chi_wave = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          zen_sphere = {
            id = 5,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerZenSphere",
                spellId = 124081,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Zen Sphere"
              }
            }
          },
          chi_burst = {
            id = 6,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerChiBurst",
                spellId = 123986,
                auraDuration = {
                  raw = "time.Second",
                  seconds = 1
                },
                label = "Chi Burst"
              }
            }
          },
          power_strikes = {
            id = 7,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerPowerStrikes",
                spellId = 129914,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Power Strikes"
              }
            }
          },
          ascension = {
            id = 8,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerAscension",
                spellId = 115396,
                label = "Ascension"
              }
            }
          },
          chi_brew = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          ring_of_peace = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          charging_ox_wave = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          leg_sweep = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          healing_elixirs = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          dampen_harm = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerDampenHarm",
                spellId = 122278,
                tag = 1,
                auraDuration = {
                  raw = "time.Second * 45",
                  seconds = 45
                },
                label = "Dampen Harm"
              }
            }
          },
          diffuse_magic = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          rushing_jade_wind = {
            id = 16,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerRushingJadeWind",
                spellId = 116847,
                auraDuration = {
                  raw = "baseCooldown",
                  seconds = nil
                },
                label = "Rushing Jade Wind"
              }
            }
          },
          invoke_xuen_the_white_tiger = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          chi_torpedo = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "celerity",
          "tigers_lust",
          "momentum",
          "chi_wave",
          "zen_sphere",
          "chi_burst",
          "power_strikes",
          "ascension",
          "chi_brew",
          "ring_of_peace",
          "charging_ox_wave",
          "leg_sweep",
          "healing_elixirs",
          "dampen_harm",
          "diffuse_magic",
          "rushing_jade_wind",
          "invoke_xuen_the_white_tiger",
          "chi_torpedo"
        }
      },
      MonkOptions = {
        fields = {

        },
        oneofs = {

        },
        field_order = {

        }
      },
      WindwalkerMonk = {
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
      MistweaverMonk = {
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
      BrewmasterMonk = {
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
      RogueTalents = {
        fields = {
          nightstalker = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          subterfuge = {
            id = 2,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "ApplyTalents",
                spellId = 108208,
                auraDuration = {
                  raw = "time.Second * 3",
                  seconds = 3
                },
                label = "Subterfuge"
              }
            }
          },
          shadow_focus = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          deadly_throw = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          nerve_strike = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          combat_readiness = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          cheat_death = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          leeching_poison = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          elusiveness = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          cloak_and_dagger = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          shadowstep = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/rogue/shadowstep.go",
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
          burst_of_speed = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          prey_on_the_weak = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          paralytic_poison = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          dirty_tricks = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          shuriken_toss = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          marked_for_death = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          anticipation = {
            id = 18,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/rogue/talents.go",
                registrationType = "RegisterAura",
                functionName = "ApplyTalents",
                spellId = 114015,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Anticipation"
              }
            }
          }
        },
        oneofs = {

        },
        field_order = {
          "nightstalker",
          "subterfuge",
          "shadow_focus",
          "deadly_throw",
          "nerve_strike",
          "combat_readiness",
          "cheat_death",
          "leeching_poison",
          "elusiveness",
          "cloak_and_dagger",
          "shadowstep",
          "burst_of_speed",
          "prey_on_the_weak",
          "paralytic_poison",
          "dirty_tricks",
          "shuriken_toss",
          "marked_for_death",
          "anticipation"
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
          lethal_poison = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PoisonOptions"
          },
          starting_overkill_duration = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          apply_poisons_manually = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          vanish_break_time = {
            id = 5,
            type = "float",
            label = "optional"
          },
          starting_combo_points = {
            id = 6,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "tricks_of_the_trade_target",
          "lethal_poison",
          "starting_overkill_duration",
          "apply_poisons_manually",
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
          natures_guardian = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          stone_bulwark_totem = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          astral_shift = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          frozen_power = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          earthgrab_totem = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          windwalk_totem = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          call_of_the_elements = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          totemic_persistence = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          totemic_projection = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          elemental_mastery = {
            id = 10,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "ApplyElementalMastery",
                spellId = 16166,
                auraDuration = {
                  raw = "time.Second * 20",
                  seconds = 20
                },
                label = "Elemental Mastery"
              }
            }
          },
          ancestral_swiftness = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
                registrationType = "RegisterAura",
                functionName = "ApplyAncestralSwiftness",
                spellId = 16188,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Ancestral swiftness"
              }
            }
          },
          echo_of_the_elements = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          rushing_streams = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          ancestral_guidance = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          conductivity = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          unleashed_fury = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          primal_elementalist = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          elemental_blast = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "natures_guardian",
          "stone_bulwark_totem",
          "astral_shift",
          "frozen_power",
          "earthgrab_totem",
          "windwalk_totem",
          "call_of_the_elements",
          "totemic_persistence",
          "totemic_projection",
          "elemental_mastery",
          "ancestral_swiftness",
          "echo_of_the_elements",
          "rushing_streams",
          "ancestral_guidance",
          "conductivity",
          "unleashed_fury",
          "primal_elementalist",
          "elemental_blast"
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
      FeleAutocastSettings = {
        fields = {
          autocast_fireblast = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          autocast_firenova = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          autocast_immolate = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          autocast_empower = {
            id = 4,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "autocast_fireblast",
          "autocast_firenova",
          "autocast_immolate",
          "autocast_empower"
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
          imbue_mh = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "ShamanImbue"
          },
          fele_autocast = {
            id = 3,
            type = "message",
            label = "optional",
            message_type = "FeleAutocastSettings"
          }
        },
        oneofs = {

        },
        field_order = {
          "shield",
          "imbue_mh",
          "fele_autocast"
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
      ItemEffectRandPropPoints = {
        fields = {
          ilvl = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          rand_prop_points = {
            id = 2,
            type = "int32",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "ilvl",
          "rand_prop_points"
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
          item_effect_rand_prop_points = {
            id = 9,
            type = "message",
            label = "repeated",
            message_type = "ItemEffectRandPropPoints"
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
          "item_effect_rand_prop_points",
          "consumables",
          "spell_effects"
        }
      },
      WarlockTalents = {
        fields = {
          dark_regeneration = {
            id = 1,
            type = "bool",
            label = "optional"
          },
          soul_leech = {
            id = 2,
            type = "bool",
            label = "optional"
          },
          harvest_life = {
            id = 3,
            type = "bool",
            label = "optional"
          },
          demonic_breath = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          mortal_coil = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          shadowfury = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          soul_link = {
            id = 7,
            type = "bool",
            label = "optional"
          },
          sacrificial_pact = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          dark_bargain = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          blood_horror = {
            id = 10,
            type = "bool",
            label = "optional"
          },
          burning_rush = {
            id = 11,
            type = "bool",
            label = "optional"
          },
          unbound_will = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          grimoire_of_supremacy = {
            id = 13,
            type = "bool",
            label = "optional"
          },
          grimoire_of_service = {
            id = 14,
            type = "bool",
            label = "optional"
          },
          grimoire_of_sacrifice = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          archimondes_darkness = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          kiljaedens_cunning = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          mannoroths_fury = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "dark_regeneration",
          "soul_leech",
          "harvest_life",
          "demonic_breath",
          "mortal_coil",
          "shadowfury",
          "soul_link",
          "sacrificial_pact",
          "dark_bargain",
          "blood_horror",
          "burning_rush",
          "unbound_will",
          "grimoire_of_supremacy",
          "grimoire_of_service",
          "grimoire_of_sacrifice",
          "archimondes_darkness",
          "kiljaedens_cunning",
          "mannoroths_fury"
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
          use_item_swap_bonus_stats = {
            id = 3,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "summon",
          "detonate_seed",
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
          speed_of_light = {
            id = 1,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerSpeedOfLight",
                spellId = 85499,
                auraDuration = {
                  raw = "time.Second * 8",
                  seconds = 8
                },
                label = "Speed of Light"
              }
            }
          },
          long_arm_of_the_law = {
            id = 2,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerLongArmOfTheLaw",
                spellId = 87173,
                auraDuration = {
                  raw = "time.Second * 3",
                  seconds = 3
                },
                label = "Long Arm of the Law"
              }
            }
          },
          pursuit_of_justice = {
            id = 3,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerPursuitOfJustice",
                spellId = 114695,
                auraDuration = {
                  raw = "core.NeverExpires",
                  seconds = -1
                },
                label = "Pursuit of Justice"
              }
            }
          },
          fist_of_justice = {
            id = 4,
            type = "bool",
            label = "optional"
          },
          repentance = {
            id = 5,
            type = "bool",
            label = "optional"
          },
          evil_is_a_point_of_view = {
            id = 6,
            type = "bool",
            label = "optional"
          },
          selfless_healer = {
            id = 7,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerSelflessHealer",
                spellId = 114250,
                auraDuration = {
                  raw = "time.Second * 15",
                  seconds = 15
                },
                label = "Selfless Healer"
              }
            }
          },
          eternal_flame = {
            id = 8,
            type = "bool",
            label = "optional"
          },
          sacred_shield = {
            id = 9,
            type = "bool",
            label = "optional"
          },
          hand_of_purity = {
            id = 10,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerHandOfPurity",
                spellId = 114039,
                auraDuration = {
                  raw = "time.Second * 6",
                  seconds = 6
                },
                label = "Hand of Purity"
              }
            }
          },
          unbreakable_spirit = {
            id = 11,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerUnbreakableSpirit",
                spellId = 114154,
                label = "Unbreakable Spirit"
              }
            }
          },
          clemency = {
            id = 12,
            type = "bool",
            label = "optional"
          },
          holy_avenger = {
            id = 13,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerHolyAvenger",
                spellId = 105809,
                auraDuration = {
                  raw = "time.Second * 18",
                  seconds = 18
                },
                label = "Holy Avenger"
              }
            }
          },
          sanctified_wrath = {
            id = 14,
            type = "bool",
            label = "optional",
            goMetadata = {
              {
                sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
                registrationType = "RegisterAura",
                functionName = "registerSanctifiedWrath",
                spellId = 114232,
                auraDuration = {
                  raw = "time.Second * 30",
                  seconds = 30
                },
                label = "Sanctified Wrath"
              }
            }
          },
          divine_purpose = {
            id = 15,
            type = "bool",
            label = "optional"
          },
          holy_prism = {
            id = 16,
            type = "bool",
            label = "optional"
          },
          lights_hammer = {
            id = 17,
            type = "bool",
            label = "optional"
          },
          execution_sentence = {
            id = 18,
            type = "bool",
            label = "optional"
          }
        },
        oneofs = {

        },
        field_order = {
          "speed_of_light",
          "long_arm_of_the_law",
          "pursuit_of_justice",
          "fist_of_justice",
          "repentance",
          "evil_is_a_point_of_view",
          "selfless_healer",
          "eternal_flame",
          "sacred_shield",
          "hand_of_purity",
          "unbreakable_spirit",
          "clemency",
          "holy_avenger",
          "sanctified_wrath",
          "divine_purpose",
          "holy_prism",
          "lights_hammer",
          "execution_sentence"
        }
      },
      PaladinOptions = {
        fields = {
          starting_holy_power = {
            id = 1,
            type = "int32",
            label = "optional"
          },
          seal = {
            id = 2,
            type = "enum",
            label = "optional",
            enum_type = "PaladinSeal"
          }
        },
        oneofs = {

        },
        field_order = {
          "starting_holy_power",
          "seal"
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
          consumables = {
            id = 4,
            type = "message",
            label = "optional",
            message_type = "ConsumesSpec"
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
          challenge_mode = {
            id = 20,
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
          "consumables",
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
          "challenge_mode"
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
          consumables = {
            id = 4,
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
          brewmaster_monk = {
            id = 55,
            type = "message",
            label = "optional",
            message_type = "BrewmasterMonk"
          },
          mistweaver_monk = {
            id = 56,
            type = "message",
            label = "optional",
            message_type = "MistweaverMonk"
          },
          windwalker_monk = {
            id = 57,
            type = "message",
            label = "optional",
            message_type = "WindwalkerMonk"
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
          challenge_mode = {
            id = 58,
            type = "bool",
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
            "brewmaster_monk",
            "mistweaver_monk",
            "windwalker_monk",
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
          "brewmaster_monk",
          "mistweaver_monk",
          "windwalker_monk",
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
          "challenge_mode",
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
            id = 1,
            type = "int32",
            label = "optional"
          },
          casts = {
            id = 2,
            type = "int32",
            label = "optional"
          },
          hits = {
            id = 3,
            type = "int32",
            label = "optional"
          },
          crits = {
            id = 4,
            type = "int32",
            label = "optional"
          },
          ticks = {
            id = 5,
            type = "int32",
            label = "optional"
          },
          crit_ticks = {
            id = 6,
            type = "int32",
            label = "optional"
          },
          misses = {
            id = 7,
            type = "int32",
            label = "optional"
          },
          dodges = {
            id = 8,
            type = "int32",
            label = "optional"
          },
          parries = {
            id = 9,
            type = "int32",
            label = "optional"
          },
          blocks = {
            id = 10,
            type = "int32",
            label = "optional"
          },
          crit_blocks = {
            id = 11,
            type = "int32",
            label = "optional"
          },
          glances = {
            id = 12,
            type = "int32",
            label = "optional"
          },
          glance_blocks = {
            id = 13,
            type = "int32",
            label = "optional"
          },
          damage = {
            id = 14,
            type = "double",
            label = "optional"
          },
          crit_damage = {
            id = 15,
            type = "double",
            label = "optional"
          },
          tick_damage = {
            id = 16,
            type = "double",
            label = "optional"
          },
          crit_tick_damage = {
            id = 17,
            type = "double",
            label = "optional"
          },
          glance_damage = {
            id = 18,
            type = "double",
            label = "optional"
          },
          glance_block_damage = {
            id = 19,
            type = "double",
            label = "optional"
          },
          block_damage = {
            id = 20,
            type = "double",
            label = "optional"
          },
          crit_block_damage = {
            id = 21,
            type = "double",
            label = "optional"
          },
          threat = {
            id = 22,
            type = "double",
            label = "optional"
          },
          healing = {
            id = 23,
            type = "double",
            label = "optional"
          },
          crit_healing = {
            id = 24,
            type = "double",
            label = "optional"
          },
          shielding = {
            id = 25,
            type = "double",
            label = "optional"
          },
          cast_time_ms = {
            id = 26,
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
          "glance_blocks",
          "damage",
          "crit_damage",
          "tick_damage",
          "crit_tick_damage",
          "glance_damage",
          "glance_block_damage",
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
          },
          has_expected_tick = {
            id = 11,
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
          "is_friendly",
          "has_expected_tick"
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
          validations = {
            id = 1,
            type = "message",
            label = "repeated",
            message_type = "APLValidation"
          }
        },
        oneofs = {

        },
        field_order = {
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
          name_description = {
            id = 19,
            type = "string",
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
          "name_description",
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
          item_effect_rand_prop_points = {
            id = 15,
            type = "message",
            label = "repeated",
            message_type = "ItemEffectRandPropPoints"
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
          "item_effect_rand_prop_points",
          "consumables",
          "spell_effects"
        }
      }
    },
    enums = {
      PriestMajorGlyph = {
        PriestMajorGlyphNone = 0,
        GlyphOfCircleOfHealing = 42396,
        GlyphOfPurify = 42397,
        GlyphOfFade = 42398,
        GlyphOfFearWard = 42399,
        GlyphOfInnerSanctum = 42400,
        GlyphOfHolyNova = 42401,
        GlyphOfInnerFire = 42402,
        GlyphOfDeepWells = 42403,
        GlyphOfMassDispel = 42404,
        GlyphOfPsychicHorror = 42405,
        GlyphOfHolyFire = 42406,
        GlyphOfWeakenedSoul = 42407,
        GlyphOfPowerWordShield = 42408,
        GlyphOfSpiritOfRedemption = 42409,
        GlyphOfPsychicScream = 42410,
        GlyphOfRenew = 42411,
        GlyphOfScourgeImprisonment = 42412,
        GlyphOfMindBlast = 42414,
        GlyphOfDispelMagic = 42415,
        GlyphOfSmite = 42416,
        GlyphOfPrayerOfMending = 42417,
        GlyphOfLevitate = 43370,
        GlyphOfReflectiveShield = 43372,
        GlyphOfDispersion = 45753,
        GlyphOfLeapOfFaith = 45755,
        GlyphOfPenance = 45756,
        GlyphOfFocusedMending = 45757,
        GlyphOfMindSpike = 45758,
        GlyphOfBindingHeal = 45760,
        GlyphOfMindFlay = 79513,
        GlyphOfShadowWordDeath = 79514,
        GlyphOfVampiricEmbrace = 79515,
        GlyphOfLightspring = 87875,
        GlyphOfLightwell = 87902
      },
      PriestMinorGlyph = {
        PriestMinorGlyphNone = 0,
        GlyphOfShadowRavens = 43342,
        GlyphOfBorrowedTime = 43371,
        GlyphOfShackleUndead = 43373,
        GlyphOfDarkArchangel = 43374,
        GlyphOfShadow = 77101,
        GlyphOfTheHeavens = 79538,
        GlyphOfConfession = 86541,
        GlyphOfHolyResurrection = 87276,
        GlyphOfTheValkyr = 87277,
        GlyphOfShadowyFriends = 87392,
        GlyphOfAngels = 104109,
        GlyphOfTheSha = 104120,
        GlyphOfShiftedAppearances = 104121,
        GlyphOfInspiredHymns = 104122
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
        ResourceTypeChi = 14,
        ResourceTypeGenericResource = 15
      },
      SecondaryResourceType = {
        SecondaryResourceTypeNone = 0,
        SecondaryResourceTypeArcaneCharges = 36032,
        SecondaryResourceTypeShadowOrbs = 95740,
        SecondaryResourceTypeDemonicFury = 104315,
        SecondaryResourceTypeBurningEmbers = 108647,
        SecondaryResourceTypeSoulShards = 117198,
        SecondaryResourceTypeHolyPower = 138248
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
        SpecProtectionWarrior = 30,
        SpecBrewmasterMonk = 32,
        SpecMistweaverMonk = 33,
        SpecWindwalkerMonk = 34
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
        RaceGoblin = 12,
        RaceAlliancePandaren = 13,
        RaceHordePandaren = 14
      },
      Faction = {
        Unknown = 0,
        Alliance = 1,
        Horde = 2
      },
      Class = {
        ClassUnknown = 0,
        ClassWarrior = 1,
        ClassPaladin = 2,
        ClassHunter = 3,
        ClassRogue = 4,
        ClassPriest = 5,
        ClassDeathKnight = 6,
        ClassShaman = 7,
        ClassMage = 8,
        ClassWarlock = 9,
        ClassMonk = 10,
        ClassDruid = 11,
        ClassExtra1 = 12,
        ClassExtra2 = 13,
        ClassExtra3 = 14,
        ClassExtra4 = 15,
        ClassExtra5 = 16,
        ClassExtra6 = 17
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
        StatPvpResilienceRating = 15,
        StatPvpPowerRating = 16,
        StatArmor = 17,
        StatBonusArmor = 18,
        StatHealth = 19,
        StatMana = 20,
        StatMP5 = 21
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
        ItemSlotOffHand = 15
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
        GemColorCogwheel = 9,
        GemColorShaTouched = 10
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
      WarriorMajorGlyph = {
        WarriorMajorGlyphNone = 0,
        GlyphOfLongCharge = 43397,
        GlyphOfUnendingRage = 43399,
        GlyphOfEnragedSpeed = 43413,
        GlyphOfHinderingStrikes = 43414,
        GlyphOfHeavyRepercussions = 43415,
        GlyphOfBloodthirst = 43416,
        GlyphOfRudeInterruption = 43417,
        GlyphOfGagOrder = 43418,
        GlyphOfBlitz = 43419,
        GlyphOfMortalStrike = 43421,
        GlyphOfDieByTheSword = 43422,
        GlyphOfHamstring = 43423,
        GlyphOfHoldTheLine = 43424,
        GlyphOfShieldSlam = 43425,
        GlyphOfHoarseVoice = 43427,
        GlyphOfSweepingStrikes = 43428,
        GlyphOfResonatingPower = 43430,
        GlyphOfVictoryRush = 43431,
        GlyphOfRagingWind = 43432,
        GlyphOfWhirlwind = 45790,
        GlyphOfDeathFromAbove = 45792,
        GlyphOfVictoriousThrow = 45793,
        GlyphOfSpellReflection = 45795,
        GlyphOfShieldWall = 45797,
        GlyphOfColossusSmash = 63481,
        GlyphOfBullRush = 67482,
        GlyphOfRecklessness = 67483,
        GlyphOfIncite = 83096,
        GlyphOfImpalingThrows = 104055,
        GlyphOfTheExecutor = 104056
      },
      WarriorMinorGlyph = {
        WarriorMinorGlyphNone = 0,
        GlyphOfMysticShout = 43395,
        GlyphOfBloodcurdlingShout = 43396,
        GlyphOfGushingWound = 43398,
        GlyphOfMightyVictory = 43400,
        GlyphOfBloodyHealing = 43412,
        GlyphOfIntimidatingShout = 45794,
        GlyphOfThunderStrike = 49084,
        GlyphOfCrowFeast = 80587,
        GlyphOfBurningAnger = 80588,
        GlyphOfTheBlazingTrail = 85221,
        GlyphOfTheRagingWhirlwind = 104135,
        GlyphOfTheSubtleDefender = 104136,
        GlyphOfTheWatchfulEye = 104137,
        GlyphOfTheWeaponmaster = 104138
      },
      WarriorSyncType = {
        WarriorNoSync = 0,
        WarriorSyncMainhandOffhandSwings = 1
      },
      DeathKnightMajorGlyph = {
        DeathKnightMajorGlyphNone = 0,
        GlyphOfAntiMagicShell = 43533,
        GlyphOfUnholyFrenzy = 43534,
        GlyphOfIceboundFortitude = 43536,
        GlyphOfChainsOfIce = 43537,
        GlyphOfDeathGrip = 43541,
        GlyphOfDeathAndDecay = 43542,
        GlyphOfShiftingPresences = 43543,
        GlyphOfIcyTouch = 43546,
        GlyphOfEnduringInfection = 43547,
        GlyphOfPestilence = 43548,
        GlyphOfMindFreeze = 43549,
        GlyphOfStrangulate = 43552,
        GlyphOfPillarOfFrost = 43553,
        GlyphOfVampiricBlood = 43554,
        GlyphOfUnholyCommand = 43825,
        GlyphOfOutbreak = 43826,
        GlyphOfDancingRuneWeapon = 45799,
        GlyphOfDarkSimulacrum = 45800,
        GlyphOfDeathCoil = 45804,
        GlyphOfDarkSuccor = 68793,
        GlyphOfSwiftDeath = 104046,
        GlyphOfLoudHorn = 104047,
        GlyphOfRegenerativeMagic = 104048,
        GlyphOfFesteringBlood = 104049
      },
      DeathKnightMinorGlyph = {
        DeathKnightMinorGlyphNone = 0,
        GlyphOfTheGeist = 43535,
        GlyphOfDeathsEmbrace = 43539,
        GlyphOfHornOfWinter = 43544,
        GlyphOfArmyOfTheDead = 43550,
        GlyphOfFoulMenagerie = 43551,
        GlyphOfPathOfFrost = 43671,
        GlyphOfResilientGrip = 43672,
        GlyphOfDeathGate = 43673,
        GlyphOfCorpseExplosion = 43827,
        GlyphOfTranquilGrip = 45806,
        GlyphOfTheSkeleton = 104099,
        GlyphOfTheLongWinter = 104101
      },
      MageMajorGlyph = {
        MageMajorGlyphNone = 0,
        GlyphOfArcaneExplosion = 42736,
        GlyphOfBlink = 42737,
        GlyphOfEvocation = 42738,
        GlyphOfCombustion = 42739,
        GlyphOfFrostNova = 42741,
        GlyphOfIceBlock = 42744,
        GlyphOfSplittingIce = 42745,
        GlyphOfConeOfCold = 42746,
        GlyphOfRapidDisplacement = 42748,
        GlyphOfManaGem = 42749,
        GlyphOfPolymorph = 42752,
        GlyphOfIcyVeins = 42753,
        GlyphOfSpellsteal = 42754,
        GlyphOfFrostfireBolt = 44684,
        GlyphOfRemoveCurse = 44920,
        GlyphOfArcanePower = 44955,
        GlyphOfWaterElemental = 45736,
        GlyphOfSlow = 45737,
        GlyphOfDeepFreeze = 45740,
        GlyphOfCounterspell = 50045,
        GlyphOfInfernoBlast = 63539,
        GlyphOfArmors = 69773
      },
      MageMinorGlyph = {
        MageMinorGlyphNone = 0,
        GlyphOfLooseMana = 42735,
        GlyphOfMomentum = 42743,
        GlyphOfCrittermorph = 42751,
        GlyphOfThePorcupine = 43339,
        GlyphOfConjureFamiliar = 43359,
        GlyphOfTheMonkey = 43360,
        GlyphOfThePenguin = 43361,
        GlyphOfTheBearCub = 43362,
        GlyphOfArcaneLanguage = 43364,
        GlyphOfIllusion = 45738,
        GlyphOfMirrorImage = 45739,
        GlyphOfRapidTeleportation = 63416,
        GlyphOfDiscreetMagic = 92727,
        GlyphOfTheUnboundElemental = 104104,
        GlyphOfEvaporation = 104105,
        GlyphOfCondensation = 104106
      },
      HunterMajorGlyph = {
        HunterMajorGlyphNone = 0,
        GlyphOfCamouflage = 42898,
        GlyphOfLiberation = 42899,
        GlyphOfMending = 42900,
        GlyphOfDistractingShot = 42901,
        GlyphOfEndlessWrath = 42902,
        GlyphOfDeterrence = 42903,
        GlyphOfDisengage = 42904,
        GlyphOfFreezingTrap = 42905,
        GlyphOfIceTrap = 42906,
        GlyphOfMisdirection = 42907,
        GlyphOfExplosiveTrap = 42908,
        GlyphOfAnimalBond = 42909,
        GlyphOfNoEscape = 42910,
        GlyphOfPathfinding = 42911,
        GlyphOfSnakeTrap = 42913,
        GlyphOfAimedShot = 42914,
        GlyphOfMendPet = 42915,
        GlyphOfSolace = 42917,
        GlyphOfChimeraShot = 45625,
        GlyphOfTranquilizingShot = 45731,
        GlyphOfMastersCall = 45733,
        GlyphOfScatterShot = 45734,
        GlyphOfMirroredBlades = 45735,
        GlyphOfBlackIce = 85684,
        GlyphOfTheLeanPack = 104270,
        GlyphOfEnduringDeceit = 104276
      },
      HunterMinorGlyph = {
        HunterMinorGlyphNone = 0,
        GlyphOfAspects = 42897,
        GlyphOfTameBeast = 42912,
        GlyphOfRevivePet = 43338,
        GlyphOfLesserProportion = 43350,
        GlyphOfFireworks = 43351,
        GlyphOfAspectOfThePack = 43355,
        GlyphOfStampedeHunter = 43356,
        GlyphOfAspectOfTheCheetah = 45732,
        GlyphOfAspectOfTheBeast = 85683,
        GlyphOfDirection = 87278,
        GlyphOfMarking = 87279,
        GlyphOfFetch = 87393,
        GlyphOfFocusedFire = 104274,
        GlyphOfChameleon = 104278
      },
      PetSpec = {
        Ferocity = 0,
        Tenacity = 1,
        Cunning = 2
      },
      HunterStingType = {
        NoSting = 0,
        ScorpidSting = 1,
        SerpentSting = 2
      },
      DruidMajorGlyph = {
        DruidMajorGlyphNone = 0,
        GlyphOfFrenziedRegeneration = 40896,
        GlyphOfMaul = 40897,
        GlyphOfOmens = 40899,
        GlyphOfShred = 40901,
        GlyphOfProwl = 40902,
        GlyphOfPounce = 40903,
        GlyphOfStampede = 40906,
        GlyphOfInnervate = 40908,
        GlyphOfRebirth = 40909,
        GlyphOfRegrowth = 40912,
        GlyphOfRejuvenation = 40913,
        GlyphOfHealingTouch = 40914,
        GlyphOfEfflorescence = 40915,
        GlyphOfGuidedStars = 40916,
        GlyphOfHurricane = 40920,
        GlyphOfSkullBash = 40921,
        GlyphOfNaturesGrasp = 40922,
        GlyphOfSavagery = 40923,
        GlyphOfEntanglingRoots = 40924,
        GlyphOfBlooming = 43331,
        GlyphOfDash = 43674,
        GlyphOfMasterShapeshifter = 44928,
        GlyphOfSurvivalInstincts = 45601,
        GlyphOfWildGrowth = 45602,
        GlyphOfMightOfUrsoc = 45603,
        GlyphOfStampedingRoar = 45604,
        GlyphOfCyclone = 45622,
        GlyphOfBarkskin = 45623,
        GlyphOfFerociousBite = 48720,
        GlyphOfFaeSilence = 67484,
        GlyphOfFaerieFire = 67485,
        GlyphOfCatForm = 67487
      },
      DruidMinorGlyph = {
        DruidMinorGlyphNone = 0,
        GlyphOfTheStag = 40900,
        GlyphOfTheOrca = 40919,
        GlyphOfAquaticForm = 43316,
        GlyphOfGrace = 43332,
        GlyphOfTheChameleon = 43334,
        GlyphOfCharmWoodlandCreature = 43335,
        GlyphOfStars = 44922,
        GlyphOfThePredator = 67486,
        GlyphOfTheTreant = 68039,
        GlyphOfTheCheetah = 89868,
        GlyphOfFocus = 93203,
        GlyphOfTheSproutingMushroom = 104102,
        GlyphOfOneWithNature = 104103
      },
      MonkMajorGlyph = {
        MonkMajorGlyphNone = 0,
        GlyphOfRapidRolling = 82345,
        GlyphOfTranscendence = 84652,
        GlyphOfBreathOfFire = 85685,
        GlyphOfClash = 85687,
        GlyphOfEnduringHealingSphere = 85689,
        GlyphOfGuard = 85691,
        GlyphOfManaTea = 85692,
        GlyphOfZenMeditation = 85695,
        GlyphOfRenewingMists = 85696,
        GlyphOfSpinningCraneKick = 85697,
        GlyphOfSurgingMist = 85699,
        GlyphOfTouchOfDeath = 85700,
        GlyphOfNimbleBrew = 87880,
        GlyphOfAfterlife = 87891,
        GlyphOfFistsOfFury = 87892,
        GlyphOfFortifyingBrew = 87893,
        GlyphOfLeerOfTheOx = 87894,
        GlyphOfLifeCocoon = 87895,
        GlyphOfFortuitousSpheres = 87896,
        GlyphOfParalysis = 87897,
        GlyphOfSparring = 87898,
        GlyphOfDetox = 87899,
        GlyphOfTouchOfKarma = 87900,
        GlyphOfTargetedExpulsion = 87901
      },
      MonkMinorGlyph = {
        MonkMinorGlyphNone = 0,
        GlyphOfSpinningFireBlossom = 85698,
        GlyphOfCracklingTigerLightning = 87881,
        GlyphOfFlyingSerpentKick = 87882,
        GlyphOfHonor = 87883,
        GlyphOfJab = 87884,
        GlyphOfRisingTigerKick = 87885,
        GlyphOfSpiritRoll = 87887,
        GlyphOfFightingPose = 87888,
        GlyphOfWaterRoll = 87889,
        GlyphOfZenFlight = 87890,
        GlyphOfBlackoutKick = 90715
      },
      MonkStance = {
        None = 0,
        SturdyOx = 1,
        WiseSerpent = 2,
        FierceTiger = 3
      },
      RogueMajorGlyph = {
        RogueMajorGlyphNone = 0,
        GlyphOfShadowWalk = 42954,
        GlyphOfAmbush = 42955,
        GlyphOfBladeFlurry = 42957,
        GlyphOfSharpKnives = 42958,
        GlyphOfRecuperate = 42959,
        GlyphOfEvasion = 42960,
        GlyphOfRecovery = 42961,
        GlyphOfExposeArmor = 42962,
        GlyphOfFeint = 42963,
        GlyphOfGarrote = 42964,
        GlyphOfGouge = 42966,
        GlyphOfSmokeBomb = 42968,
        GlyphOfCheapShot = 42969,
        GlyphOfHemorraghingVeins = 42970,
        GlyphOfKick = 42971,
        GlyphOfRedirect = 42972,
        GlyphOfShiv = 42973,
        GlyphOfSprint = 42974,
        GlyphOfVendetta = 45761,
        GlyphOfStealth = 45764,
        GlyphOfDeadlyMomentum = 45766,
        GlyphOfCloakOfShadows = 45769,
        GlyphOfVanish = 63420,
        GlyphOfBlind = 64493
      },
      RogueMinorGlyph = {
        RogueMinorGlyphNone = 0,
        GlyphOfDecoy = 42956,
        GlyphOfDetection = 42965,
        GlyphOfHemorrhage = 42967,
        GlyphOfPickPocket = 43343,
        GlyphOfDistract = 43376,
        GlyphOfPickLock = 43377,
        GlyphOfSafeFall = 43378,
        GlyphOfBlurredSpeed = 43379,
        GlyphOfPoisons = 43380,
        GlyphOfKillingSpree = 45762,
        GlyphOfTricksOfTheTrade = 45767,
        GlyphOfDisguise = 45768,
        GlyphOfHeadhunting = 104123,
        GlyphOfImprovedDistraction = 104124
      },
      ShamanMajorGlyph = {
        ShamanMajorGlyphNone = 0,
        GlyphOfUnstableEarth = 41517,
        GlyphOfChainLightning = 41518,
        GlyphOfSpiritWalk = 41524,
        GlyphOfCapacitorTotem = 41526,
        GlyphOfPurge = 41527,
        GlyphOfFireElementalTotem = 41529,
        GlyphOfFireNova = 41530,
        GlyphOfFlameShock = 41531,
        GlyphOfWindShear = 41532,
        GlyphOfHealingStreamTotem = 41533,
        GlyphOfHealingWave = 41534,
        GlyphOfTotemicRecall = 41535,
        GlyphOfTelluricCurrents = 41536,
        GlyphOfGroundingTotem = 41538,
        GlyphOfSpiritwalkersGrace = 41539,
        GlyphOfWaterShield = 41541,
        GlyphOfCleansingWaters = 41542,
        GlyphOfFrostShock = 41547,
        GlyphOfChaining = 41552,
        GlyphOfHealingStorm = 43344,
        GlyphOfGhostWolf = 43725,
        GlyphOfThunder = 45770,
        GlyphOfFeralSpirit = 45771,
        GlyphOfRiptide = 45772,
        GlyphOfShamanisticRage = 45776,
        GlyphOfHex = 45777,
        GlyphOfTotemicVigor = 45778,
        GlyphOfLightningShield = 71155,
        GlyphOfPurging = 104052,
        GlyphOfEternalEarth = 104053
      },
      ShamanMinorGlyph = {
        ShamanMinorGlyphNone = 0,
        GlyphOfTheLakestrider = 41537,
        GlyphOfLavaLash = 41540,
        GlyphOfAstralRecall = 43381,
        GlyphOfFarSight = 43385,
        GlyphOfTheSpectralWolf = 43386,
        GlyphOfTotemicEncirclement = 43388,
        GlyphOfThunderstorm = 44923,
        GlyphOfDeluge = 45775,
        GlyphOfSpiritRaptors = 104126,
        GlyphOfLingeringAncestors = 104127,
        GlyphOfSpiritWolf = 104128,
        GlyphOfFlamingSerpent = 104129,
        GlyphOfTheCompy = 104130,
        GlyphOfElementalFamiliars = 104131,
        GlyphOfAstralFixation = 104133,
        GlyphOfRainOfFrogs = 104134
      },
      EarthTotem = {
        NoEarthTotem = 0,
        EarthElementalTotem = 1,
        TremorTotem = 2,
        EarthbindTotem = 3
      },
      AirTotem = {
        NoAirTotem = 0,
        StormlashTotem = 1,
        GroundingTotem = 2,
        CapacitorTotem = 3,
        SpiritLinkTotem = 4
      },
      FireTotem = {
        NoFireTotem = 0,
        MagmaTotem = 1,
        SearingTotem = 2,
        FireElementalTotem = 3
      },
      WaterTotem = {
        NoWaterTotem = 0,
        HealingTideTotem = 1,
        HealingStreamTotem = 2,
        ManaTideTotem = 3
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
        EarthlivingWeapon = 4,
        RockbiterWeapon = 5
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
      WarlockMajorGlyph = {
        WarlockMajorGlyphNone = 0,
        GlyphOfConflagrate = 42454,
        GlyphOfSiphonLife = 42455,
        GlyphOfFear = 42458,
        GlyphOfDemonTraining = 42460,
        GlyphOfHealthstone = 42462,
        GlyphOfCurseOfTheElements = 42464,
        GlyphOfImpSwarm = 42465,
        GlyphOfHavoc = 42466,
        GlyphOfSoulstone = 42470,
        GlyphOfUnstableAffliction = 42472,
        GlyphOfSoulConsumption = 43390,
        GlyphOfCurseOfExhaustion = 43392,
        GlyphOfDrainLife = 45779,
        GlyphOfDemonHunting = 45780,
        GlyphOfEmberTap = 45781,
        GlyphOfDemonicCircle = 45782,
        GlyphOfUnendingResolve = 45783,
        GlyphOfLifeTap = 45785,
        GlyphOfEternalResolve = 50077,
        GlyphOfSupernova = 93197
      },
      WarlockMinorGlyph = {
        WarlockMinorGlyphNone = 0,
        GlyphOfHandOfGuldan = 42453,
        GlyphOfVerdantSpheres = 42456,
        GlyphOfNightmares = 42457,
        GlyphOfFelguard = 42459,
        GlyphOfHealthFunnel = 42461,
        GlyphOfSubtlety = 42463,
        GlyphOfShadowBolt = 42467,
        GlyphOfCarrionSwarm = 42471,
        GlyphOfFallingMeteor = 42473,
        GlyphOfUnendingBreath = 43389,
        GlyphOfEyeOfKilrogg = 43391,
        GlyphOfSubjugateDemon = 43393,
        GlyphOfSoulwell = 43394,
        GlyphOfCrimsonBanish = 45789,
        GlyphOfGatewayAttunement = 93202
      },
      PaladinMajorGlyph = {
        PaladinMajorGlyphNone = 0,
        GlyphOfDoubleJeopardy = 41092,
        GlyphOfDevotionAura = 41094,
        GlyphOfHolyWrath = 41095,
        GlyphOfDivineProtection = 41096,
        GlyphOfTemplarsVerdict = 41097,
        GlyphOfAvengingWrath = 41098,
        GlyphOfConsecration = 41099,
        GlyphOfFocusedShield = 41101,
        GlyphOfBurdenOfGuilt = 41102,
        GlyphOfBlindingLight = 41103,
        GlyphOfFinalWrath = 41104,
        GlyphOfWordOfGlory = 41105,
        GlyphOfIllumination = 41106,
        GlyphOfHarshWords = 41107,
        GlyphOfDivinity = 41108,
        GlyphOfLightOfDawn = 41109,
        GlyphOfBlessedLife = 41110,
        GlyphOfFlashOfLight = 43367,
        GlyphOfDenounce = 43867,
        GlyphOfDazingShield = 43868,
        GlyphOfImmediateTruth = 43869,
        GlyphOfBeaconOfLight = 45741,
        GlyphOfHammerOfTheRighteous = 45742,
        GlyphOfDivineStorm = 45743,
        GlyphOfTheAlabasterShield = 45744,
        GlyphOfDivinePlea = 45745,
        GlyphOfHolyShock = 45746,
        GlyphOfInquisition = 45747,
        GlyphOfProtectorOfTheInnocent = 66918,
        GlyphOfTheBattleHealer = 81956,
        GlyphOfMassExorcism = 83107,
        GlyphOfDivineShield = 104050,
        GlyphOfHandOfSacrifice = 104051
      },
      PaladinMinorGlyph = {
        PaladinMinorGlyphNone = 0,
        GlyphOfTheLuminousCharger = 41100,
        GlyphOfTheMountedKing = 43340,
        GlyphOfContemplation = 43365,
        GlyphOfWingedVengeance = 43366,
        GlyphOfSealOfBlood = 43368,
        GlyphOfFireFromTheHeavens = 43369,
        GlyphOfFocusedWrath = 80581,
        GlyphOfTheFallingAvenger = 80584,
        GlyphOfTheRighteousRetreat = 80585,
        GlyphOfBladedJudgment = 80586,
        GlyphOfTheExorcist = 104107,
        GlyphOfPillarOfLight = 104108
      },
      Blessings = {
        BlessingUnknown = 0,
        BlessingOfKings = 1,
        BlessingOfMight = 2
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
        ExpansionCata = 4,
        ExpansionMop = 5
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
        RepFactionAvengersOfHyjal = 1204,
        RepFactionGoldenLotus = 1269,
        RepFactionTheTillers = 1272,
        RepFactionShadoPan = 1270,
        RepFactionShadoPanAssault = 1435,
        RepFactionTheBrewmasters = 1351,
        RepFactionTheKlaxxi = 1337,
        RepFactionTheAugustCelestials = 1341,
        RepFactionTheAnglers = 1302,
        RepFactionEmperorShaohao = 1492,
        RepFactionSunreaverOnslaught = 1388,
        RepFactionKirinTorOffensive = 1387,
        RepFactionDominanceOffensive = 1375,
        RepFactionOrderOfTheCloudSerpent = 1271,
        RepFactionShangXisAcademy = 1216,
        RepFactionTheLorewalkers = 1345,
        RepFactionTheBlackPrince = 1359,
        RepFactionForestHozen = 1228,
        RepFactionPearlfinJinyu = 1242,
        RepFactionHozen = 1243,
        RepFactionOperationShieldwall = 1376
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
        registerSliceAndDice_SliceandDice = {
          sourceFile = "extern/wowsims-mop/sim/rogue/slice_and_dice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSliceAndDice",
          spellId = 5171,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(rogue.ComboPoints())
			},
		}]],
          Flags = "SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellSliceAndDice",
          RelatedSelfBuff = "rogue.SliceAndDiceAura",
          IgnoreHaste = "true",
          label = "Slice and Dice"
        },
        registerShadowstepCD_Shadowstep = {
          sourceFile = "extern/wowsims-mop/sim/rogue/shadowstep.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/shadowstep.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowstepCD",
          spellId = 36554,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Second * 24,
			},
		}]],
          cooldown = {
            raw = "time.Second * 24",
            seconds = 24
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellShadowstep",
          RelatedSelfBuff = "rogue.ShadowstepAura",
          IgnoreHaste = "true"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeThreatTransfer = {
          sourceFile = "extern/wowsims-mop/sim/rogue/tricks_of_the_trade.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/tricks_of_the_trade.go",
          registrationType = "RegisterSpell",
          functionName = "registerTricksOfTheTradeSpell",
          spellId = 59628,
          ClassSpellMask = "RogueSpellTricksOfTheTradeThreat"
        },
        registerTricksOfTheTradeSpell_TricksOfTheTradeApplication = {
          sourceFile = "extern/wowsims-mop/sim/rogue/tricks_of_the_trade.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/tricks_of_the_trade.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/vanish.go",
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
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "RogueSpellVanish",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerFanOfKnives_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/fan_of_knives.go",
          registrationType = "RegisterSpell",
          functionName = "registerFanOfKnives",
          spellId = 51723,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "RogueSpellFanOfKnives",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerFanOfKnives_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/fan_of_knives.go",
          registrationType = "RegisterSpell",
          functionName = "registerFanOfKnives",
          spellId = 51723,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagAoE",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerShadowBladesCD_ShadowBlades = {
          sourceFile = "extern/wowsims-mop/sim/rogue/shadow_blades.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowBladesCD",
          spellId = 121471,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Shadow Blades"
        },
        registerShadowBladesCD_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/shadow_blades.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBladesCD",
          spellId = 121471,
          cast = [[{
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "RogueSpellShadowBlades",
          RelatedSelfBuff = "rogue.ShadowBladesAura",
          IgnoreHaste = "true"
        },
        makeShadowBladeHit_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/shadow_blades.go",
          registrationType = "RegisterSpell",
          functionName = "makeShadowBladeHit",
          spellId = 121471,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "RogueSpellShadowBladesHit",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "procMask",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(true)",
          ThreatMultiplier = "1"
        },
        registerStealthAura_Stealth = {
          sourceFile = "extern/wowsims-mop/sim/rogue/stealth.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/garrote.go",
          registrationType = "RegisterSpell",
          functionName = "registerGarrote",
          spellId = 703,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellGarrote",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Garrote"
        },
        registerExposeArmorSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/expose_armor.go",
          registrationType = "RegisterSpell",
          functionName = "registerExposeArmorSpell",
          spellId = 8647,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
				// Omitting the GCDMin - does not appear affected by either Shadow Blades or Adrenaline Rush
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellExposeArmor",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerPreparationCD_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/preparation.go",
          registrationType = "RegisterSpell",
          functionName = "registerPreparationCD",
          spellId = 14185,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    rogue.NewTimer(),
				Duration: time.Minute * 5,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellPreparation",
          IgnoreHaste = "true"
        },
        registerCrimsonTempest_CrimsonTempest = {
          sourceFile = "extern/wowsims-mop/sim/rogue/crimson_tempest.go",
          registrationType = "RegisterSpell",
          functionName = "registerCrimsonTempest",
          spellId = 121411,
          Flags = "core.SpellFlagIgnoreTargetModifiers | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagPassiveSpell",
          ClassSpellMask = "RogueSpellCrimsonTempestDoT",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          label = "Crimson Tempest"
        },
        registerCrimsonTempest_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/crimson_tempest.go",
          registrationType = "RegisterSpell",
          functionName = "registerCrimsonTempest",
          spellId = 121411,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
				// Omitting the GCDMin - does not appear affected by either Shadow Blades or Adrenaline Rush
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(rogue.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellCrimsonTempest",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDeadlyPoisonSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 2818,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "RogueSpellDeadlyPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerDeadlyPoisonSpell_DeadlyPoison = {
          sourceFile = "extern/wowsims-mop/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeadlyPoisonSpell",
          spellId = 2818,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "RogueSpellDeadlyPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          label = "Deadly Poison"
        },
        registerWoundPoisonSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/poisons.go",
          registrationType = "RegisterSpell",
          functionName = "registerWoundPoisonSpell",
          spellId = 8680,
          ClassSpellMask = "RogueSpellWoundPoison",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRupture_Rupture = {
          sourceFile = "extern/wowsims-mop/sim/rogue/rupture.go",
          registrationType = "RegisterSpell",
          functionName = "registerRupture",
          spellId = 1943,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(rogue.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellRupture",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Rupture"
        },
        registerEviscerate_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/eviscerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerEviscerate",
          spellId = 2098,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(rogue.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellEviscerate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAmbushSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/ambush.go",
          registrationType = "RegisterSpell",
          functionName = "registerAmbushSpell",
          spellId = 8676,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellAmbush",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(rogue.HasDagger(core.MainHand)",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "rogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        ApplyTalents_Subterfuge = {
          sourceFile = "extern/wowsims-mop/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 108208,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Subterfuge"
        },
        ApplyTalents_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/talents.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyTalents",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 137619,
          cast = [[{
				IgnoreHaste: true,
				CD: core.Cooldown{
					Timer:    rogue.NewTimer(),
					Duration: time.Minute * 1,
				},
			}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "RogueSpellMarkedForDeath",
          IgnoreHaste = "true"
        },
        ApplyTalents_Anticipation = {
          sourceFile = "extern/wowsims-mop/sim/rogue/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 114015,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Anticipation"
        }
      },
      assassination = {
        registerVendetta_Vendetta = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/vendetta.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/vendetta.go",
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
          Flags = "core.SpellFlagAPL | core.SpellFlagMCD | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "rogue.RogueSpellVendetta",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerVenomousWounds_VenomousWoundsAura = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/venomous_wounds.go",
          registrationType = "RegisterAura",
          functionName = "registerVenomousWounds",
          label = "Venomous Wounds Aura"
        },
        registerVenomousWounds_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/venomous_wounds.go",
          registrationType = "RegisterSpell",
          functionName = "registerVenomousWounds",
          spellId = 79134,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "rogue.RogueSpellVenomousWounds",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "sinRogue.CritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerBlindsidePassive_Blindside = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerBlindsidePassive",
          spellId = 121153,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Blindside"
        },
        newMutilateHitSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "newMutilateHitSpell",
          spellId = 1329,
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagSealFate",
          ClassSpellMask = "rogue.RogueSpellMutilateHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "procMask",
          DamageMultiplier = "mutWeaponPercent",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "sinRogue.CritMultiplier(true)",
          ThreatMultiplier = "1"
        },
        registerMutilateSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/mutilate.go",
          registrationType = "RegisterSpell",
          functionName = "registerMutilateSpell",
          spellId = 1329,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellMutilate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerEnvenom_Envenom = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/envenom.go",
          registrationType = "RegisterAura",
          functionName = "registerEnvenom",
          spellId = 32645,
          label = "Envenom"
        },
        registerEnvenom_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/envenom.go",
          registrationType = "RegisterSpell",
          functionName = "registerEnvenom",
          spellId = 32645,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				spell.SetMetricsSplit(asnRogue.ComboPoints())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagFinisher | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellEnvenom",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "asnRogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applySealFate_SealFate = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/sealfate.go",
          registrationType = "RegisterAura",
          functionName = "applySealFate",
          label = "Seal Fate"
        },
        registerDispatch_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/assassination/dispatch.go",
          registrationType = "RegisterSpell",
          functionName = "registerDispatch",
          spellId = 111240,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellDispatch",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "weaponPercent",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "sinRogue.CritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      subtlety = {
        registerBackstabSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/backstab.go",
          registrationType = "RegisterSpell",
          functionName = "registerBackstabSpell",
          spellId = 53,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellBackstab",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "weaponDamage",
          CritMultiplier = "subRogue.CritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerMasterOfSubtletyCD_MasterofSubtlety = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/master_of_subtlety.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/premeditation.go",
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
        applyPassives_Executioner = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/passives.go",
          registrationType = "RegisterAura",
          functionName = "applyPassives",
          spellId = 76808,
          label = "Executioner"
        },
        registerHemorrhageSpell_HemorrhageDoT = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 16511,
          Flags = "core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "subRogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          label = "Hemorrhage DoT"
        },
        registerHemorrhageSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/hemorrhage.go",
          registrationType = "RegisterSpell",
          functionName = "registerHemorrhageSpell",
          spellId = 16511,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 700,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellHemorrhage",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "core.TernaryFloat64(subRogue.HasDagger(core.MainHand)",
          CritMultiplier = "subRogue.CritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerShadowDanceCD_ShadowDance = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/shadow_dance.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowDanceCD",
          spellId = 51713,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Shadow Dance"
        },
        registerShadowDanceCD_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/shadow_dance.go",
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "rogue.RogueSpellShadowDance",
          RelatedSelfBuff = "subRogue.ShadowDanceAura",
          IgnoreHaste = "true"
        },
        registerHonorAmongThieves_HonorAmongThievesComboPointAura = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/honor_among_thieves.go",
          registrationType = "RegisterAura",
          functionName = "registerHonorAmongThieves",
          spellId = 51701,
          label = "Honor Among Thieves Combo Point Aura"
        },
        registerSanguinaryVein_SanguinaryVeinDebuff = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/sanguinary_vein.go",
          registrationType = "RegisterAura",
          functionName = "registerSanguinaryVein",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sanguinary Vein Debuff"
        },
        registerSanguinaryVein_SanguinaryVeinTalent = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/sanguinary_vein.go",
          registrationType = "RegisterAura",
          functionName = "registerSanguinaryVein",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Sanguinary Vein Talent"
        },
        applyFindWeakness_FindWeakness = {
          sourceFile = "extern/wowsims-mop/sim/rogue/subtlety/find_weakness.go",
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
        registerSinisterStrikeSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/sinister_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerSinisterStrikeSpell",
          spellId = 1752,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | rogue.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "rogue.RogueSpellSinisterStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "wepDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "comRogue.CritMultiplier(true)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBanditsGuile_ShallowInsight = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84745,
          label = "Shallow Insight",
          loopIndex = 0
        },
        registerBanditsGuile_ModerateInsight = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84746,
          label = "Moderate Insight",
          loopIndex = 1
        },
        registerBanditsGuile_DeepInsight = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/bandits_guile.go",
          registrationType = "RegisterAura",
          functionName = "registerBanditsGuile",
          spellId = 84747,
          label = "Deep Insight",
          loopIndex = 2
        },
        registerBanditsGuile_BanditsGuileTracker = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/bandits_guile.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/mastery.go",
          registrationType = "RegisterSpell",
          functionName = "applyMastery",
          spellId = 86392,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "rogue.RogueSpellMainGauche",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.2",
          DamageMultiplierAdditive = "1.0",
          CritMultiplier = "comRogue.CritMultiplier(false)",
          ThreatMultiplier = "1.0"
        },
        applyCombatPotency_CombatPotency = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/combat_potency.go",
          registrationType = "RegisterAura",
          functionName = "applyCombatPotency",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Combat Potency"
        },
        registerRevealingStrike_RevealingStrike = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/revealing_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerRevealingStrike",
          spellId = 84617,
          auraDuration = {
            raw = "baseDuration",
            seconds = nil
          },
          label = "Revealing Strike"
        },
        registerRevealingStrike_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/revealing_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRevealingStrike",
          spellId = 84617,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:    time.Second,
				GCDMin: time.Millisecond * 500,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | rogue.SpellFlagBuilder",
          ClassSpellMask = "rogue.RogueSpellRevealingStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "wepDamage",
          CritMultiplier = "comRogue.CritMultiplier(false)",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBladeFlurry_1 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/blade_flurry.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladeFlurry",
          spellId = 22482,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagIgnoreArmor",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerBladeFlurry_BladeFlurry = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/blade_flurry.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/blade_flurry.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "rogue.RogueSpellKillingSpreeHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "comRogue.CritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeCD_2 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "rogue.RogueSpellKillingSpreeHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.75",
          CritMultiplier = "comRogue.CritMultiplier(false)",
          ThreatMultiplier = "1"
        },
        registerKillingSpreeCD_KillingSpree = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/killing_spree.go",
          registrationType = "RegisterAura",
          functionName = "registerKillingSpreeCD",
          spellId = 51690,
          auraDuration = {
            raw = "time.Second*3 + 1",
            seconds = nil
          },
          label = "Killing Spree"
        },
        registerKillingSpreeCD_4 = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/killing_spree.go",
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "rogue.RogueSpellKillingSpree",
          IgnoreHaste = "true"
        },
        registerAdrenalineRushCD_AdrenalineRush = {
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/adrenaline_rush.go",
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
          sourceFile = "extern/wowsims-mop/sim/rogue/combat/adrenaline_rush.go",
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
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "rogue.RogueSpellAdrenalineRush",
          RelatedSelfBuff = "comRogue.AdrenalineRushAura",
          IgnoreHaste = "true"
        }
      },
      druid = {
        registerBarkskinCD_Barkskin = {
          sourceFile = "extern/wowsims-mop/sim/druid/barkskin.go",
          registrationType = "RegisterAura",
          functionName = "registerBarkskinCD",
          spellId = 22812,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Barkskin"
        },
        registerTigersFurySpell_TigersFuryAura = {
          sourceFile = "extern/wowsims-mop/sim/druid/_tigers_fury.go",
          registrationType = "RegisterAura",
          functionName = "registerTigersFurySpell",
          spellId = 5217,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Tiger's Fury Aura"
        },
        RegisterCatFormAura_CatForm = {
          sourceFile = "extern/wowsims-mop/sim/druid/forms.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/forms.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/forms.go",
          registrationType = "RegisterAura",
          functionName = "applyMoonkinForm",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Moonkin Form"
        },
        registerMoonfireDoTSpell_Moonfire = {
          sourceFile = "extern/wowsims-mop/sim/druid/moonfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerMoonfireDoTSpell",
          spellId = 8921,
          Flags = "SpellFlagOmenTrigger | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DruidSpellMoonfireDoT",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "druid.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Moonfire"
        },
        registerPulverizeSpell_Pulverize = {
          sourceFile = "extern/wowsims-mop/sim/druid/_pulverize.go",
          registrationType = "RegisterAura",
          functionName = "registerPulverizeSpell",
          spellId = 80951,
          auraDuration = {
            raw = "core.DurationFromSeconds(10.0 + 4.0*float64(druid.Talents.EndlessCarnage))",
            seconds = nil
          },
          label = "Pulverize"
        },
        registerSavageRoarSpell_SavageRoarAura = {
          sourceFile = "extern/wowsims-mop/sim/druid/_savage_roar.go",
          registrationType = "RegisterAura",
          functionName = "registerSavageRoarSpell",
          spellId = 52610,
          auraDuration = {
            raw = "druid.SavageRoarDurationTable[5]",
            seconds = nil
          },
          label = "Savage Roar Aura"
        },
        registerFireseedSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/druid/burning_treant.go",
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
          CritMultiplier = "treant.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        ApplyPrimalFury_PrimalFury = {
          sourceFile = "extern/wowsims-mop/sim/druid/shared_feral_passives.go",
          registrationType = "RegisterAura",
          functionName = "ApplyPrimalFury",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Primal Fury"
        },
        ApplyLeaderOfThePack_ImprovedLeaderofthePack = {
          sourceFile = "extern/wowsims-mop/sim/druid/shared_feral_passives.go",
          registrationType = "RegisterAura",
          functionName = "ApplyLeaderOfThePack",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Leader of the Pack"
        },
        registerBerserkCD_BerserkCat = {
          sourceFile = "extern/wowsims-mop/sim/druid/berserk.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkCD",
          spellId = 106951,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Berserk (Cat)"
        },
        registerBerserkCD_BerserkBear = {
          sourceFile = "extern/wowsims-mop/sim/druid/berserk.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkCD",
          spellId = 50334,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Berserk (Bear)"
        },
        RegisterEclipseAuras_EclipseLunar = {
          sourceFile = "extern/wowsims-mop/sim/druid/_eclipse.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/_eclipse.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/_eclipse.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEclipseEnergyGainAura",
          spellId = 89265,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eclipse Energy"
        },
        registerProwlSpell_Prowl = {
          sourceFile = "extern/wowsims-mop/sim/druid/prowl.go",
          registrationType = "RegisterAura",
          functionName = "registerProwlSpell",
          spellId = 5215,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Prowl"
        },
        registerWildMushrooms_WildMushroomStacks = {
          sourceFile = "extern/wowsims-mop/sim/druid/wild_mushrooms.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/sunfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerSunfireDoTSpell",
          spellId = 93402,
          Flags = "SpellFlagOmenTrigger | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DruidSpellSunfireDoT",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "druid.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Sunfire"
        },
        ApplyGlyphs_GlyphofStarsurge = {
          sourceFile = "extern/wowsims-mop/sim/druid/_glyphs.go",
          registrationType = "RegisterAura",
          functionName = "ApplyGlyphs",
          spellId = 62971,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Glyph of Starsurge"
        },
        registerMightOfUrsocCD_MightofUrsoc = {
          sourceFile = "extern/wowsims-mop/sim/druid/might_of_ursoc.go",
          registrationType = "RegisterAura",
          functionName = "registerMightOfUrsocCD",
          spellId = 106922,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Might of Ursoc"
        },
        registerSurvivalInstinctsCD_SurvivalInstincts = {
          sourceFile = "extern/wowsims-mop/sim/druid/survival_instincts.go",
          registrationType = "RegisterAura",
          functionName = "registerSurvivalInstinctsCD",
          spellId = 61336,
          auraDuration = {
            raw = "core.TernaryDuration(isGlyphed",
            seconds = nil
          },
          label = "Survival Instincts"
        }
      },
      guardian = {
        registerSavageDefenseSpell_SavageDefense = {
          sourceFile = "extern/wowsims-mop/sim/druid/guardian/savage_defense.go",
          registrationType = "RegisterAura",
          functionName = "registerSavageDefenseSpell",
          spellId = 132402,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Savage Defense"
        },
        registerEnrageSpell_Enrage = {
          sourceFile = "extern/wowsims-mop/sim/druid/guardian/enrage.go",
          registrationType = "RegisterAura",
          functionName = "registerEnrageSpell",
          spellId = 5229,
          auraDuration = {
            raw = "10 * time.Second + 1",
            seconds = nil
          },
          label = "Enrage"
        },
        registerToothAndClawPassive_ToothandClaw = {
          sourceFile = "extern/wowsims-mop/sim/druid/guardian/tooth_and_claw.go",
          registrationType = "RegisterAura",
          functionName = "registerToothAndClawPassive",
          spellId = 135286,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Tooth and Claw"
        },
        registerIncarnation_IncarnationSonofUrsoc = {
          sourceFile = "extern/wowsims-mop/sim/druid/guardian/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerIncarnation",
          spellId = 102558,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Incarnation: Son of Ursoc"
        }
      },
      feral = {
        applyOmenOfClarity_Clearcasting = {
          sourceFile = "extern/wowsims-mop/sim/druid/feral/_omen_of_clarity.go",
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
          sourceFile = "extern/wowsims-mop/sim/druid/feral/_omen_of_clarity.go",
          registrationType = "RegisterAura",
          functionName = "applyOmenOfClarity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Omen of Clarity"
        }
      },
      balance = {
        ApplyTalents_Moonfury = {
          sourceFile = "extern/wowsims-mop/sim/druid/balance/balance.go",
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
        registerDeathAndDecay_DeathandDecay = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_and_decay.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathAndDecay",
          spellId = 43265,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
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
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathAndDecay",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Death and Decay"
        },
        registerFirstHitDamageAura_FirstHitPenaltyBypass = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/rune_weapon_pet.go",
          registrationType = "RegisterAura",
          functionName = "registerFirstHitDamageAura",
          auraDuration = {
            raw = "core.SpellBatchWindow",
            seconds = nil
          },
          label = "First Hit Penalty Bypass"
        },
        registerPlagueStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerPlagueStrike",
          spellId = 45462,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPlagueStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerOffHandPlagueStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerOffHandPlagueStrike",
          spellId = 45462,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellPlagueStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwPlagueStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/plague_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwPlagueStrike",
          spellId = 45462,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        registerEmpowerRuneWeapon_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/empower_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerEmpowerRuneWeapon",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 47568,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagReadinessTrinket"
        },
        registerPestilence_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/pestilence.go",
          registrationType = "RegisterSpell",
          functionName = "registerPestilence",
          spellId = 50842,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPestilence",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0",
          ThreatMultiplier = "0"
        },
        registerDrwPestilence_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/pestilence.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwPestilence",
          spellId = 50842,
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerArmyOfTheDead_ArmyoftheDead = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/army_of_the_dead.go",
          registrationType = "RegisterAura",
          functionName = "registerArmyOfTheDead",
          spellId = 42650,
          auraDuration = {
            raw = "time.Millisecond * 500 * 8",
            seconds = nil
          },
          label = "Army of the Dead"
        },
        registerArmyOfTheDead_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/army_of_the_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmyOfTheDead",
          spellId = 42650,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "DeathKnightSpellArmyOfTheDead",
          RelatedSelfBuff = "aotdAura"
        },
        registerIceboundFortitude_IceboundFortitude = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/icebound_fortitude.go",
          registrationType = "RegisterAura",
          functionName = "registerIceboundFortitude",
          spellId = 48792,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Icebound Fortitude"
        },
        registerIceboundFortitude_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/icebound_fortitude.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceboundFortitude",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 48792,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "DeathKnightSpellIceboundFortitude",
          RelatedSelfBuff = "iceBoundFortituteAura"
        },
        registerDeathStrike_DeathStrikeDamageTaken = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_strike.go",
          registrationType = "RegisterAura",
          functionName = "registerDeathStrike",
          label = "Death Strike Damage Taken"
        },
        registerDeathStrike_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathStrike",
          spellId = 45470,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellDeathStrikeHeal",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "0"
        },
        registerDeathStrike_3 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathStrike",
          spellId = 49998,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.85",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerOffHandDeathStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerOffHandDeathStrike",
          spellId = 49998,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellDeathStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.85",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwDeathStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathStrike",
          spellId = 49998,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        Initialize_BloodGorged = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 81277,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blood Gorged"
        },
        Initialize_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 81280,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "bloodworm.dkOwner.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        Initialize_3 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/bloodworm_pet.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 81280,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "bloodworm.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerGlyphOfDancingRuneWeapon_GlyphofDancingRuneWeapon = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDancingRuneWeapon",
          spellId = 63330,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Glyph of Dancing Rune Weapon"
        },
        registerGlyphOfIceboundFortitude_GlyphofIceboundFortitude = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfIceboundFortitude",
          spellId = 58673,
          label = "Glyph of Icebound Fortitude"
        },
        registerGlyphOfTheLoudHorn_GlyphoftheLoudHorn = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfTheLoudHorn",
          spellId = 146646,
          label = "Glyph of the Loud Horn"
        },
        registerIcyTouch_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyTouch",
          spellId = 45477,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellIcyTouch",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwIcyTouch_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/icy_touch.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwIcyTouch",
          spellId = 45477,
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerGargoyleStrikeSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/gargoyle_pet.go",
          registrationType = "RegisterSpell",
          functionName = "registerGargoyleStrikeSpell",
          spellId = 51963,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDMin,
				CastTime: time.Millisecond * 2000,
			},
		}]],
          SpellSchool = "core.SpellSchoolPlague",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "garg.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBloodPresence_BloodPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodPresence",
          spellId = 48263,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Blood Presence"
        },
        registerBloodPresence_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodPresence",
          spellId = 48263,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodPresence",
          RelatedSelfBuff = "presenceAura.Aura"
        },
        registerFrostPresence_FrostPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostPresence",
          spellId = 48266,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frost Presence"
        },
        registerFrostPresence_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostPresence",
          spellId = 48266,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellFrostPresence",
          RelatedSelfBuff = "presenceAura.Aura"
        },
        registerUnholyPresence_UnholyPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterAura",
          functionName = "registerUnholyPresence",
          spellId = 48265,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Unholy Presence"
        },
        registerUnholyPresence_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/presences.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyPresence",
          spellId = 48265,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellUnholyPresence",
          RelatedSelfBuff = "presenceAura.Aura"
        },
        registerDeathCoil_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathCoil",
          spellId = 47541,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagEncounterOnly",
          ClassSpellMask = "DeathKnightSpellDeathCoil",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDeathCoilHeal_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathCoilHeal",
          spellId = 47541,
          tag = 2,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagPrepullOnly | core.SpellFlagNoMetrics | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellDeathCoilHeal",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "3.5",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwDeathCoil_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/death_coil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathCoil",
          spellId = 47541,
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerOutbreak_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/outbreak.go",
          registrationType = "RegisterSpell",
          functionName = "registerOutbreak",
          spellId = 77575,
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "DeathKnightSpellOutbreak",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerDrwOutbreak_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/outbreak.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwOutbreak",
          spellId = 77575,
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellOutbreak",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerHornOfWinter_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/horn_of_winter.go",
          registrationType = "RegisterSpell",
          functionName = "registerHornOfWinter",
          spellId = 57330,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: 20 * time.Second,
			},
		}]],
          cooldown = {
            raw = "20 * time.Second",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellHornOfWinter"
        },
        registerRaiseDead_RaiseDead = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/raise_dead.go",
          registrationType = "RegisterSpell",
          functionName = "registerRaiseDead",
          spellId = 46584,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellRaiseDead",
          RelatedSelfBuff = "dk.RegisterAura(core.Aura{",
          label = "Raise Dead"
        },
        registerBloodBoil_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodBoil",
          spellId = 48721,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodBoil",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwBloodBoil_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood_boil.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwBloodBoil",
          spellId = 48721,
          Flags = "core.SpellFlagAoE",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerAntiMagicShell_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/anti_magic_shell.go",
          registrationType = "RegisterSpell",
          functionName = "registerAntiMagicShell",
          spellId = 48707,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 45,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing"
        },
        registerRunicPowerDecay_RunicPowerDecay = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/runic_power_decay.go",
          registrationType = "RegisterAura",
          functionName = "registerRunicPowerDecay",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Runic Power Decay"
        },
        registerSoulReaper_SoulReaper = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/soul_reaper.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulReaper",
          spellId = 114867,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "DeathKnightSpellSoulReaper",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.0",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0",
          label = "Soul Reaper"
        },
        registerSoulReaper_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/soul_reaper.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulReaper",
          spellId = 114867,
          tag = "tag",
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "DeathKnightSpellSoulReaper",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.3",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDrwSoulReaper_SoulReaper = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/soul_reaper.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwSoulReaper",
          spellId = 114867,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          label = "Soul Reaper"
        },
        registerDrwSoulReaper_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/soul_reaper.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwSoulReaper",
          spellId = 114866,
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        registerPlagueLeech_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerPlagueLeech",
          spellId = 123693,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    dk.NewTimer(),
				Duration: time.Second * 25,
			},
		}]],
          cooldown = {
            raw = "time.Second * 25",
            seconds = 25
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellPlagueLeech",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerUnholyBlight_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyBlight",
          spellId = 115994,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerUnholyBlight_UnholyBlight = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyBlight",
          spellId = 115989,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellUnholyBlight",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          label = "Unholy Blight"
        },
        registerLichborne_Lichborne = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLichborne",
          spellId = 49039,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellLichborne",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "dk.RegisterAura(core.Aura{",
          label = "Lichborne"
        },
        registerAntiMagicZone_AntiMagicZone = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerAntiMagicZone",
          spellId = 145629,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Anti-Magic Zone"
        },
        registerAntiMagicZone_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerAntiMagicZone",
          spellId = 51052,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellAntiMagicZone",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerPurgatory_Perdition = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPurgatory",
          spellId = 123981,
          auraDuration = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          label = "Perdition"
        },
        registerPurgatory_ShroudofPurgatory = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPurgatory",
          spellId = 116888,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Shroud of Purgatory"
        },
        registerDeathsAdvance_DeathsAdvance = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathsAdvance",
          spellId = 96268,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "dk.RegisterAura(core.Aura{",
          label = "Death's Advance"
        },
        registerDeathPact_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathPact",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 48743,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellDeathPact",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerDeathSiphon_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathSiphon",
          spellId = 116783,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.5",
          ThreatMultiplier = "1"
        },
        registerDeathSiphon_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeathSiphon",
          spellId = 108196,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellDeathSiphon",
          SpellSchool = "core.SpellSchoolShadowFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwDeathSiphon_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwDeathSiphon",
          spellId = 108196,
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadowFrost",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerConversion_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerConversion",
          spellId = 119980,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerConversion_Conversion = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerConversion",
          spellId = 119975,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Conversion"
        },
        registerConversion_3 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerConversion",
          spellId = 119975,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "DeathKnightSpellConversion",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "dk.ConversionAura"
        },
        registerBloodTap_BloodCharge = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodTap",
          spellId = 114851,
          auraDuration = {
            raw = "time.Second * 25",
            seconds = 25
          },
          label = "Blood Charge"
        },
        registerBloodTap_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodTap",
          spellId = 45529,
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "DeathKnightSpellBloodTap"
        },
        registerRunicEmpowerment_RunicEmpowerement = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRunicEmpowerment",
          spellId = 81229,
          label = "Runic Empowerement"
        },
        registerRunicCorruption_RunicCorruption = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRunicCorruption",
          spellId = 51460,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Runic Corruption"
        }
      },
      frost = {
        registerMightOfTheFrozenWastes_MightoftheFrozenWastes = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/might_of_the_frozen_wastes.go",
          registrationType = "RegisterAura",
          functionName = "registerMightOfTheFrozenWastes",
          spellId = 81333,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Might of the Frozen Wastes"
        },
        registerBloodOfTheNorth_BloodoftheNorth = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/blood_of_the_north.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodOfTheNorth",
          spellId = 54637,
          label = "Blood of the North"
        },
        registerHowlingBlast_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/howling_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerHowlingBlast",
          spellId = 49184,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellHowlingBlast",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMastery_FrozenHeart = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/mastery.go",
          registrationType = "RegisterAura",
          functionName = "registerMastery",
          spellId = 77514,
          label = "Frozen Heart"
        },
        registerRime_FreezingFog = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/rime.go",
          registrationType = "RegisterAura",
          functionName = "registerRime",
          spellId = 59052,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Freezing Fog"
        },
        registerIcyTalons_IcyTalons = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/icy_talons.go",
          registrationType = "RegisterAura",
          functionName = "registerIcyTalons",
          spellId = 50887,
          label = "Icy Talons"
        },
        registerImprovedFrostPresence_ImprovedFrostPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/improved_frost_presence.go",
          registrationType = "RegisterAura",
          functionName = "registerImprovedFrostPresence",
          spellId = 50385,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Frost Presence"
        },
        registerThreatOfThassarian_ThreatofThassarian = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/threat_of_thassarian.go",
          registrationType = "RegisterAura",
          functionName = "registerThreatOfThassarian",
          spellId = 66192,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Threat of Thassarian"
        },
        registerFrostStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/frost_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostStrike",
          spellId = 49143,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "death_knight.DeathKnightSpellFrostStrike",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.15",
          CritMultiplier = "fdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostStrike_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/frost_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostStrike",
          spellId = 49143,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellFrostStrike",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.15",
          CritMultiplier = "fdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerKillingMachine_KillingMachine = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/killing_machine.go",
          registrationType = "RegisterAura",
          functionName = "registerKillingMachine",
          spellId = 51124,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Killing Machine"
        },
        registerKillingMachine_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/killing_machine.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillingMachine",
          spellId = 51124,
          Flags = "core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
          ClassSpellMask = "death_knight.DeathKnightSpellKillingMachine",
          RelatedSelfBuff = "killingMachineAura"
        },
        registerPillarOfFrost_PillarofFrost = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/pillar_of_frost.go",
          registrationType = "RegisterAura",
          functionName = "registerPillarOfFrost",
          spellId = 51271,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Pillar of Frost"
        },
        registerPillarOfFrost_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/pillar_of_frost.go",
          registrationType = "RegisterSpell",
          functionName = "registerPillarOfFrost",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 51271,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    fdk.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellPillarOfFrost",
          SpellSchool = "core.SpellSchoolPhysical",
          RelatedSelfBuff = "fdk.PillarOfFrostAura"
        },
        registerBrittleBones_BrittleBones = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/brittle_bones.go",
          registrationType = "RegisterAura",
          functionName = "registerBrittleBones",
          spellId = 81328,
          label = "Brittle Bones"
        },
        registerObliterate_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/obliterate.go",
          registrationType = "RegisterSpell",
          functionName = "registerObliterate",
          spellId = 49020,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "death_knight.DeathKnightSpellObliterate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "2.5",
          CritMultiplier = "fdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerObliterate_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/frost/obliterate.go",
          registrationType = "RegisterSpell",
          functionName = "registerObliterate",
          spellId = 49020,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellObliterate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.5",
          CritMultiplier = "fdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMastery_MasteryIciclesWaterElemental = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/frost.go",
          registrationType = "RegisterAura",
          functionName = "registerMastery",
          label = "Mastery: Icicles - Water Elemental"
        },
        registerFingersOfFrost_FingersofFrost = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/fingers_of_frost.go",
          registrationType = "RegisterAura",
          functionName = "registerFingersOfFrost",
          spellId = 112965,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Fingers of Frost"
        },
        registerFrozenOrbSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/frozen_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrozenOrbSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 84714,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    frost.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellFrozenOrb",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerFrozenOrbTickSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/frozen_orb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrozenOrbTickSpell",
          spellId = 84721,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAoE",
          ClassSpellMask = "mage.MageSpellFrozenOrbTick",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "frozenOrb.mageOwner.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostboltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/frostbolt.go",
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
          ClassSpellMask = "mage.MageSpellFrostbolt",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "frostMage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBrainFreeze_BrainFreeze = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/brain_freeze.go",
          registrationType = "RegisterAura",
          functionName = "registerBrainFreeze",
          spellId = 44549,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Brain Freeze"
        },
        registerSummonWaterElementalSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonWaterElementalSpell",
          spellId = 31687,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL"
        },
        registerWaterboltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost/water_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "registerWaterboltSpell",
          spellId = 31707,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          ClassSpellMask = "mage.MageWaterElementalSpellWaterBolt",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * 1.2",
          CritMultiplier = "we.mageOwner.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      blood = {
        registerRiposte_Riposte = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/riposte.go",
          registrationType = "RegisterAura",
          functionName = "registerRiposte",
          spellId = 145677,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Riposte"
        },
        registerBoneShield_BoneShield = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/bone_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerBoneShield",
          spellId = 49222,
          auraDuration = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          label = "Bone Shield"
        },
        registerBoneShield_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/bone_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerBoneShield",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 49222,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bdk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellBoneShield",
          SpellSchool = "core.SpellSchoolShadow",
          RelatedSelfBuff = "bdk.BoneShieldAura"
        },
        registerCrimsonScourge_CrimsonScourge = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/crimson_scourge.go",
          registrationType = "RegisterAura",
          functionName = "registerCrimsonScourge",
          spellId = 81141,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Crimson Scourge"
        },
        registerBloodRites_BloodRites = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/blood_rites.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodRites",
          spellId = 50034,
          label = "Blood Rites"
        },
        registerVeteranOfTheThirdWar_VeteranoftheThirdWar = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/veteran_of_the_third_war.go",
          registrationType = "RegisterAura",
          functionName = "registerVeteranOfTheThirdWar",
          spellId = 50029,
          label = "Veteran of the Third War"
        },
        registerMastery_BloodShield = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/mastery.go",
          registrationType = "RegisterSpell",
          functionName = "registerMastery",
          spellId = 77535,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Blood Shield"
        },
        registerHotfixPassive_HotfixPassive = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/hotfix_passive.go",
          registrationType = "RegisterAura",
          functionName = "registerHotfixPassive",
          label = "Hotfix Passive"
        },
        registerDancingRuneWeapon_FlamingRuneWeapon = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/dancing_rune_weapon.go",
          registrationType = "RegisterAura",
          functionName = "registerDancingRuneWeapon",
          spellId = 101162,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Flaming Rune Weapon"
        },
        registerDancingRuneWeapon_DancingRuneWeapon = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/dancing_rune_weapon.go",
          registrationType = "RegisterAura",
          functionName = "registerDancingRuneWeapon",
          spellId = 81256,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Dancing Rune Weapon"
        },
        registerDancingRuneWeapon_3 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/dancing_rune_weapon.go",
          registrationType = "RegisterSpell",
          functionName = "registerDancingRuneWeapon",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 49028,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellDancingRuneWeapon",
          RelatedSelfBuff = "dancingRuneWeaponAura"
        },
        registerImprovedBloodPresence_ImprovedBloodPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/improved_blood_presence.go",
          registrationType = "RegisterAura",
          functionName = "registerImprovedBloodPresence",
          spellId = 50371,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Blood Presence"
        },
        registerVampiricBlood_VampiricBlood = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/vampiric_blood.go",
          registrationType = "RegisterAura",
          functionName = "registerVampiricBlood",
          spellId = 55233,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Vampiric Blood"
        },
        registerVampiricBlood_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/vampiric_blood.go",
          registrationType = "RegisterSpell",
          functionName = "registerVampiricBlood",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 55233,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bdk.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellVampiricBlood",
          SpellSchool = "core.SpellSchoolPhysical",
          RelatedSelfBuff = "vampiricBloodAura"
        },
        registerScarletFever_ScarletFever = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/scarlet_fever.go",
          registrationType = "RegisterAura",
          functionName = "registerScarletFever",
          spellId = 51160,
          label = "Scarlet Fever"
        },
        registerBloodParasite_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/blood_parasite.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodParasite",
          spellId = 50452,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerScentOfBlood_ScentofBlood = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/scent_of_blood.go",
          registrationType = "RegisterAura",
          functionName = "registerScentOfBlood",
          spellId = 50421,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Scent of Blood"
        },
        registerDarkCommand_DarkCommand = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/dark_command.go",
          registrationType = "RegisterAura",
          functionName = "registerDarkCommand",
          spellId = 56222,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Dark Command"
        },
        registerDarkCommand_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/dark_command.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarkCommand",
          spellId = 56222,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bdk.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellDarkCommand",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerHeartStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/heart_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeartStrike",
          spellId = 55050,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellHeartStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.05",
          CritMultiplier = "bdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwHeartStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/heart_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwHeartStrike",
          spellId = 55050,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial"
        },
        registerWillOfTheNecropolis_WillofTheNecropolisDamageReduction = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/will_of_the_necropolis.go",
          registrationType = "RegisterAura",
          functionName = "registerWillOfTheNecropolis",
          spellId = 81162,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Will of The Necropolis Damage Reduction"
        },
        registerWillOfTheNecropolis_WillofTheNecropolisRuneTapCost = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/will_of_the_necropolis.go",
          registrationType = "RegisterAura",
          functionName = "registerWillOfTheNecropolis",
          spellId = 96171,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Will of The Necropolis Rune Tap Cost"
        },
        registerRuneStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneStrike",
          spellId = 56815,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellRuneStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMH",
          DamageMultiplier = "2",
          CritMultiplier = "bdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrwRuneStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/rune_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrwRuneStrike",
          spellId = 62036,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMH"
        },
        registerRuneTap_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/rune_tap.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneTap",
          spellId = 48982,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bdk.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          ClassSpellMask = "death_knight.DeathKnightSpellRuneTap",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerSanguineFortitude_SanguineFortitude = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/blood/sanguine_fortitude.go",
          registrationType = "RegisterAura",
          functionName = "registerSanguineFortitude",
          spellId = 81127,
          label = "Sanguine Fortitude"
        }
      },
      unholy = {
        registerShadowInfusion_ShadowInfusion = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/shadow_infusion.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowInfusion",
          spellId = 91342,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Shadow Infusion"
        },
        registerReaping_Reaping = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/reaping.go",
          registrationType = "RegisterAura",
          functionName = "registerReaping",
          spellId = 56835,
          label = "Reaping"
        },
        registerBloodStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/blood_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodStrike",
          spellId = 45902,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellBloodStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.4",
          CritMultiplier = "uhdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerDarkTransformation_DarkTransformation = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/dark_transformation.go",
          registrationType = "RegisterAura",
          functionName = "registerDarkTransformation",
          spellId = 63560,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Dark Transformation"
        },
        registerDarkTransformation_3 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/dark_transformation.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarkTransformation",
          spellId = 63560,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellDarkTransformation",
          SpellSchool = "core.SpellSchoolShadow",
          IgnoreHaste = "true"
        },
        registerMasterOfGhouls_MasterofGhouls = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/master_of_ghouls.go",
          registrationType = "RegisterAura",
          functionName = "registerMasterOfGhouls",
          spellId = 52143,
          label = "Master of Ghouls"
        },
        registerMastery_Dreadblade = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/mastery.go",
          registrationType = "RegisterAura",
          functionName = "registerMastery",
          spellId = 77515,
          label = "Dreadblade"
        },
        registerFesteringStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/festering_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerFesteringStrike",
          spellId = 85948,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellFesteringStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.0",
          CritMultiplier = "uhdk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerImprovedUnholyPresence_ImprovedUnholyPresence = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/improved_unholy_presence.go",
          registrationType = "RegisterAura",
          functionName = "registerImprovedUnholyPresence",
          spellId = 50392,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Improved Unholy Presence"
        },
        registerUnholyMight_UnholyMight = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/unholy_might.go",
          registrationType = "RegisterAura",
          functionName = "registerUnholyMight",
          spellId = 91107,
          label = "Unholy Might"
        },
        registerSummonGargoyle_SummonGargoyle = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/summon_gargoyle.go",
          registrationType = "RegisterSpell",
          functionName = "registerSummonGargoyle",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 49206,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    uhdk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellSummonGargoyle",
          RelatedSelfBuff = "uhdk.RegisterAura(core.Aura{",
          label = "Summon Gargoyle"
        },
        registerUnholyFrenzy_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/unholy_frenzy.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnholyFrenzy",
          spellId = 49016,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    uhdk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "death_knight.DeathKnightSpellUnholyFrenzy"
        },
        registerScourgeStrikeShadowDamage_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrikeShadowDamage",
          spellId = 55090,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers",
          ClassSpellMask = "death_knight.DeathKnightSpellScourgeStrikeShadow",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerScourgeStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/scourge_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerScourgeStrike",
          spellId = 55090,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "death_knight.DeathKnightSpellScourgeStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.35",
          CritMultiplier = "dk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerEbonPlaguebringer_EbonPlaguebringer = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/ebon_plaguebringer.go",
          registrationType = "RegisterAura",
          functionName = "registerEbonPlaguebringer",
          spellId = 51160,
          label = "Ebon Plaguebringer"
        },
        registerSuddenDoom_SuddenDoom = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/sudden_doom.go",
          registrationType = "RegisterAura",
          functionName = "registerSuddenDoom",
          spellId = 81340,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Sudden Doom"
        },
        registerSuddenDoom_2 = {
          sourceFile = "extern/wowsims-mop/sim/death_knight/unholy/sudden_doom.go",
          registrationType = "RegisterSpell",
          functionName = "registerSuddenDoom",
          spellId = 81340,
          Flags = "core.SpellFlagNoLogs | core.SpellFlagNoMetrics",
          ClassSpellMask = "death_knight.DeathKnightSpellSuddenDoom",
          RelatedSelfBuff = "suddenDoomAura"
        }
      },
      dragonsoul = {
        registerDevastate_1 = {
          sourceFile = "extern/wowsims-mop/sim/encounters/dragonsoul/blackhorn_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/dragonsoul/blackhorn_ai.go",
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
          Flags = "core.SpellFlagIgnoreArmor | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerVengeance_Vengeance = {
          sourceFile = "extern/wowsims-mop/sim/encounters/dragonsoul/blackhorn_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/magmaw_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/magmaw_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/magmaw_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/magmaw_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/magmaw_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/nefarian_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/nefarian_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/bwd/nefarian_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/bethtilac_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
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
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99351,
          Flags = "core.SpellFlagMeleeMetrics",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        },
        registerBlades_6 = {
          sourceFile = "extern/wowsims-mop/sim/encounters/firelands/baleroc_ai.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlades",
          spellId = 99353,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagIgnoreArmor",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        }
      },
      shaman = {
        registerAncestralHealingSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRiptideSpell_Riptide = {
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Riptide"
        },
        registerHealingWaveSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEarthShieldSpell_EarthShield = {
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/_heals.go",
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
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSpiritwalkersGraceSpell_SpiritwalkersGrace = {
          sourceFile = "extern/wowsims-mop/sim/shaman/spiritwalkers_grace.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/spiritwalkers_grace.go",
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskSpiritwalkersGrace",
          SpellSchool = "core.SpellSchoolNature",
          RelatedSelfBuff = "spiritwalkersGraceAura"
        },
        registerHealingStreamTotemSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingStreamTotemSpell",
          spellId = 5394,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerFlameShockSpell_FlameShock = {
          sourceFile = "extern/wowsims-mop/sim/shaman/shocks.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlameShockSpell",
          spellId = 8050,
          Flags = "config.Flags & ^core.SpellFlagAPL & ^SpellFlagShamanSpell | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFlameShockDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "FlameShock"
        },
        registerAscendanceSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/ascendance.go",
          registrationType = "RegisterSpell",
          functionName = "registerAscendanceSpell",
          spellId = 114089,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete | core.SpellFlagReadinessTrinket",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeMHAuto",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerAscendanceSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/ascendance.go",
          registrationType = "RegisterSpell",
          functionName = "registerAscendanceSpell",
          spellId = 114089,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskMeleeOHAuto",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerAscendanceSpell_Ascendance = {
          sourceFile = "extern/wowsims-mop/sim/shaman/ascendance.go",
          registrationType = "RegisterAura",
          functionName = "registerAscendanceSpell",
          spellId = 114049,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Ascendance"
        },
        registerAscendanceSpell_4 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/ascendance.go",
          registrationType = "RegisterSpell",
          functionName = "registerAscendanceSpell",
          spellId = 114049,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskAscendance",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerSearingTotemSpell_SearingTotem = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerSearingTotemSpell",
          spellId = 3599,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskSearingTotem",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          label = "SearingTotem"
        },
        registerMagmaTotemSpell_MagmaTotem = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_totems.go",
          registrationType = "RegisterSpell",
          functionName = "registerMagmaTotemSpell",
          spellId = 8190,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskMagmaTotem",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          label = "MagmaTotem"
        },
        registerFireBlast_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireBlast",
          spellId = 57984,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireNova_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNova",
          spellId = 117588,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAoE",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerImmolate_Immolate = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolate",
          spellId = 118297,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fireElemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Immolate"
        },
        registerEmpower_Empower = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerEmpower",
          spellId = 118350,
          cast = [[{
			CD: core.Cooldown{
				Timer:    fireElemental.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagChanneled",
          SpellSchool = "core.SpellSchoolFire",
          label = "Empower"
        },
        registerPulverize_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/earth_elemental_spells.go",
          registrationType = "RegisterSpell",
          functionName = "registerPulverize",
          spellId = 118345,
          cast = [[{
			CD: core.Cooldown{
				Timer:    earthElemental.NewTimer(),
				Duration: time.Second * 40,
			},
		}]],
          cooldown = {
            raw = "time.Second * 40",
            seconds = 40
          },
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.5",
          CritMultiplier = "earthElemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEarthElementalTotem_EarthElementalTotem = {
          sourceFile = "extern/wowsims-mop/sim/shaman/earth_elemental_totem.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/earth_elemental_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthElementalTotem",
          spellId = 2062,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 5,
			},
			SharedCD: core.Cooldown{
				Timer:    shaman.GetOrInitTimer(&shaman.ElementalSharedCDTimer),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskEarthElementalTotem"
        },
        RegisterHealingSpells_TidalWaveProc = {
          sourceFile = "extern/wowsims-mop/sim/shaman/shaman.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashFlame",
          spellId = 73683,
          Flags = "SpellFlagFocusable | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskUnleashFlame",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerUnleashFrost_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashFrost",
          spellId = 73682,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskUnleashFrost",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerUnleashWind_UnleashWind = {
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashWind",
          spellId = 73681,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "0.9",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerUnleashLife_UnleashLife = {
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnleashLife",
          spellId = 73685,
          Flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerUnleashElements_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/unleash_elements.go",
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
          Flags = "SpellFlagShamanSpell | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskUnleashElements"
        },
        registerBloodlustCD_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/bloodlust.go",
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskBloodlust"
        },
        newFlametongueImbueSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFlametongueImbueSpell",
          spellId = 8024,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFlametongueWeapon",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamageProc",
          DamageMultiplier = "weapon.SwingSpeed / 2.6",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        FrostbrandDebuffAura_FrostbrandAttack = {
          sourceFile = "extern/wowsims-mop/sim/shaman/weapon_imbues.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterSpell",
          functionName = "newFrostbrandImbueSpell",
          spellId = 8033,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFrostbrandWeapon",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        newEarthlivingImbueSpell_Earthliving = {
          sourceFile = "extern/wowsims-mop/sim/shaman/weapon_imbues.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/weapon_imbues.go",
          registrationType = "RegisterAura",
          functionName = "RegisterEarthlivingImbue",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Earthliving Imbue"
        },
        registerLightningShieldSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/lightning_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightningShieldSpell",
          spellId = 26364,
          ClassSpellMask = "SpellMaskLightningShield",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLightningShieldSpell_LightningShield = {
          sourceFile = "extern/wowsims-mop/sim/shaman/lightning_shield.go",
          registrationType = "RegisterAura",
          functionName = "registerLightningShieldSpell",
          spellId = 324,
          auraDuration = {
            raw = "time.Minute * 60",
            seconds = 3600
          },
          label = "Lightning Shield"
        },
        registerLightningShieldSpell_3 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/lightning_shield.go",
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
        ApplyEnhancementTalents_FlurryProc = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_enhancement.go",
          registrationType = "RegisterAura",
          functionName = "ApplyEnhancementTalents",
          spellId = 16278,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Flurry Proc"
        },
        ApplyEnhancementTalents_SearingFlames = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_enhancement.go",
          registrationType = "RegisterAura",
          functionName = "ApplyEnhancementTalents",
          spellId = 77661,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Searing Flames"
        },
        ApplyEnhancementTalents_MaelstromWeaponProc = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_enhancement.go",
          registrationType = "RegisterAura",
          functionName = "ApplyEnhancementTalents",
          spellId = 51530,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "MaelstromWeapon Proc"
        },
        registerFireElementalTotem_FireElementalTotem = {
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_totem.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/fire_elemental_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireElementalTotem",
          spellId = 2894,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Minute * 5,
			},
			SharedCD: core.Cooldown{
				Timer:    shaman.GetOrInitTimer(&shaman.ElementalSharedCDTimer),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskFireElementalTotem",
          RelatedSelfBuff = "fireElementalAura"
        },
        registerStormlashCD_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/stormlash_totem.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormlashCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 120668,
          tag = "shaman.Index",
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: core.StormLashCD,
			},
		}]],
          cooldown = {
            raw = "core.StormLashCD",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskStormlashTotem"
        },
        ApplyElementalTalents_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_elemental.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyElementalTalents",
          spellId = 88767,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			ModifyCast: func(s1 *core.Simulation, spell *core.Spell, c *core.Cast) {
				spell.SetMetricsSplit(shaman.LightningShieldAura.GetStacks() - 2)
			},
		}]],
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskFulmination",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          CritMultiplier = "shaman.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        ApplyElementalTalents_Clearcasting = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_elemental.go",
          registrationType = "RegisterAura",
          functionName = "ApplyElementalTalents",
          spellId = 16246,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Clearcasting"
        },
        ApplyElementalTalents_LavaSurge = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_elemental.go",
          registrationType = "RegisterAura",
          functionName = "ApplyElementalTalents",
          spellId = 77762,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Lava Surge"
        },
        ApplyElementalTalents_LavaSurgeProcAura = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents_elemental.go",
          registrationType = "RegisterAura",
          functionName = "ApplyElementalTalents",
          label = "Lava Surge Proc Aura"
        },
        ApplyElementalMastery_ElementalMastery = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyElementalMastery",
          spellId = 16166,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Elemental Mastery"
        },
        ApplyElementalMastery_2 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyElementalMastery",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 16166,
          cast = [[{
			CD: core.Cooldown{
				Timer:    shaman.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          ClassSpellMask = "SpellMaskElementalMastery"
        },
        ApplyAncestralSwiftness_AncestralSwiftnessPassive = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyAncestralSwiftness",
          label = "Ancestral Swiftness Passive"
        },
        ApplyAncestralSwiftness_Ancestralswiftness = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyAncestralSwiftness",
          spellId = 16188,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Ancestral swiftness"
        },
        ApplyAncestralSwiftness_3 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterSpell",
          functionName = "ApplyAncestralSwiftness",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 16188,
          cast = [[{
			CD: core.Cooldown{
				Timer:    asCdTimer,
				Duration: asCd,
			},
		}]],
          cooldown = {
            raw = "asCd",
            seconds = nil
          },
          Flags = "core.SpellFlagNoOnCastComplete"
        },
        ApplyEchoOfTheElements_EchoofTheElementsDummy = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyEchoOfTheElements",
          Flags = "spell.Flags & ^core.SpellFlagAPL | core.SpellFlagNoOnCastComplete | SpellFlagIsEcho",
          ClassSpellMask = "spell.ClassSpellMask",
          SpellSchool = "spell.SpellSchool",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "core.TernaryFloat64(spell.Tag == CastTagLightningOverload",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "spell.Unit.Env.Raid.GetPlayerFromUnit(spell.Unit).GetCharacter().DefaultCritMultiplier()",
          label = "Echo of The Elements Dummy"
        },
        ApplyUnleashedFury_UnleashedFuryFT = {
          sourceFile = "extern/wowsims-mop/sim/shaman/talents.go",
          registrationType = "RegisterAura",
          functionName = "ApplyUnleashedFury",
          spellId = 118470,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Unleashed Fury FT-"
        }
      },
      elemental = {
        registerEarthquakeSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/elemental/earthquake.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthquakeSpell",
          spellId = 77478,
          Flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAoE | shaman.SpellFlagFocusable | core.SpellFlagIgnoreArmor",
          ClassSpellMask = "shaman.SpellMaskEarthquake",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          CritMultiplier = "elemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerEarthquakeSpell_Earthquake = {
          sourceFile = "extern/wowsims-mop/sim/shaman/elemental/earthquake.go",
          registrationType = "RegisterSpell",
          functionName = "registerEarthquakeSpell",
          spellId = 77478,
          cast = [[{
			DefaultCast: core.Cast{
				CastTime: 2500 * time.Millisecond,
				GCD:      core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    elemental.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAPL",
          label = "Earthquake"
        },
        registerShamanisticRageSpell_ShamanisticRage = {
          sourceFile = "extern/wowsims-mop/sim/shaman/elemental/shamanistic_rage.go",
          registrationType = "RegisterAura",
          functionName = "registerShamanisticRageSpell",
          spellId = 30823,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Shamanistic Rage"
        },
        registerShamanisticRageSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/elemental/shamanistic_rage.go",
          registrationType = "RegisterSpell",
          functionName = "registerShamanisticRageSpell",
          majorCooldown = {
            type = "core.CooldownTypeMana",
            priority = nil
          },
          spellId = 30823,
          cast = [[{
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    ele.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "shaman.SpellMaskShamanisticRage",
          RelatedSelfBuff = "srAura",
          IgnoreHaste = "true"
        },
        registerThunderstormSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/elemental/thunderstorm.go",
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
          Flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAoE | core.SpellFlagAPL | shaman.SpellFlagFocusable",
          ClassSpellMask = "shaman.SpellMaskThunderstorm",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "elemental.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      enhancement = {
        registerLavaLashSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/lavalash.go",
          registrationType = "RegisterSpell",
          functionName = "registerLavaLashSpell",
          spellId = 60103,
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
          DamageMultiplierAdditive = "1",
          CritMultiplier = "enh.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerFeralSpirit_FeralSpirit = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/feral_spirit.go",
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
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/feral_spirit.go",
          registrationType = "RegisterSpell",
          functionName = "registerFeralSpirit",
          spellId = 51533,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    enh.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "shaman.SpellMaskFeralSpirit",
          IgnoreHaste = "true"
        },
        Initialize_MasteryEnhancedElements = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/enhancement.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 77223,
          label = "Mastery: Enhanced Elements"
        },
        registerSpiritBite_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/spirit_wolves.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpiritBite",
          spellId = 58859,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    spiritWolf.NewTimer(),
				Duration: time.Millisecond * 7300,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 7300",
            seconds = 7
          },
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "spiritWolf.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        StormstrikeDebuffAura_Stormstrike = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/stormstrike.go",
          registrationType = "RegisterAura",
          functionName = "StormstrikeDebuffAura",
          spellId = 17364,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Stormstrike-"
        },
        registerFireNovaSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/firenova.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNovaSpell",
          spellId = 1535,
          Flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAoE",
          ClassSpellMask = "shaman.SpellMaskFireNova",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerFireNovaSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/shaman/enhancement/firenova.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireNovaSpell",
          spellId = 1535,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    enh.NewTimer(),
				Duration: time.Second * time.Duration(4),
			},
		}]],
          cooldown = {
            raw = "time.Second * time.Duration(4)",
            seconds = nil
          },
          Flags = "shaman.SpellFlagShamanSpell | core.SpellFlagAPL | core.SpellFlagAoE",
          ClassSpellMask = "shaman.SpellMaskFireNova",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "enh.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      monk = {
        registerHealingSphere_HealingSphereStacks = {
          sourceFile = "extern/wowsims-mop/sim/monk/healing_sphere.go",
          registrationType = "RegisterAura",
          functionName = "registerHealingSphere",
          spellId = 115460,
          tag = 1,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Healing Sphere Stacks"
        },
        registerHealingSphere_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/healing_sphere.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingSphere",
          spellId = 115464,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful | core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerHealingSphere_4 = {
          sourceFile = "extern/wowsims-mop/sim/monk/healing_sphere.go",
          registrationType = "RegisterSpell",
          functionName = "registerHealingSphere",
          spellId = 115460,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: 500 * time.Millisecond,
			},
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: 500 * time.Millisecond,
			},
		}]],
          cooldown = {
            raw = "500 * time.Millisecond",
            seconds = 0
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellHealingSphere",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1"
        },
        registerFortifyingBrew_FortifyingBrew = {
          sourceFile = "extern/wowsims-mop/sim/monk/fortifying_brew.go",
          registrationType = "RegisterAura",
          functionName = "registerFortifyingBrew",
          spellId = 126456,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Fortifying Brew"
        },
        registerFortifyingBrew_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/fortifying_brew.go",
          registrationType = "RegisterSpell",
          functionName = "registerFortifyingBrew",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 126456,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "MonkSpellFortifyingBrew"
        },
        NewXuen_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/xuen_pet.go",
          registrationType = "RegisterSpell",
          functionName = "NewXuen",
          spellId = 123996,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Millisecond * 500,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    xuen.NewTimer(),
				Duration: time.Second * 1,
			},
		}]],
          cooldown = {
            raw = "time.Second * 1",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSpinningCraneKick_SpinningCraneKick = {
          sourceFile = "extern/wowsims-mop/sim/monk/spinning_crane_kick.go",
          registrationType = "RegisterAura",
          functionName = "registerSpinningCraneKick",
          spellId = 101546,
          auraDuration = {
            raw = "time.Millisecond * 750 * 3",
            seconds = nil
          },
          label = "Spinning Crane Kick"
        },
        registerGlyphOfFistsOfFury_GlyphofFistsofFury = {
          sourceFile = "extern/wowsims-mop/sim/monk/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfFistsOfFury",
          spellId = 125671,
          label = "Glyph of Fists of Fury"
        },
        registerExpelHarm_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/expel_harm.go",
          registrationType = "RegisterSpell",
          functionName = "registerExpelHarm",
          spellId = 115129,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagIgnoreAttackerModifiers",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0.5",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerExpelHarm_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/expel_harm.go",
          registrationType = "RegisterSpell",
          functionName = "registerExpelHarm",
          spellId = 115072,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagHelpful | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellExpelHarm",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "7",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerStormEarthAndFire_StormEarthandFire = {
          sourceFile = "extern/wowsims-mop/sim/monk/ww_storm_earth_and_fire.go",
          registrationType = "RegisterAura",
          functionName = "registerStormEarthAndFire",
          spellId = 138228,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Storm, Earth, and Fire"
        },
        registerStormEarthAndFire_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/ww_storm_earth_and_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormEarthAndFire",
          spellId = 138228,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellStormEarthAndFire"
        },
        registerWayOfTheMonk_WayoftheMonk = {
          sourceFile = "extern/wowsims-mop/sim/monk/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerWayOfTheMonk",
          spellId = 120277,
          label = "Way of the Monk"
        },
        registerSwiftReflexes_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/passives.go",
          registrationType = "RegisterSpell",
          functionName = "registerSwiftReflexes",
          spellId = 124335,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.3 * 7.5",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCracklingJadeLightning_CracklingJadeLightning = {
          sourceFile = "extern/wowsims-mop/sim/monk/crackling_jade_lightning.go",
          registrationType = "RegisterSpell",
          functionName = "registerCracklingJadeLightning",
          spellId = 117952,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellCracklingJadeLightning",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Crackling Jade Lightning"
        },
        registerComboBreakerDamageMod_FocusofXuen = {
          sourceFile = "extern/wowsims-mop/sim/monk/items.go",
          registrationType = "RegisterAura",
          functionName = "registerComboBreakerDamageMod",
          spellId = 145024,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Focus of Xuen"
        },
        registerStanceOfTheSturdyOx_StanceoftheSturdyOx = {
          sourceFile = "extern/wowsims-mop/sim/monk/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerStanceOfTheSturdyOx",
          spellId = 115069,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Stance of the Sturdy Ox"
        },
        registerStanceOfTheWiseSerpent_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/stances.go",
          registrationType = "RegisterSpell",
          functionName = "registerStanceOfTheWiseSerpent",
          spellId = 117895,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "0.25",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerStanceOfTheWiseSerpent_Eminence = {
          sourceFile = "extern/wowsims-mop/sim/monk/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerStanceOfTheWiseSerpent",
          spellId = 126890,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Eminence"
        },
        registerStanceOfTheWiseSerpent_StanceoftheWiseSerpent = {
          sourceFile = "extern/wowsims-mop/sim/monk/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerStanceOfTheWiseSerpent",
          spellId = 136336,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Stance of the Wise Serpent"
        },
        registerStanceOfTheFierceTiger_StanceoftheFierceTiger = {
          sourceFile = "extern/wowsims-mop/sim/monk/stances.go",
          registrationType = "RegisterAura",
          functionName = "registerStanceOfTheFierceTiger",
          spellId = 103985,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Stance of the Fierce Tiger"
        },
        registerTouchOfDeath_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/touch_of_death.go",
          registrationType = "RegisterSpell",
          functionName = "registerTouchOfDeath",
          spellId = 115080,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: cooldown,
			},
		}]],
          cooldown = {
            raw = "cooldown",
            seconds = nil
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagCannotBeDodged | core.SpellFlagIgnoreArmor | core.SpellFlagIgnoreModifiers | SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellTouchOfDeath",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerZenSphere_ZenSphere = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerZenSphere",
          spellId = 124081,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Zen Sphere"
        },
        registerZenSphere_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerZenSphere",
          spellId = 124081,
          Flags = "core.SpellFlagAoE | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MonkSpellZenSphere",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerZenSphere_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerZenSphere",
          spellId = 124081,
          Flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MonkSpellZenSphere",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1.0",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerZenSphere_4 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerZenSphere",
          spellId = 124081,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "MonkSpellZenSphere",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0"
        },
        registerZenSphere_ZenSphereHeal = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerZenSphere",
          spellId = 124081,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "MonkSpellZenSphere",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1.0",
          CritMultiplier = "monk.DefaultCritMultiplier()",
          ThreatMultiplier = "1.0",
          IgnoreHaste = "true",
          label = "Zen Sphere (Heal)"
        },
        registerChiBurst_ChiBurst = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerChiBurst",
          spellId = 123986,
          auraDuration = {
            raw = "time.Second",
            seconds = 1
          },
          label = "Chi Burst"
        },
        registerChiBurst_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerChiBurst",
          spellId = 123986,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellChiBurst",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellDamage",
          IgnoreHaste = "true"
        },
        registerPowerStrikes_ChiSphere = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPowerStrikes",
          spellId = 121286,
          auraDuration = {
            raw = "time.Minute * chiSphereduration",
            seconds = nil
          },
          label = "Chi Sphere"
        },
        registerPowerStrikes_ChiSphereUse = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPowerStrikes",
          spellId = 121283,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Chi Sphere (Use)"
        },
        registerPowerStrikes_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerStrikes",
          spellId = 121283,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellChiSphere",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerPowerStrikes_PowerStrikes = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPowerStrikes",
          spellId = 129914,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Power Strikes"
        },
        registerAscension_Ascension = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerAscension",
          spellId = 115396,
          label = "Ascension"
        },
        registerChiBrew_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerChiBrew",
          spellId = 115399,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellChiBrew"
        },
        registerDampenHarm_DampenHarm = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerDampenHarm",
          spellId = 122278,
          tag = 1,
          auraDuration = {
            raw = "time.Second * 45",
            seconds = 45
          },
          label = "Dampen Harm"
        },
        registerDampenHarm_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDampenHarm",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 122278,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: 90 * time.Second,
			},
		}]],
          cooldown = {
            raw = "90 * time.Second",
            seconds = 90
          },
          ClassSpellMask = "MonkSpellDampenHarm",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerRushingJadeWind_RushingJadeWind = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRushingJadeWind",
          spellId = 116847,
          auraDuration = {
            raw = "baseCooldown",
            seconds = nil
          },
          label = "Rushing Jade Wind"
        },
        registerInvokeXuenTheWhiteTiger_XuentheWhiteTiger = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerInvokeXuenTheWhiteTiger",
          spellId = 123904,
          auraDuration = {
            raw = "time.Second * 45.0",
            seconds = 45
          },
          label = "Xuen, the White Tiger"
        },
        registerInvokeXuenTheWhiteTiger_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerInvokeXuenTheWhiteTiger",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 123904,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    monk.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MonkSpellInvokeXuenTheWhiteTiger",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskEmpty"
        }
      },
      windwalker = {
        registerTigereyeBrew_TigereyeBrewStacks = {
          sourceFile = "extern/wowsims-mop/sim/monk/windwalker/tigereye_brew.go",
          registrationType = "RegisterAura",
          functionName = "registerTigereyeBrew",
          spellId = 1247279,
          auraDuration = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          label = "Tigereye Brew Stacks"
        },
        registerTigereyeBrew_TigereyeBrewBuff = {
          sourceFile = "extern/wowsims-mop/sim/monk/windwalker/tigereye_brew.go",
          registrationType = "RegisterAura",
          functionName = "registerTigereyeBrew",
          spellId = 1247275,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Tigereye Brew Buff"
        },
        registerTigereyeBrew_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/windwalker/tigereye_brew.go",
          registrationType = "RegisterSpell",
          functionName = "registerTigereyeBrew",
          spellId = 1247275,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    ww.NewTimer(),
				Duration: time.Second * 5,
			},
		}]],
          cooldown = {
            raw = "time.Second * 5",
            seconds = 5
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellTigereyeBrew",
          RelatedSelfBuff = "buffAura"
        },
        registerEnergizingBrew_EnergizingBrew = {
          sourceFile = "extern/wowsims-mop/sim/monk/windwalker/energizing_brew.go",
          registrationType = "RegisterAura",
          functionName = "registerEnergizingBrew",
          spellId = 115288,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Energizing Brew"
        },
        registerEnergizingBrew_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/windwalker/energizing_brew.go",
          registrationType = "RegisterSpell",
          functionName = "registerEnergizingBrew",
          spellId = 115288,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    ww.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "monk.MonkSpellEnergizingBrew",
          RelatedSelfBuff = "energizingBrewAura"
        }
      },
      brewmaster = {
        registerDizzyingHaze_DizzyingHaze = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/dizzying_haze.go",
          registrationType = "RegisterAura",
          functionName = "registerDizzyingHaze",
          spellId = 116330,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Dizzying Haze"
        },
        registerDizzyingHaze_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/dizzying_haze.go",
          registrationType = "RegisterSpell",
          functionName = "registerDizzyingHaze",
          spellId = 115180,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			IgnoreHaste: true,
		}]],
          ClassSpellMask = "monk.MonkSpellDizzyingHazeProjectile",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          IgnoreHaste = "true"
        },
        registerDizzyingHaze_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/dizzying_haze.go",
          registrationType = "RegisterSpell",
          functionName = "registerDizzyingHaze",
          spellId = 115180,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellDizzyingHaze",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0",
          CritMultiplier = "bm.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerStagger_Stagger = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/stagger.go",
          registrationType = "RegisterSpell",
          functionName = "registerStagger",
          spellId = 124255,
          Flags = "core.SpellFlagNoMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "monk.MonkSpellStagger",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Stagger"
        },
        registerBrewmasterTraining_PowerGuard = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerBrewmasterTraining",
          spellId = 118636,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Power Guard"
        },
        registerBrewmasterTraining_Shuffle = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerBrewmasterTraining",
          spellId = 115307,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Shuffle"
        },
        registerElusiveBrew_BrewingElusiveBrew = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerElusiveBrew",
          spellId = 128938,
          auraDuration = {
            raw = "30 * time.Second",
            seconds = 30
          },
          label = "Brewing: Elusive Brew"
        },
        registerElusiveBrew_ElusiveBrew = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerElusiveBrew",
          spellId = 115308,
          auraDuration = {
            raw = "0",
            seconds = nil
          },
          label = "Elusive Brew"
        },
        registerElusiveBrew_3 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterSpell",
          functionName = "registerElusiveBrew",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 115308,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellElusiveBrew",
          RelatedSelfBuff = "bm.ElusiveBrewAura",
          IgnoreHaste = "true"
        },
        registerGiftOfTheOx_GiftOfTheOx = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerGiftOfTheOx",
          spellId = 124502,
          auraDuration = {
            raw = "sphereDuration",
            seconds = nil
          },
          label = "Gift Of The Ox"
        },
        registerGiftOfTheOx_2 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterSpell",
          functionName = "registerGiftOfTheOx",
          spellId = 124507,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellGiftOfTheOx",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "giftOfTheOxStackingAura"
        },
        registerDesperateMeasures_DesperateMeasures = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerDesperateMeasures",
          spellId = 126060,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Desperate Measures"
        },
        registerBreathOfFire_BreathOfFire = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/breath_of_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerBreathOfFire",
          spellId = 115181,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAoE | monk.SpellFlagSpender | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellBreathOfFire",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "bm.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Breath Of Fire"
        },
        registerKegSmash_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/keg_smash.go",
          registrationType = "RegisterSpell",
          functionName = "registerKegSmash",
          spellId = 121253,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | monk.SpellFlagBuilder | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellKegSmash",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "10.0",
          CritMultiplier = "bm.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerPurifyingBrew_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/purifying_brew.go",
          registrationType = "RegisterSpell",
          functionName = "registerPurifyingBrew",
          spellId = 119582,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Second * 1,
			},
		}]],
          cooldown = {
            raw = "time.Second * 1",
            seconds = 1
          },
          Flags = "monk.SpellFlagSpender | core.SpellFlagAPL",
          ClassSpellMask = "monk.MonkSpellPurifyingBrew"
        },
        registerAvertHarm_1 = {
          sourceFile = "extern/wowsims-mop/sim/monk/brewmaster/avert_harm.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvertHarm",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 115213,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    bm.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "monk.MonkSpellAvertHarm",
          RelatedSelfBuff = "bm.AvertHarmAura"
        }
      },
      hunter = {
        ApplySpikedCollar_SpikedCollar = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_spec.go",
          registrationType = "RegisterAura",
          functionName = "ApplySpikedCollar",
          spellId = 53184,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Spiked Collar"
        },
        ApplyCombatExperience_CombatExperience = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_spec.go",
          registrationType = "RegisterAura",
          functionName = "ApplyCombatExperience",
          spellId = 20782,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Combat Experience"
        },
        registerArcaneShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/arcane_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneShotSpell",
          spellId = 3044,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellArcaneShot",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.25",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterKillCommandSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_abilities.go",
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
          DamageMultiplier = "1.5",
          CritMultiplier = "hp.CritMultiplier(1.0",
          ThreatMultiplier = "1"
        },
        newFrostStormBreath_FrostStormBreath = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_abilities.go",
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
          CritMultiplier = "hp.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "FrostStormBreath-"
        },
        registerRabidCD_Rabid = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_abilities.go",
          registrationType = "RegisterAura",
          functionName = "registerRabidCD",
          spellId = 53401,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Rabid"
        },
        registerRabidCD_2 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/pet_abilities.go",
          registrationType = "RegisterSpell",
          functionName = "registerRabidCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 53401,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          }
        },
        registerFervorSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/fervor.go",
          registrationType = "RegisterSpell",
          functionName = "registerFervorSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 82726,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          ClassSpellMask = "HunterSpellFervor"
        },
        registerGlaiveTossSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/glaive_toss.go",
          registrationType = "RegisterSpell",
          functionName = "registerGlaiveTossSpell",
          spellId = 117050,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: 15 * time.Second,
			},
		}]],
          cooldown = {
            raw = "15 * time.Second",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellGlaiveToss",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerKillShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/kill_shot.go",
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellKillShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "4.2",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExplosiveTrapSpell_ExplosiveTrap = {
          sourceFile = "extern/wowsims-mop/sim/hunter/explosive_trap.go",
          registrationType = "RegisterSpell",
          functionName = "registerExplosiveTrapSpell",
          spellId = 13812,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "HunterSpellExplosiveTrap",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.CritMultiplier(1",
          ThreatMultiplier = "1",
          label = "Explosive Trap"
        },
        registerSilencingShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/silencing_shot.go",
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          ThreatMultiplier = "1"
        },
        RegisterDireBeastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/dire_beast.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDireBeastSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 120679,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          ClassSpellMask = "HunterSpellDireBeast"
        },
        registerAMOCSpell_Peck = {
          sourceFile = "extern/wowsims-mop/sim/hunter/a_murder_of_crows.go",
          registrationType = "RegisterSpell",
          functionName = "registerAMOCSpell",
          spellId = 131894,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagApplyArmorReduction | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellAMurderOfCrows",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Peck"
        },
        registerSerpentStingSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 82834,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellSerpentSting",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskDirect",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.CritMultiplier(1"
        },
        registerSerpentStingSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/serpent_sting.go",
          registrationType = "RegisterSpell",
          functionName = "registerSerpentStingSpell",
          spellId = 1978,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 3,
			},
		}]],
          cooldown = {
            raw = "time.Second * 3",
            seconds = 3
          },
          Flags = "core.SpellFlagNone",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSerpentStingSpell_SerpentStingDot = {
          sourceFile = "extern/wowsims-mop/sim/hunter/serpent_sting.go",
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
          CritMultiplier = "hunter.CritMultiplier(1",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "SerpentStingDot"
        },
        registerCobraShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/cobra_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerCobraShotSpell",
          spellId = 77767,
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
				ss := hunter.TotalRangedHasteMultiplier()
				return time.Duration(float64(spell.DefaultCast.CastTime) / ss)
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellCobraShot",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "0.77",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerPowerShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/powershot.go",
          registrationType = "RegisterSpell",
          functionName = "registerPowerShotSpell",
          spellId = 109259,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second,
				CastTime: time.Millisecond * 2250,
			},
			IgnoreHaste: true,
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				cast.CastTime = spell.CastTime()

				hunter.AutoAttacks.StopRangedUntil(sim, sim.CurrentTime+spell.CastTime())
			},

			CastTime: func(spell *core.Spell) time.Duration {
				return time.Duration(float64(spell.DefaultCast.CastTime) / hunter.TotalRangedHasteMultiplier())
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: 45 * time.Second,
			},
		}]],
          cooldown = {
            raw = "45 * time.Second",
            seconds = 45
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellPowershot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "6",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        RegisterStampedeSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/stampede.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterStampedeSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 121818,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 5,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagReadinessTrinket"
        },
        RegisterLynxRushSpell_LynxRush = {
          sourceFile = "extern/wowsims-mop/sim/hunter/lynx_rush.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterLynxRushSpell",
          spellId = 120697,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 0,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics",
          ClassSpellMask = "HunterSpellLynxRush",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          label = "Lynx Rush"
        },
        RegisterLynxRushSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/lynx_rush.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterLynxRushSpell",
          spellId = 120697,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolNone",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerHuntersMarkSpell_HuntersMark = {
          sourceFile = "extern/wowsims-mop/sim/hunter/hunters_mark.go",
          registrationType = "RegisterAura",
          functionName = "registerHuntersMarkSpell",
          spellId = 1130,
          auraDuration = {
            raw = "5 * time.Minute",
            seconds = 300
          },
          label = "HuntersMark-"
        },
        registerRapidFireCD_RapidFire = {
          sourceFile = "extern/wowsims-mop/sim/hunter/rapid_fire.go",
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
          sourceFile = "extern/wowsims-mop/sim/hunter/rapid_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerRapidFireCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 3045,
          cast = [[{
			CD: core.Cooldown{
				Timer:    hunter.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "HunterSpellRapidFire"
        },
        applyThrillOfTheHunt_ThrilloftheHunt = {
          sourceFile = "extern/wowsims-mop/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyThrillOfTheHunt",
          spellId = 109306,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Thrill of the Hunt"
        },
        applyThrillOfTheHunt_ThrilloftheHuntProccer = {
          sourceFile = "extern/wowsims-mop/sim/hunter/talents.go",
          registrationType = "RegisterAura",
          functionName = "applyThrillOfTheHunt",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Thrill of the Hunt Proccer"
        },
        registerMultiShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/multi_shot.go",
          registrationType = "RegisterSpell",
          functionName = "registerMultiShotSpell",
          spellId = 2643,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "HunterSpellMultiShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "0.6",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "hunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      survival = {
        registerBlackArrowSpell_BlackArrowDot = {
          sourceFile = "extern/wowsims-mop/sim/hunter/survival/black_arrow.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlackArrowSpell",
          spellId = 3674,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			IgnoreHaste: true, // Hunter GCD is locked at 1.5s
			CD: core.Cooldown{
				Timer:    svHunter.NewTimer(),
				Duration: time.Second * 24, // 24 with trap mastery for survival
			},
		}]],
          cooldown = {
            raw = "time.Second * 24",
            seconds = 24
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "hunter.HunterSpellBlackArrow",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1.3",
          CritMultiplier = "svHunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Black Arrow Dot"
        },
        applyLNL_LockandLoadProc = {
          sourceFile = "extern/wowsims-mop/sim/hunter/survival/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyLNL",
          spellId = 56343,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Lock and Load Proc"
        },
        applyLNL_LockandLoad = {
          sourceFile = "extern/wowsims-mop/sim/hunter/survival/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyLNL",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Lock and Load"
        },
        registerExplosiveShotSpell_ExplosiveShot = {
          sourceFile = "extern/wowsims-mop/sim/hunter/survival/explosive_shot.go",
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "hunter.HunterSpellExplosiveShot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "svHunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true",
          label = "Explosive Shot"
        }
      },
      beast_mastery = {
        registerKillCommandSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/kill_command.go",
          registrationType = "RegisterSpell",
          functionName = "registerKillCommandSpell",
          spellId = 34026,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    bmHunter.NewTimer(),
				Duration: time.Second * 6,
			},
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "hunter.HunterSpellKillCommand",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMelee",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "bmHunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyFrenzy_Frenzy = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          spellId = 19623,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Frenzy"
        },
        applyFrenzy_FrenzyHandler = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyFrenzy",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "FrenzyHandler"
        },
        applyGoForTheThroat_GofortheThroat = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyGoForTheThroat",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Go for the Throat"
        },
        applyCobraStrikes_CobraStrikes = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyCobraStrikes",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Cobra Strikes"
        },
        applyInvigoration_Invigoration = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/specializations.go",
          registrationType = "RegisterAura",
          functionName = "applyInvigoration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Invigoration"
        },
        registerBestialWrathCD_BestialWrathPet = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/bestial_wrath.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Bestial Wrath Pet"
        },
        registerBestialWrathCD_BestialWrath = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/bestial_wrath.go",
          registrationType = "RegisterAura",
          functionName = "registerBestialWrathCD",
          spellId = 19574,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Bestial Wrath"
        },
        registerBestialWrathCD_3 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/bestial_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerBestialWrathCD",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 19574,
          cast = [[{
			CD: core.Cooldown{
				Timer:    bmHunter.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          ClassSpellMask = "hunter.HunterSpellBestialWrath"
        },
        registerFocusFireSpell_FocusFire = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/focus_fire.go",
          registrationType = "RegisterAura",
          functionName = "registerFocusFireSpell",
          spellId = 82692,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Focus Fire"
        },
        registerFocusFireSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/beast_mastery/focus_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerFocusFireSpell",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 82692,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]]
        }
      },
      marksmanship = {
        registerSteadyShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/steady_shot.go",
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
				return time.Duration(float64(spell.DefaultCast.CastTime) / mm.TotalRangedHasteMultiplier())
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "hunter.HunterSpellSteadyShot",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "0.726",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mm.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerChimeraShotSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/chimera_shot.go",
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagRanged",
          ClassSpellMask = "hunter.HunterSpellChimeraShot",
          SpellSchool = "core.SpellSchoolNature",
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "4.57",
          CritMultiplier = "mmHunter.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        ApplySpecialization_Bombardment = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "ApplySpecialization",
          spellId = 35110,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Bombardment"
        },
        MasterMarksmanAura_ReadySetAim = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "MasterMarksmanAura",
          spellId = 82925,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Ready, Set, Aim..."
        },
        MasterMarksmanAura_MasterMarksman = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "MasterMarksmanAura",
          spellId = 34486,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Master Marksman"
        },
        MasterMarksmanAura_MasterMarksmanInternal = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "MasterMarksmanAura",
          label = "Master Marksman Internal"
        },
        SteadyFocusAura_SteadyFocus = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "SteadyFocusAura",
          spellId = 53224,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Steady Focus"
        },
        SteadyFocusAura_SteadyFocusCounter = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "SteadyFocusAura",
          spellId = 53224,
          label = "Steady Focus Counter"
        },
        PiercingShotsAura_PiercingShots = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterSpell",
          functionName = "PiercingShotsAura",
          spellId = 53238,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreModifiers | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "PiercingShots"
        },
        PiercingShotsAura_PiercingShotsTalent = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/specializations.go",
          registrationType = "RegisterAura",
          functionName = "PiercingShotsAura",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Piercing Shots Talent"
        },
        applyMastery_1 = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/marksmanship.go",
          registrationType = "RegisterSpell",
          functionName = "applyMastery",
          spellId = 76659,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell | core.SpellFlagRanged",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0.8",
          CritMultiplier = "mm.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyMastery_WildQuiverMastery = {
          sourceFile = "extern/wowsims-mop/sim/hunter/marksmanship/marksmanship.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_binding_heal.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "0.5 * (1 - []float64{0"
        },
        registerPowerWordShieldSpell_PowerWordShield = {
          sourceFile = "extern/wowsims-mop/sim/priest/_power_word_shield.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_power_word_shield.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_power_word_shield.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_smite.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerCircleOfHealingSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_circle_of_healing.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        Initialize_InnerFire = {
          sourceFile = "extern/wowsims-mop/sim/priest/priest.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 588,
          label = "Inner Fire"
        },
        NewShadowfiend_Autoattackmanaregen = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadowfiend_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewShadowfiend",
          label = "Autoattack mana regen"
        },
        NewShadowfiend_Shadowcrawl = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadowfiend_pet.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/shadowfiend_pet.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/shadowfiend.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          auraDuration = {
            raw = "time.Second * 12.0",
            seconds = 12
          },
          label = "Shadowfiend"
        },
        registerShadowfiendSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadowfiend.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowfiendSpell",
          spellId = 34433,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "PriestSpellShadowFiend",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerGreaterHealSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_greater_heal.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        RegisterHolyFireSpell_HolyFire = {
          sourceFile = "extern/wowsims-mop/sim/priest/_holy_fire.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0",
          label = "HolyFire"
        },
        registerVampiricTouchSpell_VampiricTouch = {
          sourceFile = "extern/wowsims-mop/sim/priest/vampiric_touch.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "VampiricTouch"
        },
        registerFlashHealSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_flash_heal.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        RegisterHymnOfHopeCD_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_hymn_of_hope.go",
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
        registerPowerInfusionSpell_PowerInfusionAura = {
          sourceFile = "extern/wowsims-mop/sim/priest/power_infusion.go",
          registrationType = "RegisterAura",
          functionName = "registerPowerInfusionSpell",
          spellId = 10060,
          auraDuration = {
            raw = "PowerInfusionDuration",
            seconds = nil
          },
          label = "PowerInfusion-Aura"
        },
        registerPowerInfusionSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/priest/power_infusion.go",
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
				Duration: PowerInfusionCD,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "PowerInfusionCD",
            seconds = nil
          },
          Flags = "core.SpellFlagHelpful"
        },
        registerRenewSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_renew.go",
          registrationType = "RegisterSpell",
          functionName = "registerRenewSpell",
          spellId = 63543,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1 *",
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerRenewSpell_Renew = {
          sourceFile = "extern/wowsims-mop/sim/priest/_renew.go",
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
        registerDispersionSpell_Dispersion = {
          sourceFile = "extern/wowsims-mop/sim/priest/_dispersion.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_dispersion.go",
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
        registerPrayerOfMendingSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_prayer_of_mending.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        makePrayerOfMendingAura_PrayerOfMending = {
          sourceFile = "extern/wowsims-mop/sim/priest/_prayer_of_mending.go",
          registrationType = "RegisterAura",
          functionName = "makePrayerOfMendingAura",
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "PrayerOfMending"
        },
        NewMindBender_Autoattackmanaregen = {
          sourceFile = "extern/wowsims-mop/sim/priest/mindbender_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewMindBender",
          label = "Autoattack mana regen"
        },
        NewMindBender_Shadowcrawl = {
          sourceFile = "extern/wowsims-mop/sim/priest/mindbender_pet.go",
          registrationType = "RegisterAura",
          functionName = "NewMindBender",
          spellId = 63619,
          auraDuration = {
            raw = "time.Second * 5",
            seconds = 5
          },
          label = "Shadowcrawl"
        },
        NewMindBender_3 = {
          sourceFile = "extern/wowsims-mop/sim/priest/mindbender_pet.go",
          registrationType = "RegisterSpell",
          functionName = "NewMindBender",
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
        applyEvangelism_DarkEvangelismProc = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()"
        },
        applyArchangel_4 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()"
        },
        applyImprovedMindBlast_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyImprovedMindBlast",
          spellId = 48301,
          Flags = "core.SpellFlagNoMetrics",
          ClassSpellMask = "PriestSpellMindTrauma",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultCritMultiplier()"
        },
        applyImprovedMindBlast_ImprovedMindBlast = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedMindBlast",
          label = "Improved Mind Blast"
        },
        applyImprovedDevouringPlague_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterSpell",
          functionName = "applyImprovedDevouringPlague",
          spellId = 2944,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "PriestSpellImprovedDevouringPlague",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskProc",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyImprovedDevouringPlague_ImprovedDevouringPlagueTalent = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyImprovedDevouringPlague",
          label = "Improved Devouring Plague Talent"
        },
        applyMasochism_Masochism = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMasochism",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Masochism"
        },
        applyMindMelt_MindMeltProc = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMindMelt",
          spellId = 87160,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Mind Melt Proc"
        },
        applyDivineAegis_DivineAegis = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyDivineAegis",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Divine Aegis Talent"
        },
        applyGrace_Grace = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyGrace",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Grace Talent"
        },
        applyBorrowedTime_BorrowedTime = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyBorrowedTime",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Borrwed Time Talent"
        },
        applyInspiration_InspirationTalent = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyInspiration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Inspiration Talent"
        },
        applyHolyConcentration_HolyConcentration = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHolyConcentration",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Holy Concentration Talent"
        },
        applySerendipity_Serendipity = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applySerendipity",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Serendipity Talent"
        },
        applySurgeOfLight_SurgeofLightProc = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applySurgeOfLight",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Surge of Light"
        },
        applyMisery_PriestShadowEffects = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyMisery",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Priest Shadow Effects"
        },
        applyShadowWeaving_ShadowWeaving = {
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_talents.go",
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
        registerMindbenderSpell_Mindbender = {
          sourceFile = "extern/wowsims-mop/sim/priest/mindbender.go",
          registrationType = "RegisterAura",
          functionName = "registerMindbenderSpell",
          spellId = 123040,
          auraDuration = {
            raw = "time.Second * 15.0",
            seconds = 15
          },
          label = "Mindbender"
        },
        registerMindbenderSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/priest/mindbender.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindbenderSpell",
          spellId = 123040,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    priest.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "PriestSpellMindBender",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerShadowWordPainSpell_ShadowWordPain = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow_word_pain.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "ShadowWordPain"
        },
        makePenanceSpell_Penance = {
          sourceFile = "extern/wowsims-mop/sim/priest/_penance.go",
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
          sourceFile = "extern/wowsims-mop/sim/priest/_prayer_of_healing.go",
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
          CritMultiplier = "priest.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - []float64{0"
        },
        registerPrayerOfHealingSpell_PoHGlyph = {
          sourceFile = "extern/wowsims-mop/sim/priest/_prayer_of_healing.go",
          registrationType = "RegisterSpell",
          functionName = "registerPrayerOfHealingSpell",
          spellId = 42409,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "priest.PrayerOfHealing.DamageMultiplier * 0.2 / 2",
          ThreatMultiplier = "1 - []float64{0",
          label = "PoH Glyph"
        }
      },
      shadow = {
        ApplyTalents_Shadowform = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/shadow.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          label = "Shadowform"
        },
        registerHalo_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/halo.go",
          registrationType = "RegisterSpell",
          functionName = "registerHalo",
          spellId = 120696,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shadow.NewTimer(),
				Duration: time.Second * 40,
			},
		}]],
          cooldown = {
            raw = "time.Second * 40",
            seconds = 40
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellHalo",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMindFlaySpell_MindFlay = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/mind_flay.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindFlaySpell",
          spellId = 15407,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellMindFlay",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "MindFlay-"
        },
        registerShadowWordDeathSpell_ShadowWordDeath = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/shadow_word_death.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowWordDeathSpell",
          spellId = 32379,
          tag = 1,
          auraDuration = {
            raw = "9 * time.Second",
            seconds = 9
          },
          label = "Shadow Word: Death"
        },
        registerShadowWordDeathSpell_2 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/shadow_word_death.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowWordDeathSpell",
          spellId = 32379,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shadow.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellShadowWordDeath",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDevouringPlagueSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 2944,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagDisease | core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellDevouringPlague",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDevouringPlagueSpell_DevouringPlague = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/devouring_plague.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevouringPlagueSpell",
          spellId = 2944,
          tag = 1,
          Flags = "core.SpellFlagDisease | core.SpellFlagPassiveSpell",
          ClassSpellMask = "priest.PriestSpellDevouringPlagueDoT",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Devouring Plague"
        },
        registerShadowyApparition_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/shadowy_apparition.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowyApparition",
          spellId = 148859,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "priest.PriestSpellShadowyApparation",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()"
        },
        registerCascade_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/cascade.go",
          registrationType = "RegisterSpell",
          functionName = "registerCascade",
          spellId = 127632,
          Flags = "core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCascade_2 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/cascade.go",
          registrationType = "RegisterSpell",
          functionName = "registerCascade",
          spellId = 127632,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shadow.NewTimer(),
				Duration: time.Second * 25,
			},
		}]],
          cooldown = {
            raw = "time.Second * 25",
            seconds = 25
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDivineStar_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/divine_star.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineStar",
          spellId = 122128,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    shadow.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMindBlastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/mind_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerMindBlastSpell",
          spellId = 8092,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    shadow.NewTimer(),
				Duration: time.Second * 8,
			},
		}]],
          cooldown = {
            raw = "time.Second * 8",
            seconds = 8
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellMindBlast",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMindSpike_1 = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/mind_spike.go",
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
          ClassSpellMask = "priest.PriestSpellMindSpike",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShadowyRecall_ShadowyRecallMastery = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/shadowy_recall.go",
          registrationType = "RegisterAura",
          functionName = "registerShadowyRecall",
          label = "Shadowy Recall (Mastery)"
        },
        registerSurgeOfDarkness_SurgeofDarkness = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSurgeOfDarkness",
          spellId = 87160,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Surge of Darkness"
        },
        registerSurgeOfDarkness_SurgeofDarknessTalent = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSurgeOfDarkness",
          label = "Surge of Darkness (Talent)"
        },
        registerSolaceAndInstanity_MindFlayInsanity = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerSolaceAndInstanity",
          spellId = 129197,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "priest.PriestSpellMindFlay",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "shadow.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "MindFlay-Insanity"
        },
        registerTwistOfFate_TwistofFate = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerTwistOfFate",
          spellId = 123254,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Twist of Fate"
        },
        registerTwistOfFate_TwistofFateTalent = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerTwistOfFate",
          label = "Twist of Fate (Talent)"
        },
        registerDivineInsight_DivineInsight = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerDivineInsight",
          spellId = 124430,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Divine Insight"
        },
        registerDivineInsight_DivineInsightTalent = {
          sourceFile = "extern/wowsims-mop/sim/priest/shadow/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerDivineInsight",
          label = "Divine Insight (Talent)"
        }
      },
      warlock = {
        RegisterCorruption_Corruption = {
          sourceFile = "extern/wowsims-mop/sim/warlock/corruption.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterCorruption",
          spellId = 172,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellCorruption",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Corruption"
        },
        registerSummonDoomguard_SummonDoomguard = {
          sourceFile = "extern/wowsims-mop/sim/warlock/doomguard.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonDoomguard",
          spellId = 18540,
          auraDuration = {
            raw = "60 * time.Second",
            seconds = 60
          },
          label = "Summon Doomguard"
        },
        registerSummonDoomguard_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/doomguard.go",
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
          sourceFile = "extern/wowsims-mop/sim/warlock/doomguard.go",
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
        registerLifeTap_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/lifetap.go",
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
        RegisterDrainLife_DrainLife = {
          sourceFile = "extern/wowsims-mop/sim/warlock/drain_life.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterDrainLife",
          spellId = 689,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellDrainLife",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Drain Life"
        },
        RegisterFelflame_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/felflame.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterFelflame",
          spellId = 77799,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellFelFlame",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0",
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShadowBiteSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBiteSpell",
          spellId = 54049,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          ClassSpellMask = "WarlockSpellFelHunterShadowBite",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerFireboltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireboltSpell",
          spellId = 3110,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second * 1,
				CastTime: time.Millisecond * 1750,
			},
		}]],
          ClassSpellMask = "WarlockSpellImpFireBolt",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerLashOfPainSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerLashOfPainSpell",
          spellId = 7814,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          ClassSpellMask = "WarlockSpellSuccubusLashOfPain",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerTormentSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/pets.go",
          registrationType = "RegisterSpell",
          functionName = "registerTormentSpell",
          spellId = 3716,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          ClassSpellMask = "WarlockSpellVoidwalkerTorment",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        RegisterHellfire_Hellfire = {
          sourceFile = "extern/wowsims-mop/sim/warlock/hellfire.go",
          registrationType = "RegisterSpell",
          functionName = "RegisterHellfire",
          spellId = 1949,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellHellfire",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Hellfire"
        },
        registerFlameBlast_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/items.go",
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
          CritMultiplier = "pet.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSummonInfernal_SummonInfernal = {
          sourceFile = "extern/wowsims-mop/sim/warlock/infernal.go",
          registrationType = "RegisterAura",
          functionName = "registerSummonInfernal",
          spellId = 1122,
          auraDuration = {
            raw = "time.Second * 60",
            seconds = 60
          },
          label = "Summon Infernal"
        },
        registerSummonInfernal_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/infernal.go",
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
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "WarlockSpellSummonInfernal",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "summonInfernalAura"
        },
        Initialize_Immolation = {
          sourceFile = "extern/wowsims-mop/sim/warlock/infernal.go",
          registrationType = "RegisterSpell",
          functionName = "Initialize",
          spellId = 20153,
          Flags = "core.SpellFlagAoE",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          label = "Immolation"
        },
        registerCurseOfElements_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/curse_of_elements.go",
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
        registerSearingPain_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/searing_pain.go",
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
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShadowflame_ShadowflameDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/shadowflame.go",
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
          CritMultiplier = "warlock.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Shadowflame (DoT)"
        },
        registerMannarothsFury_MannarothsFury = {
          sourceFile = "extern/wowsims-mop/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerMannarothsFury",
          spellId = 108508,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Mannaroth's Fury"
        },
        registerMannarothsFury_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerMannarothsFury",
          spellId = 108508,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerGrimoireOfSacrifice_GrimioireofSacrifice = {
          sourceFile = "extern/wowsims-mop/sim/warlock/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerGrimoireOfSacrifice",
          spellId = 108503,
          auraDuration = {
            raw = "time.Hour",
            seconds = 3600
          },
          label = "Grimioire of Sacrifice"
        },
        registerGrimoireOfSacrifice_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerGrimoireOfSacrifice",
          spellId = 108503,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},

			CD: core.Cooldown{
				Timer:    warlock.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        Initialize_FelArmor = {
          sourceFile = "extern/wowsims-mop/sim/warlock/warlock.go",
          registrationType = "RegisterAura",
          functionName = "Initialize",
          spellId = 104938,
          label = "Fel Armor"
        }
      },
      destruction = {
        registerFireAndBrimstoneIncinerate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone_incinerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireAndBrimstoneIncinerate",
          spellId = 114654,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellFaBIncinerate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        ApplyChaoticEnergy_ChaoticEnergy = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/chaotic_energy.go",
          registrationType = "RegisterAura",
          functionName = "ApplyChaoticEnergy",
          label = "Chaotic Energy"
        },
        registerImmolate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolate",
          spellId = 348,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellImmolate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerImmolate_ImmolateDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolate",
          spellId = 348,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "warlock.WarlockSpellImmolateDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          label = "Immolate (DoT)"
        },
        registerShadowBurnSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/shadowburn.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBurnSpell",
          spellId = 17877,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellShadowBurn",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerIncinerate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/incinerate.go",
          registrationType = "RegisterSpell",
          functionName = "registerIncinerate",
          spellId = 29722,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellIncinerate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destro.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerChaosBolt_ChaosboltDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/chaos_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerChaosBolt",
          spellId = 116858,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 3000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellChaosBolt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destro.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Chaosbolt (DoT)"
        },
        registerRainOfFire_RainofFireDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/rain_of_fire.go",
          registrationType = "RegisterSpell",
          functionName = "registerRainOfFire",
          spellId = 104232,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellRainOfFire",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Rain of Fire (DoT)"
        },
        registerFireAndBrimstoneImmolate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone_immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireAndBrimstoneImmolate",
          spellId = 108686,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
			ModifyCast: func(sim *core.Simulation, _ *core.Spell, _ *core.Cast) {
				if !destruction.FABAura.IsActive() {
					destruction.FABAura.Activate(sim)
				}
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellImmolate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireAndBrimstoneImmolate_FABImmolateDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone_immolate.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireAndBrimstoneImmolate",
          spellId = 108686,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "warlock.WarlockSpellImmolateDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          label = "FAB - Immolate (DoT)"
        },
        registerFireAndBrimstoneConflagrate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone_conflagrate.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireAndBrimstoneConflagrate",
          spellId = 108685,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellFaBConflagrate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerConflagrate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/conflagrate.go",
          registrationType = "RegisterSpell",
          functionName = "registerConflagrate",
          spellId = 17962,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellConflagrate",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0",
          CritMultiplier = "destruction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        ApplyMastery_MasteryEmberstorm = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/emberstorm.go",
          registrationType = "RegisterAura",
          functionName = "ApplyMastery",
          label = "Mastery: Emberstorm"
        },
        registerBackdraft_Backdraft = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/backdraft.go",
          registrationType = "RegisterAura",
          functionName = "registerBackdraft",
          spellId = 117828,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Backdraft"
        },
        registerFireAndBrimstone_FireandBrimstone = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone.go",
          registrationType = "RegisterAura",
          functionName = "registerFireAndBrimstone",
          spellId = 108683,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Fire and Brimstone"
        },
        registerFireAndBrimstone_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/fire_and_brimstone.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireAndBrimstone",
          spellId = 108683,
          cast = [[{
			DefaultCast: core.Cast{NonEmpty: true},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellFireAndBrimstone",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerDarkSoulInstability_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/destruction/dark_soul_instability.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarkSoulInstability",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 113858,
          cast = [[{
			DefaultCast: core.Cast{NonEmpty: true},
			CD: core.Cooldown{
				Timer:    destruction.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          ClassSpellMask = "warlock.WarlockSpellDarkSoulInsanity",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          RelatedSelfBuff = "buff.Aura"
        }
      },
      demonology = {
        registerHandOfGuldan_Shadowflame = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/hand_of_guldan.go",
          registrationType = "RegisterSpell",
          functionName = "registerHandOfGuldan",
          spellId = 47960,
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warlock.WarlockSpellShadowflameDot",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Shadowflame"
        },
        registerHandOfGuldan_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/hand_of_guldan.go",
          registrationType = "RegisterSpell",
          functionName = "registerHandOfGuldan",
          spellId = 105174,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellHandOfGuldan",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerImmolationAura_ImmolationAuraDoT = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/immolation_aura.go",
          registrationType = "RegisterSpell",
          functionName = "registerImmolationAura",
          spellId = 104025,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL | core.SpellFlagNoMetrics",
          ClassSpellMask = "warlock.WarlockSpellImmolationAura",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Immolation Aura (DoT)"
        },
        registerDoom_Doom = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/doom.go",
          registrationType = "RegisterSpell",
          functionName = "registerDoom",
          spellId = 603,
          cast = "{DefaultCast: core.Cast{GCD: core.GCDDefault}}",
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellDoom",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Doom"
        },
        registerVoidRay_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/void_ray.go",
          registrationType = "RegisterSpell",
          functionName = "registerVoidRay",
          spellId = 115422,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellVoidray",
          SpellSchool = "core.SpellSchoolShadowFlame",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1.0",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerImpSwarm_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/glyphs.go",
          registrationType = "RegisterSpell",
          functionName = "registerImpSwarm",
          spellId = 104316,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
			CD: core.Cooldown{
				Timer:    demo.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1"
        },
        registerFireboltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/wild_imp.go",
          registrationType = "RegisterSpell",
          functionName = "registerFireboltSpell",
          spellId = 104318,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      time.Second * 1,
				CastTime: time.Second * 2,
			},
		}]],
          ClassSpellMask = "warlock.WarlockSpellImpFireBolt",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerWildImpPassive_WildImpController = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/wild_imp.go",
          registrationType = "RegisterAura",
          functionName = "registerWildImpPassive",
          label = "Wild Imp - Controller"
        },
        registerChaosWave_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/chaos_wave.go",
          registrationType = "RegisterSpell",
          functionName = "registerChaosWave",
          spellId = 124916,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellChaosWave",
          SpellSchool = "core.SpellSchoolChaos",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCarrionSwarm_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/carrion_swarm.go",
          registrationType = "RegisterSpell",
          functionName = "registerCarrionSwarm",
          spellId = 103967,
          cast = [[{
			DefaultCast: core.Cast{
				GCDMin: time.Millisecond * 500,
				GCD:    time.Millisecond * 1000,
			},
			CD: core.Cooldown{
				Timer:    demonology.NewTimer(),
				Duration: time.Second * 12,
			},
		}]],
          cooldown = {
            raw = "time.Second * 12",
            seconds = 12
          },
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellCarrionSwarm",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShadowBolt_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/shadowbolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerShadowBolt",
          spellId = 686,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellShadowBolt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMetamorphosis_Metamorphosis = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/metamorphosis.go",
          registrationType = "RegisterAura",
          functionName = "registerMetamorphosis",
          spellId = 103958,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Metamorphosis"
        },
        registerMetamorphosis_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/metamorphosis.go",
          registrationType = "RegisterSpell",
          functionName = "registerMetamorphosis",
          spellId = 103958,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},

			CD: core.Cooldown{
				Timer:    demo.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagNoOnCastComplete",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "metaAura"
        },
        registerFelguardWithName_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/fel_guard.go",
          registrationType = "RegisterSpell",
          functionName = "registerFelguardWithName",
          spellId = 89751,
          cast = [[{
				CD: core.Cooldown{
					Timer:    demo.NewTimer(),
					Duration: time.Second * 45,
				},
			}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagNoMetrics",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerTouchOfChaos_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/touch_of_chaos.go",
          registrationType = "RegisterSpell",
          functionName = "registerTouchOfChaos",
          spellId = 103964,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellTouchOfChaos",
          SpellSchool = "core.SpellSchoolChaos",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSoulfire_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/soulfire.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulfire",
          spellId = 6353,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 4 * time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellSoulFire",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "demonology.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDarksoulKnowledge_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/darksoul_knowledge.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarksoulKnowledge",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 113861,
          cast = [[{
			DefaultCast: core.Cast{NonEmpty: true},
			CD: core.Cooldown{
				Timer:    demonology.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          ClassSpellMask = "warlock.WarlockSpellDarkSoulKnowledge",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          RelatedSelfBuff = "buff.Aura"
        },
        registerGrimoireOfSupremacy_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerGrimoireOfSupremacy",
          spellId = 115625,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second * 1,
			},
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellFelGuardLegionStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "2",
          ThreatMultiplier = "1"
        },
        registerMoltenCore_DemonicCore = {
          sourceFile = "extern/wowsims-mop/sim/warlock/demonology/molten_core.go",
          registrationType = "RegisterAura",
          functionName = "registerMoltenCore",
          spellId = 122355,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Demonic Core"
        }
      },
      affliction = {
        registerHaunt_Haunt = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/haunt.go",
          registrationType = "RegisterAura",
          functionName = "registerHaunt",
          spellId = 48181,
          auraDuration = {
            raw = "8 * time.Second",
            seconds = 8
          },
          label = "Haunt-"
        },
        registerHaunt_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/haunt.go",
          registrationType = "RegisterSpell",
          functionName = "registerHaunt",
          spellId = 48181,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellHaunt",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDrainSoul_DrainSoul = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/drain_soul.go",
          registrationType = "RegisterSpell",
          functionName = "registerDrainSoul",
          spellId = 1120,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagChanneled",
          ClassSpellMask = "warlock.WarlockSpellDrainSoul",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "DrainSoul"
        },
        registerAgony_Agony = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/agony.go",
          registrationType = "RegisterSpell",
          functionName = "registerAgony",
          spellId = 980,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellAgony",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Agony"
        },
        registerSoulburn_Soulburn = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/soulburn.go",
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
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/soulburn.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulburn",
          spellId = 74434,
          cast = [[{
			CD: core.Cooldown{
				Timer:    affliction.NewTimer(),
				Duration: time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Second",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellSoulBurn",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerSeed_1 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/seed_of_corruption.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeed",
          spellId = 27243,
          tag = 1,
          Flags = "core.SpellFlagAoE | core.SpellFlagPassiveSpell",
          ClassSpellMask = "warlock.WarlockSpellSeedOfCorruptionExposion",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSeed_Seed = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/seed_of_corruption.go",
          registrationType = "RegisterSpell",
          functionName = "registerSeed",
          spellId = 27243,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 2000 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellSeedOfCorruption",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Seed"
        },
        registerNightfall_ShadowTrance = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/nightfall.go",
          registrationType = "RegisterAura",
          functionName = "registerNightfall",
          spellId = 17941,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Shadow Trance"
        },
        registerDarkSoulMisery_DarkSoulMisery = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/darksoul_misery.go",
          registrationType = "RegisterAura",
          functionName = "registerDarkSoulMisery",
          spellId = 113860,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Dark Soul: Misery"
        },
        registerDarkSoulMisery_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/darksoul_misery.go",
          registrationType = "RegisterSpell",
          functionName = "registerDarkSoulMisery",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = "core.CooldownPriorityDefault"
          },
          spellId = 113860,
          cast = [[{
			DefaultCast: core.Cast{NonEmpty: true},
			CD: core.Cooldown{
				Timer:    affliction.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          ClassSpellMask = "warlock.WarlockSpellDarkSoulMisery",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          RelatedSelfBuff = "buff"
        },
        registerUnstableAffliction_UnstableAffliction = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/unstable_affliction.go",
          registrationType = "RegisterSpell",
          functionName = "registerUnstableAffliction",
          spellId = 30108,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: 1500 * time.Millisecond,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "warlock.WarlockSpellUnstableAffliction",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "UnstableAffliction"
        },
        registerSoulSwap_SoulSwap = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/soul_swap.go",
          registrationType = "RegisterAura",
          functionName = "registerSoulSwap",
          spellId = 86211,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Soul Swap"
        },
        registerSoulSwap_2 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/soul_swap.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulSwap",
          spellId = 86213,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSoulSwap_3 = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/soul_swap.go",
          registrationType = "RegisterSpell",
          functionName = "registerSoulSwap",
          spellId = 86121,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerMaleficGrasp_MaleficGrasp = {
          sourceFile = "extern/wowsims-mop/sim/warlock/affliction/malefic_grasp.go",
          registrationType = "RegisterSpell",
          functionName = "registerMaleficGrasp",
          spellId = 103103,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagChanneled",
          ClassSpellMask = "warlock.WarlockSpellMaleficGrasp",
          SpellSchool = "core.SpellSchoolShadow",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "affliction.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "MaleficGrasp"
        }
      },
      paladin = {
        registerCrusaderStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/crusader_strike.go",
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
				Duration: time.Millisecond * 4500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 4500",
            seconds = 4
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskCrusaderStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.25",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerLayOnHands_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/lay_on_hands.go",
          registrationType = "RegisterSpell",
          functionName = "registerLayOnHands",
          spellId = 633,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute * 10,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 10",
            seconds = 600
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagIgnoreModifiers",
          ClassSpellMask = "SpellMaskLayOnHands",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "0",
          ThreatMultiplier = "1"
        },
        registerHammerOfWrath_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/hammer_of_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfWrath",
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
          ProcMask = "core.ProcMaskRangedSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSealOfTruth_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31803,
          tag = 1,
          Flags = "core.SpellFlagNoMetrics | core.SpellFlagNoLogs | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskProc"
        },
        registerSealOfTruth_CensureDoT = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31803,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskCensure",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Censure (DoT)"
        },
        registerSealOfTruth_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 42463,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskSealOfTruth",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0.12",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfTruth_SealofTruth = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfTruth",
          spellId = 31801,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seal of Truth"
        },
        registerSealOfTruth_5 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_truth.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfTruth",
          spellId = 31801,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0",
          IgnoreHaste = "true"
        },
        registerSealOfInsight_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfInsight",
          spellId = 20167,
          Flags = "core.SpellFlagHelpful | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskSealOfInsight",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "0",
          ThreatMultiplier = "1"
        },
        registerSealOfInsight_SealofInsight = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfInsight",
          spellId = 20165,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seal of Insight"
        },
        registerSealOfInsight_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_insight.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfInsight",
          spellId = 20165,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0",
          IgnoreHaste = "true"
        },
        registerFlashOfLight_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/flash_of_light.go",
          registrationType = "RegisterSpell",
          functionName = "registerFlashOfLight",
          spellId = 19750,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "SpellMaskFlashOfLight",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerGlyphOfAvengingWrath_GlyphofAvengingWrath = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfAvengingWrath",
          spellId = 115547,
          auraDuration = {
            raw = "core.DurationFromSeconds(core.TernaryFloat64(paladin.Talents.SanctifiedWrath",
            seconds = nil
          },
          label = "Glyph of Avenging Wrath"
        },
        registerGlyphOfBurdenOfGuilt_BurdenofGuilt = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfBurdenOfGuilt",
          spellId = 110300,
          auraDuration = {
            raw = "time.Second * 2",
            seconds = 2
          },
          label = "Burden of Guilt"
        },
        registerGlyphOfDazingShield_DazedAvengersShield = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDazingShield",
          spellId = 63529,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Dazed - Avenger's Shield"
        },
        registerGlyphOfDenounce_GlyphofDenounce = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDenounce",
          spellId = 115654,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Glyph of Denounce"
        },
        registerGlyphOfDevotionAura_GlyphofDevotionAura = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDevotionAura",
          spellId = 146955,
          label = "Glyph of Devotion Aura"
        },
        registerGlyphOfDivinePlea_GlyphofDivinePlea = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDivinePlea",
          spellId = 63223,
          label = "Glyph of Divine Plea"
        },
        registerGlyphOfDivinity_GlyphofDivinity = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDivinity",
          spellId = 54939,
          label = "Glyph of Divinity"
        },
        registerGlyphOfDoubleJeopardy_GlyphofDoubleJeopardy = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfDoubleJeopardy",
          spellId = 121027,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Glyph of Double Jeopardy"
        },
        registerGlyphOfFlashOfLight_GlyphofFlashofLight = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfFlashOfLight",
          spellId = 54957,
          auraDuration = {
            raw = "time.Second * 7",
            seconds = 7
          },
          label = "Glyph of Flash of Light"
        },
        registerGlyphOfFocusedShield_GlyphofFocusedShield = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfFocusedShield",
          spellId = 54930,
          label = "Glyph of Focused Shield"
        },
        registerGlyphOfHarshWords_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterSpell",
          functionName = "registerGlyphOfHarshWords",
          spellId = 130552,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.TernaryDuration(isProt, 0, core.GCDDefault),
				NonEmpty: isProt,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Millisecond * 1500,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				paladin.DynamicHolyPowerSpent = paladin.SpendableHolyPower()
				spell.SetMetricsSplit(paladin.DynamicHolyPowerSpent)
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHarshWords",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerGlyphOfHolyShock_GlyphofHolyShock = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfHolyShock",
          spellId = 63224,
          label = "Glyph of Holy Shock"
        },
        registerGlyphOfImmediateTruth_GlyphofImmediateTruth = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfImmediateTruth",
          spellId = 115546,
          label = "Glyph of Immediate Truth"
        },
        registerGlyphOfLightOfDawn_GlyphofLightofDawn = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfLightOfDawn",
          spellId = 54940,
          label = "Glyph of Light of Dawn"
        },
        registerGlyphOfMassExorcism_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterSpell",
          functionName = "registerGlyphOfMassExorcism",
          spellId = 879,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete | core.SpellFlagAoE",
          ClassSpellMask = "SpellMaskExorcism",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0.25",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerGlyphOfProtectorOfTheInnocent_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterSpell",
          functionName = "registerGlyphOfProtectorOfTheInnocent",
          spellId = 115536,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful | core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "0.2",
          ThreatMultiplier = "1"
        },
        registerGlyphOfTemplarsVerdict_GlyphofTemplarsVerdict = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfTemplarsVerdict",
          spellId = 115668,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Glyph of Templar's Verdict"
        },
        registerGlyphOfTheAlabasterShield_AlabasterShield = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfTheAlabasterShield",
          spellId = 121467,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Alabaster Shield"
        },
        registerGlyphOfTheBattleHealer_GlyphoftheBattleHealer = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfTheBattleHealer",
          spellId = 119477,
          label = "Glyph of the Battle Healer"
        },
        registerGlyphOfWordOfGlory_GlyphofWordofGlory = {
          sourceFile = "extern/wowsims-mop/sim/paladin/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "registerGlyphOfWordOfGlory",
          spellId = 115522,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Glyph of Word of Glory"
        },
        registerAvengingWrath_AvengingWrath = {
          sourceFile = "extern/wowsims-mop/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterAura",
          functionName = "registerAvengingWrath",
          spellId = 31884,
          auraDuration = {
            raw = "core.DurationFromSeconds(core.TernaryFloat64(paladin.Talents.SanctifiedWrath",
            seconds = nil
          },
          label = "Avenging Wrath"
        },
        registerAvengingWrath_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/avenging_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvengingWrath",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
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
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskAvengingWrath",
          RelatedSelfBuff = "paladin.AvengingWrathAura"
        },
        registerHammerOfTheRighteous_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/hammer_of_the_righteous.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfTheRighteous",
          spellId = 88263,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagAoE",
          ClassSpellMask = "SpellMaskHammerOfTheRighteousAoe",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0.35",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerHammerOfTheRighteous_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/hammer_of_the_righteous.go",
          registrationType = "RegisterSpell",
          functionName = "registerHammerOfTheRighteous",
          spellId = 53595,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    paladin.BuilderCooldown(),
				Duration: time.Millisecond * 4500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 4500",
            seconds = 4
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHammerOfTheRighteousMelee",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.2",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerDivineProtection_DivineProtection = {
          sourceFile = "extern/wowsims-mop/sim/paladin/divine_protection.go",
          registrationType = "RegisterAura",
          functionName = "registerDivineProtection",
          spellId = 498,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Divine Protection"
        },
        registerDivineProtection_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/divine_protection.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineProtection",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = "core.CooldownPriorityLow + 30"
          },
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskDivineProtection"
        },
        func_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/items.go",
          registrationType = "RegisterSpell",
          functionName = "func",
          spellId = 85256,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "SpellMaskTemplarsVerdict",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.75",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerHolyGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyGuardian",
          spellId = 86669,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerHolyGuardian_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyGuardian",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 86669,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskGuardianOfAncientKings"
        },
        registerProtectionGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerProtectionGuardian",
          spellId = 86659,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerProtectionGuardian_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerProtectionGuardian",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = "core.CooldownPriorityLow + 20"
          },
          spellId = 86659,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskGuardianOfAncientKings"
        },
        registerRetributionGuardian_AncientPower = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
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
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerRetributionGuardian",
          spellId = 86704,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagReadinessTrinket",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerRetributionGuardian_GuardianofAncientKings = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterAura",
          functionName = "registerRetributionGuardian",
          spellId = 86698,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Guardian of Ancient Kings"
        },
        registerRetributionGuardian_4 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/guardian_of_ancient_kings.go",
          registrationType = "RegisterSpell",
          functionName = "registerRetributionGuardian",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 86698,
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
          ClassSpellMask = "SpellMaskGuardianOfAncientKings",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "paladin.GoakAura"
        },
        registerHolyVariant_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/ancient_guardian_pet.go",
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
        registerJudgment_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/judgment.go",
          registrationType = "RegisterSpell",
          functionName = "registerJudgment",
          spellId = 20271,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskJudgment",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSanctityOfBattle_SanctityofBattle = {
          sourceFile = "extern/wowsims-mop/sim/paladin/sanctity_of_battle.go",
          registrationType = "RegisterAura",
          functionName = "registerSanctityOfBattle",
          spellId = 25956,
          label = "Sanctity of Battle"
        },
        registerSealOfRighteousness_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousness",
          spellId = 101423,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagAoE",
          ClassSpellMask = "SpellMaskSealOfRighteousness",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeProc",
          DamageMultiplier = "0.09",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfRighteousness_SealofRighteousness = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfRighteousness",
          spellId = 20154,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seal of Righteousness"
        },
        registerSealOfRighteousness_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/seal_of_righteousness.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfRighteousness",
          spellId = 20154,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0",
          IgnoreHaste = "true"
        },
        registerSpeedOfLight_SpeedofLight = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSpeedOfLight",
          spellId = 85499,
          auraDuration = {
            raw = "time.Second * 8",
            seconds = 8
          },
          label = "Speed of Light"
        },
        registerSpeedOfLight_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerSpeedOfLight",
          spellId = 85499,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Second * 45,
			},
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          RelatedSelfBuff = "speedOfLightAura"
        },
        registerLongArmOfTheLaw_LongArmoftheLaw = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerLongArmOfTheLaw",
          spellId = 87173,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Long Arm of the Law"
        },
        registerPursuitOfJustice_PursuitofJustice = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPursuitOfJustice",
          spellId = 114695,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Pursuit of Justice"
        },
        registerSelflessHealer_SelflessHealer = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSelflessHealer",
          spellId = 114250,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Selfless Healer"
        },
        registerHandOfPurity_HandofPurity = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerHandOfPurity",
          spellId = 114039,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Hand of Purity"
        },
        registerHandOfPurity_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerHandOfPurity",
          spellId = 114039,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          IgnoreHaste = "true"
        },
        registerUnbreakableSpirit_UnbreakableSpirit = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerUnbreakableSpirit",
          spellId = 114154,
          label = "Unbreakable Spirit"
        },
        registerHolyAvenger_HolyAvenger = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerHolyAvenger",
          spellId = 105809,
          auraDuration = {
            raw = "time.Second * 18",
            seconds = 18
          },
          label = "Holy Avenger"
        },
        registerHolyAvenger_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyAvenger",
          spellId = 105809,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "holyAvengerAura"
        },
        registerSanctifiedWrath_SanctifiedWrath = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerSanctifiedWrath",
          spellId = 114232,
          auraDuration = {
            raw = "time.Second * 30",
            seconds = 30
          },
          label = "Sanctified Wrath"
        },
        registerLightsHammer_ArcingLightDamage = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightsHammer",
          spellId = 114919,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagAoE",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Arcing Light (Damage)"
        },
        registerLightsHammer_ArcingLightHealing = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightsHammer",
          spellId = 119952,
          Flags = "core.SpellFlagPassiveSpell | core.SpellFlagHelpful",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "paladin.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Arcing Light (Healing)"
        },
        registerLightsHammer_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerLightsHammer",
          spellId = 114158,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    paladin.NewTimer(),
				Duration: time.Minute,
			},
		}]],
          cooldown = {
            raw = "time.Minute",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage"
        },
        registerForbearance_Forbearance = {
          sourceFile = "extern/wowsims-mop/sim/paladin/forbearance.go",
          registrationType = "RegisterAura",
          functionName = "registerForbearance",
          spellId = 25771,
          auraDuration = {
            raw = "time.Second * 60",
            seconds = 60
          },
          label = "Forbearance"
        }
      },
      retribution = {
        registerSealOfJustice_SealofJustice = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/seal_of_justice.go",
          registrationType = "RegisterAura",
          functionName = "registerSealOfJustice",
          spellId = 20164,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seal of Justice"
        },
        registerSealOfJustice_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/seal_of_justice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfJustice",
          spellId = 20170,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell",
          ClassSpellMask = "paladin.SpellMaskSealOfJustice",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeProc",
          DamageMultiplier = "0.2",
          CritMultiplier = "ret.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSealOfJustice_4 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/seal_of_justice.go",
          registrationType = "RegisterSpell",
          functionName = "registerSealOfJustice",
          spellId = 20164,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "0",
          IgnoreHaste = "true"
        },
        registerSwordOfLight_SwordofLight = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/sword_of_light.go",
          registrationType = "RegisterAura",
          functionName = "registerSwordOfLight",
          spellId = 53503,
          label = "Sword of Light"
        },
        registerSwordOfLight_SwordofLightManaRegen = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/sword_of_light.go",
          registrationType = "RegisterAura",
          functionName = "registerSwordOfLight",
          label = "Sword of Light Mana Regen"
        },
        registerMastery_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/mastery.go",
          registrationType = "RegisterSpell",
          functionName = "registerMastery",
          spellId = 96172,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreModifiers | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.0",
          CritMultiplier = "0.0",
          ThreatMultiplier = "1.0"
        },
        registerHotfixPassive_HotfixPassive = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/hotfix_passive.go",
          registrationType = "RegisterAura",
          functionName = "registerHotfixPassive",
          label = "Hotfix Passive"
        },
        registerArtOfWar_TheArtOfWar = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/the_art_of_war.go",
          registrationType = "RegisterAura",
          functionName = "registerArtOfWar",
          spellId = 59578,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "The Art Of War"
        },
        registerTemplarsVerdict_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/templars_verdict.go",
          registrationType = "RegisterSpell",
          functionName = "registerTemplarsVerdict",
          spellId = 85256,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "paladin.SpellMaskTemplarsVerdict",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.75",
          CritMultiplier = "ret.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExorcism_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/exorcism.go",
          registrationType = "RegisterSpell",
          functionName = "registerExorcism",
          spellId = 879,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    ret.NewTimer(),
				Duration: time.Second * 15,
			},
		}]],
          cooldown = {
            raw = "time.Second * 15",
            seconds = 15
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "paladin.SpellMaskExorcism",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "ret.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDivineStorm_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/divine_storm.go",
          registrationType = "RegisterSpell",
          functionName = "registerDivineStorm",
          spellId = 53385,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagAoE",
          ClassSpellMask = "paladin.SpellMaskDivineStorm",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "ret.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerInquisition_Inquisition = {
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/inquisition.go",
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
          sourceFile = "extern/wowsims-mop/sim/paladin/retribution/inquisition.go",
          registrationType = "RegisterSpell",
          functionName = "registerInquisition",
          spellId = 84963,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				ret.DynamicHolyPowerSpent = ret.SpendableHolyPower()
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "paladin.SpellMaskInquisition",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskEmpty",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "inquisitionAura"
        }
      },
      protection = {
        registerAvengersShieldSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/avengers_shield.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvengersShieldSpell",
          spellId = 31935,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
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
          ClassSpellMask = "paladin.SpellMaskAvengersShield",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "prot.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerConsecrationSpell_Consecration = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/consecration.go",
          registrationType = "RegisterSpell",
          functionName = "registerConsecrationSpell",
          spellId = 26573,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    prot.NewTimer(),
				Duration: 9 * time.Second,
			},
		}]],
          cooldown = {
            raw = "9 * time.Second",
            seconds = 9
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagAoE",
          ClassSpellMask = "paladin.SpellMaskConsecration",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "prot.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Consecration"
        },
        registerShieldOfTheRighteous_BastionofGlory = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/shield_of_the_righteous.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldOfTheRighteous",
          spellId = 114637,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Bastion of Glory"
        },
        registerShieldOfTheRighteous_ShieldoftheRighteous = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/shield_of_the_righteous.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldOfTheRighteous",
          spellId = 132403,
          auraDuration = {
            raw = "time.Second * 3",
            seconds = 3
          },
          label = "Shield of the Righteous"
        },
        registerShieldOfTheRighteous_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/shield_of_the_righteous.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldOfTheRighteous",
          spellId = 53600,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    prot.NewTimer(),
				Duration: time.Millisecond * 1500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "paladin.SpellMaskShieldOfTheRighteous",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "prot.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "shieldOfTheRighteousAura"
        },
        registerMastery_MasteryDivineBulwark = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/mastery.go",
          registrationType = "RegisterAura",
          functionName = "registerMastery",
          spellId = 76671,
          label = "Mastery: Divine Bulwark"
        },
        registerRighteousFury_RighteousFury = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/righteous_fury.go",
          registrationType = "RegisterAura",
          functionName = "registerRighteousFury",
          spellId = 25780,
          label = "Righteous Fury"
        },
        registerHolyWrath_1 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/holy_wrath.go",
          registrationType = "RegisterSpell",
          functionName = "registerHolyWrath",
          spellId = 119072,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    prot.NewTimer(),
				Duration: 9 * time.Second,
			},
		}]],
          cooldown = {
            raw = "9 * time.Second",
            seconds = 9
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "paladin.SpellMaskHolyWrath",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "prot.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSanctuary_Sanctuary = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/sanctuary.go",
          registrationType = "RegisterAura",
          functionName = "registerSanctuary",
          spellId = 105805,
          label = "Sanctuary"
        },
        registerArdentDefender_ArdentDefender = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/ardent_defender.go",
          registrationType = "RegisterAura",
          functionName = "registerArdentDefender",
          spellId = 31850,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Ardent Defender"
        },
        registerArdentDefender_2 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/ardent_defender.go",
          registrationType = "RegisterSpell",
          functionName = "registerArdentDefender",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = "core.CooldownPriorityLow + 10"
          },
          spellId = 31850,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    prot.NewTimer(),
				Duration: time.Minute * 3,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "paladin.SpellMaskArdentDefender",
          SpellSchool = "core.SpellSchoolHoly",
          RelatedSelfBuff = "adAura"
        },
        registerArdentDefender_3 = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/ardent_defender.go",
          registrationType = "RegisterSpell",
          functionName = "registerArdentDefender",
          spellId = 66235,
          Flags = "core.SpellFlagHelpful | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolHoly",
          ProcMask = "core.ProcMaskSpellHealing",
          DamageMultiplier = "1",
          CritMultiplier = "1",
          ThreatMultiplier = "0"
        },
        registerGrandCrusader_GrandCrusader = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/grand_crusader.go",
          registrationType = "RegisterAura",
          functionName = "registerGrandCrusader",
          spellId = 85416,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Grand Crusader"
        },
        trackDamageTakenLastGlobal_DamageTakenLastGlobal = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/protection.go",
          registrationType = "RegisterAura",
          functionName = "trackDamageTakenLastGlobal",
          label = "Damage Taken Last Global"
        },
        registerGuardedByTheLight_GuardedbytheLight = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/guarded_by_the_light.go",
          registrationType = "RegisterAura",
          functionName = "registerGuardedByTheLight",
          spellId = 53592,
          label = "Guarded by the Light"
        },
        registerGuardedByTheLight_GuardedbytheLightManaRegen = {
          sourceFile = "extern/wowsims-mop/sim/paladin/protection/guarded_by_the_light.go",
          registrationType = "RegisterAura",
          functionName = "registerGuardedByTheLight",
          label = "Guarded by the Light Mana Regen"
        },
        registerRevenge_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/revenge.go",
          registrationType = "RegisterSpell",
          functionName = "registerRevenge",
          spellId = 6572,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 9,
			},
		}]],
          cooldown = {
            raw = "time.Second * 9",
            seconds = 9
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskRevenge",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerLastStand_LastStand = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/last_stand.go",
          registrationType = "RegisterAura",
          functionName = "registerLastStand",
          spellId = 12975,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Last Stand"
        },
        registerLastStand_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/last_stand.go",
          registrationType = "RegisterSpell",
          functionName = "registerLastStand",
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
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "warrior.SpellMaskLastStand"
        },
        registerShieldBlock_ShieldBlock = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/shield_block.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldBlock",
          spellId = 2565,
          auraDuration = {
            raw = "time.Second * 6",
            seconds = 6
          },
          label = "Shield Block"
        },
        registerShieldBlock_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/shield_block.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldBlock",
          spellId = 2565,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Millisecond * 1500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "warrior.SpellMaskShieldBlock",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerShieldBarrier_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/shield_barrier.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldBarrier",
          spellId = 112048,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Millisecond * 1500,
			},
		}]],
          cooldown = {
            raw = "time.Millisecond * 1500",
            seconds = 1
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "warrior.SpellMaskShieldBarrier",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          RelatedSelfBuff = "war.ShieldBarrierAura.Aura",
          IgnoreHaste = "true"
        },
        registerUnwaveringSentinel_UnwaveringSentinel = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerUnwaveringSentinel",
          spellId = 29144,
          label = "Unwavering Sentinel"
        },
        registerBastionOfDefense_BastionofDefense = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerBastionOfDefense",
          spellId = 84608,
          label = "Bastion of Defense"
        },
        registerSwordAndBoard_SwordandBoard = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSwordAndBoard",
          spellId = 46953,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Sword and Board"
        },
        registerRiposte_Ultimatum = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerRiposte",
          spellId = 122510,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Ultimatum"
        },
        registerShieldSlam_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/shield_slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldSlam",
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskShieldSlam",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerMastery_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/protection.go",
          registrationType = "RegisterSpell",
          functionName = "registerMastery",
          spellId = 76857,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete"
        },
        applyHeavyRepercussions_HeavyRepercussions = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applyHeavyRepercussions",
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Heavy Repercussions"
        },
        applySwordAndBoard_SwordandBoard = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/_talents.go",
          registrationType = "RegisterAura",
          functionName = "applySwordAndBoard",
          spellId = 50227,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Sword and Board"
        },
        registerDemoralizingShout_DemoralizingShout = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/demoralizing_shout.go",
          registrationType = "RegisterAura",
          functionName = "registerDemoralizingShout",
          spellId = 125565,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Demoralizing Shout"
        },
        registerDemoralizingShout_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/demoralizing_shout.go",
          registrationType = "RegisterSpell",
          functionName = "registerDemoralizingShout",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 1160,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Duration: time.Minute * 1,
				Timer:    war.NewTimer(),
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "warrior.SpellMaskDemoralizingShout",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          IgnoreHaste = "true"
        },
        registerDevastate_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/protection/devastate.go",
          registrationType = "RegisterSpell",
          functionName = "registerDevastate",
          spellId = 20243,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskDevastate",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.2",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      holy = {
        registerHotfixPassive_HotfixPassive = {
          sourceFile = "extern/wowsims-mop/sim/paladin/holy/hotfix_passive.go",
          registrationType = "RegisterAura",
          functionName = "registerHotfixPassive",
          label = "Hotfix Passive"
        }
      },
      mage = {
        registerArmorSpells_MoltenArmor = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterAura",
          functionName = "registerArmorSpells",
          spellId = 30482,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Molten Armor"
        },
        registerArmorSpells_2 = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmorSpells",
          spellId = 30482,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "MageSpellMoltenArmor",
          SpellSchool = "core.SpellSchoolFire"
        },
        registerArmorSpells_MageArmor = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterAura",
          functionName = "registerArmorSpells",
          spellId = 6117,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Mage Armor"
        },
        registerArmorSpells_4 = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmorSpells",
          spellId = 6117,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "MageSpellMageArmor",
          SpellSchool = "core.SpellSchoolArcane"
        },
        registerArmorSpells_FrostArmor = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterAura",
          functionName = "registerArmorSpells",
          spellId = 7302,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Frost Armor"
        },
        registerArmorSpells_6 = {
          sourceFile = "extern/wowsims-mop/sim/mage/armors.go",
          registrationType = "RegisterSpell",
          functionName = "registerArmorSpells",
          spellId = 7302,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 3,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagHelpful",
          ClassSpellMask = "MageSpellFrostArmor",
          SpellSchool = "core.SpellSchoolFrost"
        },
        registerArcaneExplosionSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/_arcane_explosion.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneExplosionSpell",
          spellId = 1449,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellArcaneExplosion",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1 - 0.4*float64(mage.Talents.ImprovedArcaneExplosion)"
        },
        registerIcyVeinsCD_IcyVeins = {
          sourceFile = "extern/wowsims-mop/sim/mage/icy_veins.go",
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
          sourceFile = "extern/wowsims-mop/sim/mage/icy_veins.go",
          registrationType = "RegisterSpell",
          functionName = "registerIcyVeinsCD",
          spellId = 12472,
          cast = [[{
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 3,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellIcyVeins"
        },
        registerMirrorImageCD_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/mirror_image.go",
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
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellMirrorImage"
        },
        registerFrostboltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostboltSpell",
          spellId = 59638,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Second * 2,
			},
		}]],
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mi.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFireballSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/fireball.go",
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
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneBlastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/mirror_image.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBlastSpell",
          spellId = 88084,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          ClassSpellMask = "MageMirrorImageSpellArcaneBlast",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mi.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneBlastSpell_MirrorImagesArcaneChargesAura = {
          sourceFile = "extern/wowsims-mop/sim/mage/mirror_image.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneBlastSpell",
          spellId = 36032,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Mirror Images: Arcane Charges Aura"
        },
        registerFrostfireBoltSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frostfire_bolt.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostfireBoltSpell",
          spellId = 44614,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2750,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFrostfireBolt",
          SpellSchool = "core.SpellSchoolFire | core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerScorchSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/scorch.go",
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
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerDragonsBreathSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/dragons_breath.go",
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
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellDragonsBreath",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerConeOfColdSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/cone_of_cold.go",
          registrationType = "RegisterSpell",
          functionName = "registerConeOfColdSpell",
          spellId = 120,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: 10 * time.Second,
			},
		}]],
          cooldown = {
            raw = "10 * time.Second",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagAoE",
          ClassSpellMask = "MageSpellConeOfCold",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostBomb_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostBomb",
          spellId = 112948,
          tag = 2,
          Flags = "core.SpellFlagAoE",
          ClassSpellMask = "MageSpellFrostBombExplosion",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerFrostBomb_FrostBomb = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostBomb",
          spellId = 112948,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellFrostBomb",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskEmpty",
          label = "FrostBomb"
        },
        registerFrostMastery_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/icicles.go",
          registrationType = "RegisterSpell",
          functionName = "registerFrostMastery",
          spellId = 148022,
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellIcicle",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1"
        },
        registerFrostMastery_MasteryIcicles = {
          sourceFile = "extern/wowsims-mop/sim/mage/icicles.go",
          registrationType = "RegisterAura",
          functionName = "registerFrostMastery",
          spellId = 148022,
          auraDuration = {
            raw = "time.Hour * 1",
            seconds = 3600
          },
          label = "Mastery: Icicles"
        },
        registerBlizzardSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/blizzard.go",
          registrationType = "RegisterSpell",
          functionName = "registerBlizzardSpell",
          spellId = 42208,
          Flags = "core.SpellFlagAoE",
          ClassSpellMask = "MageSpellBlizzard",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerBlizzardSpell_Blizzard = {
          sourceFile = "extern/wowsims-mop/sim/mage/blizzard.go",
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
        registerLivingBomb_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBomb",
          spellId = 44457,
          tag = 2,
          Flags = "core.SpellFlagAoE | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MageSpellLivingBombExplosion",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLivingBomb_2 = {
          sourceFile = "extern/wowsims-mop/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBomb",
          spellId = 44457,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: time.Second,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerLivingBomb_LivingBomb = {
          sourceFile = "extern/wowsims-mop/sim/mage/living_bomb.go",
          registrationType = "RegisterSpell",
          functionName = "registerLivingBomb",
          spellId = 44457,
          tag = 1,
          ClassSpellMask = "MageSpellLivingBombDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "LivingBomb"
        },
        registerBlastWaveSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/_blast_wave.go",
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
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellBlastWave",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplierAdditive = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerNetherTempest_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/nether_tempest.go",
          registrationType = "RegisterSpell",
          functionName = "registerNetherTempest",
          spellId = 114954,
          ClassSpellMask = "MageSpellNetherTempest",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerNetherTempest_NetherTempest = {
          sourceFile = "extern/wowsims-mop/sim/mage/nether_tempest.go",
          registrationType = "RegisterSpell",
          functionName = "registerNetherTempest",
          spellId = 114923,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MageSpellNetherTempest",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Nether Tempest"
        },
        registerEvocation_Evocation = {
          sourceFile = "extern/wowsims-mop/sim/mage/evocation.go",
          registrationType = "RegisterSpell",
          functionName = "registerEvocation",
          spellId = 12051,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: time.Minute * 2,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 2",
            seconds = 120
          },
          Flags = "core.SpellFlagHelpful | core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "MageSpellEvocation",
          label = "Evocation"
        },
        registerIceLanceSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/ice_lance.go",
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
          DamageMultiplier = "1 * 1.2",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        applyMasterOfElements_MasterofElements = {
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyMasterOfElements",
          label = "Master of Elements"
        },
        applyHotStreak_HotStreak = {
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
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
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyHotStreak",
          spellId = 44448,
          label = "Hot Streak Proc Aura"
        },
        applyPyromaniac_Pyromaniac = {
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
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
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
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
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyMoltenFury",
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Molten Fury"
        },
        applyImpact_Impact = {
          sourceFile = "extern/wowsims-mop/sim/mage/_talents_fire.go",
          registrationType = "RegisterAura",
          functionName = "applyImpact",
          spellId = 64343,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Impact"
        },
        registerDeepFreezeSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/deep_freeze.go",
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
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerManaGems_ReplenishMana = {
          sourceFile = "extern/wowsims-mop/sim/mage/mana_gems.go",
          registrationType = "RegisterAura",
          functionName = "registerManaGems",
          spellId = 5405,
          auraDuration = {
            raw = "6*time.Second + 1",
            seconds = nil
          },
          label = "Replenish Mana"
        },
        registerManaGems_2 = {
          sourceFile = "extern/wowsims-mop/sim/mage/mana_gems.go",
          registrationType = "RegisterSpell",
          functionName = "registerManaGems",
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
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagAPL | core.SpellFlagHelpful"
        },
        registerfrostNovaSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/frost_nova.go",
          registrationType = "RegisterSpell",
          functionName = "registerfrostNovaSpell",
          spellId = 122,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    mage.NewTimer(),
				Duration: 25 * time.Second,
			},
		}]],
          cooldown = {
            raw = "25 * time.Second",
            seconds = 25
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagAoE",
          ClassSpellMask = "MageSpellFrostNova",
          SpellSchool = "core.SpellSchoolFrost",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerPresenceOfMind_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerPresenceOfMind",
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
				Duration: time.Second * 90,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellPresenceOfMind"
        },
        registerPresenceOfMind_PresenceofMind = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerPresenceOfMind",
          spellId = 12043,
          auraDuration = {
            raw = "time.Hour",
            seconds = 3600
          },
          label = "Presence of Mind"
        },
        registerIceFloes_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerIceFloes",
          spellId = 108839,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "MageSpellIceFloes"
        },
        registerIceFloes_IceFloes = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerIceFloes",
          spellId = 108839,
          auraDuration = {
            raw = "time.Second * 15",
            seconds = 15
          },
          label = "Ice Floes"
        },
        registerInvocation_InvocationAura = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerInvocation",
          spellId = 116257,
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Invocation Aura"
        },
        registerRuneOfPower_RuneofPower = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerRuneOfPower",
          spellId = 116011,
          auraDuration = {
            raw = "time.Minute",
            seconds = 60
          },
          label = "Rune of Power"
        },
        registerRuneOfPower_2 = {
          sourceFile = "extern/wowsims-mop/sim/mage/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerRuneOfPower",
          spellId = 116011,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 1500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "MagespellRuneOfPower"
        },
        registerCombustionSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/_combustion.go",
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
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCombustionSpell_CombustionDot = {
          sourceFile = "extern/wowsims-mop/sim/mage/_combustion.go",
          registrationType = "RegisterSpell",
          functionName = "registerCombustionSpell",
          spellId = 11129,
          tag = 1,
          Flags = "core.SpellFlagIgnoreModifiers | core.SpellFlagNoSpellMods | core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "MageSpellCombustion",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Combustion Dot"
        },
        registerFireBlastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/fire_blast.go",
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
          DamageMultiplier = "1",
          CritMultiplier = "mage.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      fire = {
        ApplyTalents_Flashburn = {
          sourceFile = "extern/wowsims-mop/sim/mage/fire/fire.go",
          registrationType = "RegisterAura",
          functionName = "ApplyTalents",
          spellId = 76595,
          label = "Flashburn"
        },
        registerPyroblastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/fire/pyroblast.go",
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
          CritMultiplier = "fire.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerPyroblastSpell_PyroblastDoT = {
          sourceFile = "extern/wowsims-mop/sim/mage/fire/pyroblast.go",
          registrationType = "RegisterSpell",
          functionName = "registerPyroblastSpell",
          spellId = 11366,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagPassiveSpell",
          ClassSpellMask = "mage.MageSpellPyroblastDot",
          SpellSchool = "core.SpellSchoolFire",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "fire.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "PyroblastDoT"
        }
      },
      arcane = {
        registerMastery_ManaAdept = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/mana_adept.go",
          registrationType = "RegisterAura",
          functionName = "registerMastery",
          spellId = 76547,
          label = "Mana Adept"
        },
        registerArcaneBlastSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_blast.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBlastSpell",
          spellId = 30451,
          cast = [[{
			DefaultCast: core.Cast{
				GCD:      core.GCDDefault,
				CastTime: time.Millisecond * 2500,
			},
		}]],
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellArcaneBlast",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * 1.29",
          CritMultiplier = "arcane.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcanePowerCD_ArcanePower = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_power.go",
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
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_power.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcanePowerCD",
          spellId = 12042,
          cast = [[{
			CD: core.Cooldown{
				Timer:    arcane.NewTimer(),
				Duration: time.Second * 90,
			},
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
		}]],
          cooldown = {
            raw = "time.Second * 90",
            seconds = 90
          },
          Flags = "core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "mage.MageSpellArcanePower",
          RelatedSelfBuff = "arcane.arcanePowerAura"
        },
        registerArcaneCharges_ArcaneChargesAura = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_charge.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneCharges",
          spellId = 36032,
          auraDuration = {
            raw = "time.Second * 10",
            seconds = 10
          },
          label = "Arcane Charges Aura"
        },
        registerArcaneMissilesSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 7268,
          tag = 1,
          ClassSpellMask = "mage.MageSpellArcaneMissilesTick",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1",
          CritMultiplier = "arcane.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerArcaneMissilesSpell_ArcaneMissiles = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_missiles.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneMissilesSpell",
          spellId = 7268,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagChanneled | core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellArcaneMissilesCast",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "0",
          label = "ArcaneMissiles"
        },
        registerArcaneMissilesSpell_ArcaneMissilesProc = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_missiles.go",
          registrationType = "RegisterAura",
          functionName = "registerArcaneMissilesSpell",
          spellId = 79683,
          auraDuration = {
            raw = "time.Second * 20",
            seconds = 20
          },
          label = "Arcane Missiles Proc"
        },
        registerArcaneBarrageSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/mage/arcane/arcane_barrage.go",
          registrationType = "RegisterSpell",
          functionName = "registerArcaneBarrageSpell",
          spellId = 44425,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    arcane.NewTimer(),
				Duration: time.Second * 3,
			},
		}]],
          cooldown = {
            raw = "time.Second * 3",
            seconds = 3
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "mage.MageSpellArcaneBarrage",
          SpellSchool = "core.SpellSchoolArcane",
          ProcMask = "core.ProcMaskSpellDamage",
          DamageMultiplier = "1 * 0.19",
          CritMultiplier = "arcane.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        }
      },
      warrior = {
        registerCharge_Charge = {
          sourceFile = "extern/wowsims-mop/sim/warrior/charge.go",
          registrationType = "RegisterAura",
          functionName = "registerCharge",
          spellId = 100,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Charge"
        },
        registerCharge_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/charge.go",
          registrationType = "RegisterSpell",
          functionName = "registerCharge",
          spellId = 100,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 20 * time.Second,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "20 * time.Second",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskCharge",
          SpellSchool = "core.SpellSchoolPhysical",
          IgnoreHaste = "true"
        },
        registerBerserkerRage_BerserkerRage = {
          sourceFile = "extern/wowsims-mop/sim/warrior/berserker_rage.go",
          registrationType = "RegisterAura",
          functionName = "registerBerserkerRage",
          spellId = 18499,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Berserker Rage"
        },
        registerBerserkerRage_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/berserker_rage.go",
          registrationType = "RegisterSpell",
          functionName = "registerBerserkerRage",
          spellId = 18499,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
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
        registerVictoryRush_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/victory_rush.go",
          registrationType = "RegisterSpell",
          functionName = "registerVictoryRush",
          spellId = 34428,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
		}]],
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskImpendingVictory",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerShieldWall_ShieldWall = {
          sourceFile = "extern/wowsims-mop/sim/warrior/shield_wall.go",
          registrationType = "RegisterAura",
          functionName = "registerShieldWall",
          spellId = 871,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Shield Wall"
        },
        registerShieldWall_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/shield_wall.go",
          registrationType = "RegisterSpell",
          functionName = "registerShieldWall",
          majorCooldown = {
            type = "core.CooldownTypeSurvival",
            priority = nil
          },
          spellId = 871,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: cooldownDuration,
			},
		}]],
          cooldown = {
            raw = "cooldownDuration",
            seconds = nil
          },
          Flags = "core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskShieldWall",
          RelatedSelfBuff = "aura",
          IgnoreHaste = "true"
        },
        registerThunderClap_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/thunder_clap.go",
          registrationType = "RegisterSpell",
          functionName = "registerThunderClap",
          spellId = 6343,
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
          Flags = "core.SpellFlagAoE | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskThunderClap",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        applyMajorGlyphs_Incite = {
          sourceFile = "extern/wowsims-mop/sim/warrior/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "applyMajorGlyphs",
          spellId = 84619,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Incite"
        },
        applyMajorGlyphs_RagingWind = {
          sourceFile = "extern/wowsims-mop/sim/warrior/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "applyMajorGlyphs",
          spellId = 84619,
          auraDuration = {
            raw = "6 * time.Second",
            seconds = 6
          },
          label = "Raging Wind"
        },
        applyMajorGlyphs_HoldtheLine = {
          sourceFile = "extern/wowsims-mop/sim/warrior/glyphs.go",
          registrationType = "RegisterAura",
          functionName = "applyMajorGlyphs",
          spellId = 84619,
          auraDuration = {
            raw = "5 * time.Second",
            seconds = 5
          },
          label = "Hold the Line"
        },
        registerSunderArmor_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/sunder_armor.go",
          registrationType = "RegisterSpell",
          functionName = "registerSunderArmor",
          spellId = 7386,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskSunderArmor",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerRecklessness_Recklessness = {
          sourceFile = "extern/wowsims-mop/sim/warrior/recklessness.go",
          registrationType = "RegisterAura",
          functionName = "registerRecklessness",
          spellId = 1719,
          auraDuration = {
            raw = "time.Second * 12",
            seconds = 12
          },
          label = "Recklessness"
        },
        registerRecklessness_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/recklessness.go",
          registrationType = "RegisterSpell",
          functionName = "registerRecklessness",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 1719,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 3,
			},

			SharedCD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 12 * time.Second,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 3",
            seconds = 180
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskRecklessness",
          RelatedSelfBuff = "reckAura"
        },
        registerEnrage_Enrage = {
          sourceFile = "extern/wowsims-mop/sim/warrior/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerEnrage",
          spellId = 12880,
          auraDuration = {
            raw = "duration",
            seconds = nil
          },
          label = "Enrage"
        },
        registerDeepWounds_DeepWounds = {
          sourceFile = "extern/wowsims-mop/sim/warrior/passives.go",
          registrationType = "RegisterSpell",
          functionName = "registerDeepWounds",
          spellId = 115768,
          Flags = "core.SpellFlagNoOnCastComplete | core.SpellFlagIgnoreArmor | core.SpellFlagIgnoreAttackerModifiers | SpellFlagBleed | core.SpellFlagPassiveSpell",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "damageMultiplier",
          CritMultiplier = "warrior.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          label = "Deep Wounds"
        },
        registerDemoralizingBanner_DemoralizingBanner = {
          sourceFile = "extern/wowsims-mop/sim/warrior/banners.go",
          registrationType = "RegisterAura",
          functionName = "registerDemoralizingBanner",
          spellId = 114030,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Demoralizing Banner"
        },
        registerColossusSmash_ColossusSmash = {
          sourceFile = "extern/wowsims-mop/sim/warrior/colossus_smash.go",
          registrationType = "RegisterAura",
          functionName = "registerColossusSmash",
          spellId = 86346,
          auraDuration = {
            raw = "time.Millisecond * 6500",
            seconds = 6
          },
          label = "Colossus Smash"
        },
        registerColossusSmash_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/colossus_smash.go",
          registrationType = "RegisterSpell",
          functionName = "registerColossusSmash",
          spellId = 86346,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 20,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 20",
            seconds = 20
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskColossusSmash",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.75",
          CritMultiplier = "war.DefaultCritMultiplier()",
          IgnoreHaste = "true"
        },
        registerWhirlwind_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "registerWhirlwind",
          spellId = 1680,
          tag = 2,
          Flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "SpellMaskWhirlwindOh",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "0.85",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerWhirlwind_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/whirlwind.go",
          registrationType = "RegisterSpell",
          functionName = "registerWhirlwind",
          spellId = 1680,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskWhirlwind",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.85",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBattleStanceAura_BattleStance = {
          sourceFile = "extern/wowsims-mop/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-mop/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-mop/sim/warrior/stances.go",
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
          sourceFile = "extern/wowsims-mop/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeroicStrikeSpell",
          spellId = 78,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    war.sharedHSCleaveCD,
				Duration: cdDuration,
			},
		}]],
          cooldown = {
            raw = "cdDuration",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskHeroicStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerCleaveSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/heroic_strike_cleave.go",
          registrationType = "RegisterSpell",
          functionName = "registerCleaveSpell",
          spellId = 845,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    war.sharedHSCleaveCD,
				Duration: cdDuration,
			},
		}]],
          cooldown = {
            raw = "cdDuration",
            seconds = nil
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskCleave",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerShatteringThrow_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/shattering_throw.go",
          registrationType = "RegisterSpell",
          functionName = "registerShatteringThrow",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 64382,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 5,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 5",
            seconds = 300
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskShatteringThrow",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerHeroicThrow_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/heroic_throw.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeroicThrow",
          spellId = 57755,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 30,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				war.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, war.AutoAttacks.MH().SwingSpeed == war.AutoAttacks.OH().SwingSpeed)
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskHeroicThrow",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.5",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerExecuteSpell_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/execute.go",
          registrationType = "RegisterSpell",
          functionName = "registerExecuteSpell",
          spellId = 5308,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskExecute",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultCritMultiplier()",
          IgnoreHaste = "true"
        },
        registerHeroicLeap_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/heroic_leap.go",
          registrationType = "RegisterSpell",
          functionName = "registerHeroicLeap",
          spellId = 6544,
          cast = [[{
			DefaultCast: core.Cast{},
			CD: core.Cooldown{
				Timer:    warrior.NewTimer(),
				Duration: time.Second * 45,
			},
			ModifyCast: func(sim *core.Simulation, spell *core.Spell, cast *core.Cast) {
				warrior.AutoAttacks.StopMeleeUntil(sim, sim.CurrentTime+cast.CastTime, warrior.AutoAttacks.MH().SwingSpeed == warrior.AutoAttacks.OH().SwingSpeed)
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 45",
            seconds = 45
          },
          Flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskHeroicLeap",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "warrior.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerImpendingVictory_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerImpendingVictory",
          spellId = 103840,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 30,
			},
		}]],
          cooldown = {
            raw = "time.Second * 30",
            seconds = 30
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "SpellMaskImpendingVictory",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerDragonRoar_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerDragonRoar",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 118000,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 1,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreArmor | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskDragonRoar",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()",
          IgnoreHaste = "true"
        },
        registerBladestorm_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladestorm",
          spellId = 46924,
          tag = 1,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskBladestormMH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "damageMultiplier",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerBladestorm_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladestorm",
          spellId = 46924,
          tag = 2,
          Flags = "core.SpellFlagPassiveSpell",
          ClassSpellMask = "SpellMaskBladestormOH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "damageMultiplier",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerBladestorm_Bladestorm = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBladestorm",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 46924,
          tag = 0,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagChanneled | core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "SpellMaskBladestorm",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultCritMultiplier()",
          label = "Bladestorm"
        },
        registerShockwave_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerShockwave",
          spellId = 46968,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 40 * time.Second,
			},
		}]],
          cooldown = {
            raw = "40 * time.Second",
            seconds = 40
          },
          Flags = "core.SpellFlagAoE | core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskShockwave",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.75",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerAvatar_Avatar = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerAvatar",
          spellId = 107574,
          auraDuration = {
            raw = "24 * time.Second",
            seconds = 24
          },
          label = "Avatar"
        },
        registerAvatar_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerAvatar",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 107574,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
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
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskAvatar",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty"
        },
        registerBloodbath_Bloodbath = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodbath",
          spellId = 12292,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Bloodbath"
        },
        registerBloodbath_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodbath",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12292,
          cast = [[{
			DefaultCast: core.Cast{
				NonEmpty: true,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Minute * 1,
			},
		}]],
          cooldown = {
            raw = "time.Minute * 1",
            seconds = 60
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskBloodbath",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "1",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerStormBolt_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormBolt",
          spellId = 107570,
          tag = 2,
          ClassSpellMask = "SpellMaskStormBoltOH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "5",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerStormBolt_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/talents.go",
          registrationType = "RegisterSpell",
          functionName = "registerStormBolt",
          spellId = 107570,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: 30 * time.Second,
			},
		}]],
          cooldown = {
            raw = "30 * time.Second",
            seconds = 30
          },
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL | core.SpellFlagReadinessTrinket",
          ClassSpellMask = "SpellMaskStormBolt",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "5",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      arms = {
        registerSlam_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerSlam",
          spellId = 1464,
          tag = 1,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagIgnoreAttackerModifiers | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warrior.SpellMaskSlam",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskEmpty",
          DamageMultiplier = "0.35",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1"
        },
        registerSlam_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/slam.go",
          registrationType = "RegisterSpell",
          functionName = "registerSlam",
          spellId = 1464,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskSlam",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.75",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerSweepingStrikes_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikes",
          spellId = 12328,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagPassiveSpell | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warrior.SpellMaskSweepingStrikesHit",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeSpecial",
          DamageMultiplier = "0.5",
          ThreatMultiplier = "1"
        },
        registerSweepingStrikes_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/sweeping_strikes.go",
          registrationType = "RegisterSpell",
          functionName = "registerSweepingStrikes",
          majorCooldown = {
            type = "core.CooldownTypeDPS",
            priority = nil
          },
          spellId = 12328,
          cast = [[{
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 10,
			},
		}]],
          cooldown = {
            raw = "time.Second * 10",
            seconds = 10
          },
          ClassSpellMask = "warrior.SpellMaskSweepingStrikes",
          SpellSchool = "core.SpellSchoolPhysical"
        },
        registerMortalStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/mortal_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerMortalStrike",
          spellId = 12294,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			CD: core.Cooldown{
				Timer:    war.NewTimer(),
				Duration: time.Second * 6,
			},
			IgnoreHaste: true,
		}]],
          cooldown = {
            raw = "time.Second * 6",
            seconds = 6
          },
          Flags = "core.SpellFlagAPL | core.SpellFlagMeleeMetrics",
          ClassSpellMask = "warrior.SpellMaskMortalStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "2.15",
          CritMultiplier = "war.DefaultCritMultiplier()",
          IgnoreHaste = "true"
        },
        registerSeasonedSoldier_SeasonedSoldier = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSeasonedSoldier",
          spellId = 12712,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Seasoned Soldier"
        },
        registerSuddenDeath_SuddenDeath = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSuddenDeath",
          spellId = 52437,
          auraDuration = {
            raw = "2 * time.Second",
            seconds = 2
          },
          label = "Sudden Death"
        },
        registerSuddenDeath_SuddenExecute = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSuddenDeath",
          spellId = 139958,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Sudden Execute"
        },
        registerTasteForBlood_TasteForBlood = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerTasteForBlood",
          spellId = 60503,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Taste For Blood"
        },
        registerOverpower_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/arms/overpower.go",
          registrationType = "RegisterSpell",
          functionName = "registerOverpower",
          spellId = 7384,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDMin,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskOverpower",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.05",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        }
      },
      fury = {
        registerRagingBlow_RagingBlow = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterAura",
          functionName = "registerRagingBlow",
          spellId = 131116,
          auraDuration = {
            raw = "12 * time.Second",
            seconds = 12
          },
          label = "Raging Blow!"
        },
        registerRagingBlow_2 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterSpell",
          functionName = "registerRagingBlow",
          spellId = 85288,
          tag = 3,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warrior.SpellMaskRagingBlowOH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "1.9 * 1.2",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerRagingBlow_3 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterSpell",
          functionName = "registerRagingBlow",
          spellId = 85288,
          tag = 2,
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagNoOnCastComplete",
          ClassSpellMask = "warrior.SpellMaskRagingBlowMH",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.9 * 1.2",
          CritMultiplier = "war.DefaultCritMultiplier()"
        },
        registerRagingBlow_4 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/raging_blow.go",
          registrationType = "RegisterSpell",
          functionName = "registerRagingBlow",
          spellId = 85288,
          tag = 1,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskRagingBlow",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "1.0",
          CritMultiplier = "war.DefaultCritMultiplier()",
          IgnoreHaste = "true"
        },
        registerFlurry_Flurry = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerFlurry",
          spellId = 12968,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Flurry"
        },
        registerBloodsurge_Bloodsurge = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerBloodsurge",
          spellId = 46916,
          auraDuration = {
            raw = "15 * time.Second",
            seconds = 15
          },
          label = "Bloodsurge"
        },
        registerMeatCleaver_MeatCleaver = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerMeatCleaver",
          spellId = 85739,
          auraDuration = {
            raw = "10 * time.Second",
            seconds = 10
          },
          label = "Meat Cleaver"
        },
        registerSingleMindedFuryOrTitansGrip_SingleMindedFury = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSingleMindedFuryOrTitansGrip",
          spellId = 81099,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Single-Minded Fury"
        },
        registerSingleMindedFuryOrTitansGrip_TitansGrip = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/passives.go",
          registrationType = "RegisterAura",
          functionName = "registerSingleMindedFuryOrTitansGrip",
          spellId = 46917,
          auraDuration = {
            raw = "core.NeverExpires",
            seconds = -1
          },
          label = "Titan's Grip"
        },
        registerWildStrike_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/wild_strike.go",
          registrationType = "RegisterSpell",
          functionName = "registerWildStrike",
          spellId = 100130,
          cast = [[{
			DefaultCast: core.Cast{
				GCD: core.GCDDefault,
			},
			IgnoreHaste: true,
		}]],
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskWildStrike",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeOHSpecial",
          DamageMultiplier = "2.3",
          CritMultiplier = "war.DefaultCritMultiplier()",
          ThreatMultiplier = "1",
          IgnoreHaste = "true"
        },
        registerBloodthirst_1 = {
          sourceFile = "extern/wowsims-mop/sim/warrior/fury/bloodthirst.go",
          registrationType = "RegisterSpell",
          functionName = "registerBloodthirst",
          spellId = 23881,
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
          Flags = "core.SpellFlagMeleeMetrics | core.SpellFlagAPL",
          ClassSpellMask = "warrior.SpellMaskBloodthirst",
          SpellSchool = "core.SpellSchoolPhysical",
          ProcMask = "core.ProcMaskMeleeMHSpecial",
          DamageMultiplier = "0.9 * 1.2",
          CritMultiplier = "war.DefaultCritMultiplier()",
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
      }
    },
    buffs_debuffs = {
      StatsBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1126,
            20217,
            90363,
            115921
          }
        },
        stats = {
          "Stat.StatAgility",
          "Stat.StatIntellect",
          "Stat.StatStrength"
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
            6673,
            19506,
            57330
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
      AttackSpeedBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            30809,
            55610,
            113742,
            128432,
            128433
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
      SpellPowerBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            1459,
            77747,
            109773,
            126309
          }
        },
        stats = {
          "Stat.StatSpellPower"
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
            24907,
            49868,
            51470
          }
        },
        stats = {
          "Stat.StatSpellPower"
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
            1459,
            17007,
            24604,
            90309,
            116781,
            126309
          }
        },
        stats = {
          "Stat.StatCritRating"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MasteryBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            19740,
            93435,
            116956,
            128997
          }
        },
        stats = {
          "Stat.StatMasteryRating"
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
            21562,
            90364,
            109773
          }
        },
        stats = {
          "Stat.StatStamina"
        },
        configs = {
          "RAID_BUFFS_CONFIG"
        }
      },
      MajorHasteBuff = {
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
      DefensiveCooldownBuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            6940,
            31821,
            33206,
            47788,
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
      CastSpeedDebuff = {
        source = "icon_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            5761,
            31589,
            50274,
            58604,
            73975,
            109466
          }
        },
        stats = {
          "Stat.StatArmor"
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
            24844,
            34889,
            58410
          }
        },
        stats = {
          "Stat.StatAttackPower",
          "Stat.StatRangedAttackPower",
          "Stat.StatSpellPower"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
      },
      Skullbanner = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            114207
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
      StormLashTotem = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            120668
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
      ManaTideTotem = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            16190
          }
        },
        stats = {
          "Stat.StatSpirit"
        },
        configs = {
          "RAID_BUFFS_MISC_CONFIG"
        },
        countField = "ManaTideTotemCount"
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
      MajorArmorDebuff = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            113746
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
      PhysicalDamageDebuff = {
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            81326
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
        source = "config_array",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            115798
          }
        },
        stats = {
          "Stat.StatArmor"
        },
        configs = {
          "DEBUFFS_CONFIG"
        }
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
      EmbraceOfTheShaleSpider = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            90363
          }
        }
      },
      LegacyOfTheEmperor = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            115921
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
      UnholyAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            55610
          }
        }
      },
      SerpentsSwiftness = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            128433
          }
        }
      },
      SwiftbladesCunning = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            113742
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
      CacklingHowl = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            128432
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
      StillWater = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            126309
          }
        }
      },
      BurningWrath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            77747
          }
        }
      },
      DarkIntent = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            109773
          }
        }
      },
      MoonkinAura = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            24907
          }
        }
      },
      MindQuickening = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            49868
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
      LeaderOfThePack = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            17007
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
      TerrifyingRoar = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            90309
          }
        }
      },
      LegacyOfTheWhiteTiger = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            116781
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
      RoarOfCourage = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            93435
          }
        }
      },
      SpiritBeastBlessing = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            128997
          }
        }
      },
      GraceOfAir = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            116956
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
      PowerWordFortitude = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            21562
          }
        }
      },
      QirajiFortitude = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            90364
          }
        }
      },
      Bloodlust = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            2825
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
      DevotionAuraCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31821
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
      SkullBannerCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            114207
          }
        }
      },
      StormlashTotemCount = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            120668
          }
        }
      },
      WeakenedArmor = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            113746
          }
        }
      },
      WeakenedBlows = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            115798
          }
        }
      },
      NecroticStrike = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            73975
          }
        }
      },
      LavaBreath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            58604
          }
        }
      },
      SporeCloud = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            50274
          }
        }
      },
      MindNumbingPoison = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            5761
          }
        }
      },
      Slow = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            31589
          }
        }
      },
      CurseOfEnfeeblement = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            109466
          }
        }
      },
      PhysicalVulnerability = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            81326
          }
        }
      },
      LightningBreath = {
        source = "buff_input",
        source_file = "buffs_debuffs.ts",
        ids = {
          spell = {
            24844
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
        total_found = 98,
        matched = 98,
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
      files_scanned = 727,
      functions_scanned = 3414,
      registrations_found = 878,
      registrations_parsed = 853,
      registrations_missed = {
        {
          file = "sim/death_knight/ghoul_pet.go",
          ["function"] = "registerClaw",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.ActionID{SpellID: ghoulPet.clawSpellID}, 		SpellSchool:    core.SpellSchoolPhysical, 		ProcMask:       core.ProcMaskMeleeMHSp..."
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
          file = "sim/monk/healing_sphere.go",
          ["function"] = "registerHealingSphere",
          registration_index = 2,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 			Label:    fmt.Sprintf("Healing Sphere #%v %v", i, monk.Label), 			ActionID: healingSphereActionID, 			Duration: duration, 		}...]]
        },
        {
          file = "sim/monk/stances.go",
          ["function"] = "makeStanceSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: aura.ActionID, 		Flags:    core.SpellFlagNoOnCastComplete | core.SpellFlagAPL,  		Cast: core.CastConfig{ 			CD: core.Cooldown{ 				Timer..."
        },
        {
          file = "sim/monk/ww_rising_sun_kick.go",
          ["function"] = "registerRisingSunKick",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 			Label:    fmt.Sprintf("Rising Sun Kick %s", target.Label), 			ActionID: risingSunKickActionID, 			Duration: time.Second * 15, 		}...]]
        },
        {
          file = "sim/monk/ww_rising_sun_kick.go",
          ["function"] = "registerSEFRisingSunKick",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 			Label:    fmt.Sprintf("Rising Sun Kick - Clone %s", target.Label), 			ActionID: risingSunKickActionID.WithTag(SEFSpellID), 			Duration: time.Seco...]]
        },
        {
          file = "sim/monk/windwalker/passives.go",
          ["function"] = "registerComboBreaker",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = [[{ 			Label:    fmt.Sprintf("Combo Breaker: %s %s", labelSuffix, ww.Label), 			ActionID: core.ActionID{SpellID: spellID}, 			Duration: time.Second * 20...]]
        },
        {
          file = "sim/monk/brewmaster/guard.go",
          ["function"] = "registerGuard",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       actionID, 		Flags:          monk.SpellFlagSpender | core.SpellFlagAPL | core.SpellFlagReadinessTrinket, 		ClassSpellMask: monk.Mon..."
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
          file = "sim/hunter/aspects.go",
          ["function"] = "registerAspectSpell",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:      label, 		ActionID:   actionID, 		Duration:   core.NeverExpires, 		BuildPhase: core.CharacterBuildPhaseBase, 		OnGain: func(a *core.Aur..."
        },
        {
          file = "sim/hunter/aspects.go",
          ["function"] = "registerAspectSpell",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID: actionID, 		Flags:    core.SpellFlagAPL, 		ApplyEffects: func(sim *core.Simulation, _ *core.Unit, _ *core.Spell) { 			aura.Activate(sim)..."
        },
        {
          file = "sim/hunter/glaive_toss.go",
          ["function"] = "registerGlaiveTossSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:                 core.ActionID{SpellID: spellID}, 			SpellSchool:              core.SpellSchoolPhysical, 			ProcMask:                 co..."
        },
        {
          file = "sim/priest/shadow/shadowy_recall.go",
          ["function"] = "buildSingleTickSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:         core.ActionID{SpellID: spellId}.WithTag(77486), 		SpellSchool:      core.SpellSchoolShadow, 		Flags:            core.SpellFlagNo..."
        },
        {
          file = "sim/warlock/talents.go",
          ["function"] = "BuildAndRegisterSummonSpell",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    core.ActionID{SpellID: id}, 		SpellSchool: core.SpellSchoolShadow, 		Flags:       core.SpellFlagAPL, 		ProcMask:    core.ProcMaskEmpt..."
        },
        {
          file = "sim/warlock/affliction/malefic_effect.go",
          ["function"] = "registerMaleficEffect",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 			ActionID:       core.ActionID{SpellID: id}.WithTag(1), 			Flags:          core.SpellFlagNoOnCastComplete | core.SpellFlagNoSpellMods | core.Spell..."
        },
        {
          file = "sim/paladin/devotion_aura.go",
          ["function"] = "registerDevotionAura",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.DevotionAuraActionID, 		Flags:          core.SpellFlagAPL | core.SpellFlagHelpful | core.SpellFlagReadinessTrinket, 		ClassSp..."
        },
        {
          file = "sim/paladin/talents.go",
          ["function"] = "registerSacredShield",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:    actionID, 		Flags:       core.SpellFlagAPL | core.SpellFlagHelpful, 		ProcMask:    core.ProcMaskSpellHealing, 		SpellSchool: core.Spe..."
        },
        {
          file = "sim/paladin/talents.go",
          ["function"] = "divinePurposeFactory",
          registration_index = 1,
          registration_type = "RegisterAura",
          reason = "Could not extract spellId",
          block_preview = "{ 		Label:    label + paladin.Label, 		ActionID: core.ActionID{SpellID: spellID}, 		Duration: duration, 	}..."
        },
        {
          file = "sim/warrior/rallying_cry.go",
          ["function"] = "registerRallyingCry",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.RallyingCryActionID, 		Flags:          core.SpellFlagAPL, 		ClassSpellMask: SpellMaskRallyingCry,  		Cast: core.CastConfig{..."
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
          file = "sim/warrior/banners.go",
          ["function"] = "registerSkullBanner",
          registration_index = 1,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.SkullBannerActionID, 		Flags:          core.SpellFlagAPL, 		ClassSpellMask: SpellMaskSkullBanner,  		Cast: core.CastConfig{..."
        },
        {
          file = "sim/warrior/banners.go",
          ["function"] = "registerDemoralizingBanner",
          registration_index = 2,
          registration_type = "RegisterSpell",
          reason = "Could not extract spellId",
          block_preview = "{ 		ActionID:       core.SkullBannerActionID, 		Flags:          core.SpellFlagAPL, 		ClassSpellMask: SpellMaskDemoralizingBanner,  		Cast: core.CastCo..."
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
