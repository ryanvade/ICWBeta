--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox <Pox>
--*   @Date:                2018-01-06T18:36:14+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GameObjectLibrary.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-31T17:32:25+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Comparators")

GameObjectLibrary = {
    Interdictors={
        "Massias_Interdictor",
        "Eclipse_Super_Star_Destroyer",
        "Sovereign",
        "Generic_Interdictor_Cruiser",
        "Generic_Dominator",
        "Phulik_Binder",
        "Iillor_Corusca",
        "CC7700"
    },
    Numbers={
        "Display_One",
        "Display_Two",
        "Display_Three",
        "Display_Four",
        "Display_Five",
        "Display_Six",
        "Display_Seven",
        "Display_Eight",
        "Display_Nine",
        "Display_Ten"
    },
    Structures={
        ["EMPRESS_STATION"]={
            Text="TEXT_DISPLAY_EMPRESS"
        },
        ["EMPIRE_GOLAN_THREE_STRATEGIC"]={
            Text="TEXT_DISPLAY_GOLAN_THREE_STATION"
        },
        ["REBEL_GOLAN_ONE"]={
            Text="TEXT_DISPLAY_GOLAN_ONE_STATION"
        },
        ["OTO"]={
            Text="TEXT_DISPLAY_OTO"
        },
        ["BRASK"]={
            Text="TEXT_DISPLAY_BRASK"
        },
        ["VISVIA"]={
            Text="TEXT_DISPLAY_VISVIA"
        },
        ["REBEL_GOLAN_THREE_STRATEGIC"]={
            Text="TEXT_DISPLAY_GOLAN_THREE_STATION"
        },
        ["EMPIRE_GOLAN_TWO"]={
            Text="TEXT_DISPLAY_GOLAN_TWO_STATION"
        },
        ["GENERIC_TRADESTATION"]={
            Text="TEXT_DISPLAY_TRADE"
        },
        ["REBEL_GOLAN_TWO_STRATEGIC"]={
            Text="TEXT_DISPLAY_GOLAN_TWO_STATION"
        },
        ["TERADOC_PIRATE_BASE"]={
            Text="TEXT_DISPLAY_TAVIRA"
        },
        ["REBEL_GOLAN_TWO"]={
            Text="TEXT_DISPLAY_GOLAN_TWO_STATION"
        },
        ["EMPIRE_GOLAN_THREE"]={
            Text="TEXT_DISPLAY_GOLAN_THREE_STATION"
        },
        ["REBEL_GOLAN_THREE"]={
            Text="TEXT_DISPLAY_GOLAN_THREE_STATION"
        },
        ["VALIDUSIA"]={
            Text="TEXT_DISPLAY_VALIDUSIA"
        },
        ["EMPIRE_GOLAN_ONE"]={
            Text="TEXT_DISPLAY_GOLAN_ONE_STATION"
        },
        ["EMPIRE_GOLAN_TWO_STRATEGIC"]={
            Text="TEXT_DISPLAY_GOLAN_TWO_STATION"
        },
        ["RANCOR_BASE"]={
            Text="TEXT_DISPLAY_RANCOR_BASE"
        },
        ["BLACK_15"]={
            Text="TEXT_DISPLAY_BLACK15"
        },
        ["SLAYN_KORPIL"]={
            Text="TEXT_DISPLAY_SLAYN_KORPIL"
        },
    -- ["PLACEHOLDER_CATEGORY_DUMMY"]={
    --     Text="TEXT_DISPLAY_PLACEHOLDER_CATEGORY_DUMMY"
    -- },
    -- ["NON_CAPITAL_CATEGORY_DUMMY"]={
    --     Text="TEXT_DISPLAY_NON_CAPITAL_CATEGORY_DUMMY"
    -- },
    -- ["CAPITAL_CATEGORY_DUMMY"]={
    --     Text="TEXT_DISPLAY_CAPITAL_CATEGORY_DUMMY"
    -- },
    -- ["STRUCTURE_CATEGORY_DUMMY"]={
    --     Text="TEXT_DISPLAY_STRUCTURE_CATEGORY_DUMMY"
    -- }

    },
    Units={
        ["LANCER_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["INTERCEPTOR_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["VIGILANCE_GUNSHIP"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat",
                "Microjump"
            },
            Fighters={
            }
        },
        ["GENERIC_INTERDICTOR_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat",
                "Interdictor"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PENTASTAR"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SHIELDED_TIE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["ALLIANCE_ASSAULT_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["ASDONI"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["MASSIAS_INTERDICTOR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat",
                "Interdictor"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_IMPERIAL_II_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["AURIETTE_CARRIER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["KRSISS_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=2
                    }
                }
            }
        },
        ["GENERIC_ACCLAMATOR_ASSAULT_SHIP"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=2
                    }
                }
            }
        },
        ["ENFORCER"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
			Flags = {
                HANGAR = true
            },
			Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["REPUBLIC_BOARDING_SHUTTLE"]={
            Scripts={
                "Boarding"
            },
            Fighters={
            }
        },
        ["WARLORD"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["NEBULA"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1,
                        TechLevel = LessThan(4)
                    }
                },
                ["DEFENDER_STARFIGHTER_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=3,
                        Initial=2
                    }
                },
                ["K-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1,
                        TechLevel = GreaterOrEqualTo(4)
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["RAIDER_PENTASTAR"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["GENERIC_STAR_DESTROYER_TWO"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PENTASTAR"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PENTASTAR"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(2)
                    }
                },
                ["SHIELDED_INTERCEPTOR_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(2)
                    }
                },
                ["A9_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(4)
                    }
                },
                ["PREYBIRD_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["HOWLRUNNER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=IsOneOf({1,3})
                    },
                    ["PENTASTAR"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_RAPTOR_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_AVENGER_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["ARC_170_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=3,
                        Initial=3
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SHIELDED_TIE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["CORONA"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
			Flags = {
                HANGAR = true
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_GLADIATOR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["MC80B"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=3
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["CORELLIAN_CORVETTE"]={
            Scripts={
                "MultiLayer"
            },
            Fighters={
            }
        },
        ["ESCORT_CARRIER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HARRSK"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=IsOneOf({1,3,4,5})
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=EqualTo(2)
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["CHISS_STAR_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["KRSISS_INTERCEPTOR_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=LessOrEqualTo(3)
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=5,
                        Initial=5
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SCARSISS_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["WORLD_DEVASTATOR"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_DROID_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=8,
                        Initial=8
                    }
                }
            }
        },
        ["TORPEDO_SPHERE"]={
            Scripts={
            },
            Fighters={
            }
        },
        ["VINDICATOR_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["NURUODO"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["KRSISS_INTERCEPTOR_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["SCARSISS_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["LUCREHULK"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TORRENT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=5
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=5
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=5
                    }
                }
            }
        },
        ["YEVETHA_ALLEGIANCE"]={
            Scripts={
            },
            Fighters={
            }
        },
        ["MARAUDER_MISSILE_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["IMPERIAL_BOARDING_SHUTTLE"]={
            Scripts={
                "Boarding"
            },
            Fighters={
            }
        },
        ["KATANA_DREADNAUGHT_REBEL"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["CRUSADER_GUNSHIP"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["GENERIC_SECUTOR"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_AVENGER_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["TORRENT_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HARRSK"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HOSTILE"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["WARLORDS"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["TERADOC"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["PENTASTAR"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HARRSK"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HOSTILE"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["WARLORDS"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["TERADOC"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["PENTASTAR"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HARRSK"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HOSTILE"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["YEVETHA"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["WARLORDS"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=10,
                        Initial=3
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=20,
                        Initial=6
                    }
                }
            }
        },
        ["BUDIRECH"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["LUCREHULK_CSA"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TORRENT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=2
                    }
                },
                ["SKIPRAY_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=6,
                        Initial=2
                    }
                }
            }
        },
        ["GENERIC_PROCURSATOR"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["CORELLIAN_GUNBOAT"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["VISVIA"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["CLAWCRAFT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["NOVA_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=3
                    }
                },
                ["MIYTIL_BOMBER_SQUADRON"]={
                    ["SARLACC"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["MIYTIL_SQUADRON"]={
                    ["SARLACC"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["GENERIC_ALLEGIANCE"]={
            Scripts={ "MultiLayer"
            },
            Fighters={
            }
        },
        ["GENERIC_VICTORY_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HUTTS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(1)
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(2)
                    }
                },
                ["TIE_DROID_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(3)
                    }
                },
                ["A9_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["PREYBIRD_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["SHIELDED_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["SHIELDED_TIE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["EMPRESS_STATION"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=8,
                        Initial=4
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=8,
                        Initial=4
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=8,
                        Initial=4
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=8,
                        Initial=4
                    }
                }
            }
        },
        ["GENERIC_DOMINATOR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat",
                "Interdictor"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=2
                    }
                }
            }
        },
        ["VALIDUSIA"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=8,
                        Initial=3
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=8,
                        Initial=3
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=3
                    }
                }
            }
        },
        ["MUNIFICENT"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["SKIPRAY_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["NEWREP_XQ"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["REBEL_X-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=3
                    }
                }
            }
        },
        ["SYNDIC_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["INTEGO_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["EMPIRE_GOLAN_THREE"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["VISCOUNT"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=2,
                        TechLevel = LessThan(4)
                    }
                },
                ["K-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=2,
                        TechLevel = GreaterOrEqualTo(4)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=2
                    }
                }
            }
        },
        ["EMPIRE_GOLAN_TWO_STRATEGIC"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["EMPIRE_GOLAN_TWO"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["AMM_NOVA_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["MIYTIL_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["MIYTIL_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["GENERIC_VICTORY_DESTROYER_TWO"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HUTTS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(1)
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(2)
                    }
                },
                ["TIE_DROID_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(3)
                    }
                },
                ["A9_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["PREYBIRD_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["SHIELDED_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["SHIELDED_TIE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["REBEL_GOLAN_THREE_STRATEGIC"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        },
        ["GENERIC_PROVIDENCE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["ARC_170_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=3,
                        Initial=2
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=3,
                        Initial=2
                    }
                }
            }
        },
        ["MC40A"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["REBEL_GOLAN_TWO_STRATEGIC"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        },
        ["GENERIC_VENATOR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TORRENT_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HARRSK"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["A9_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["HARRSK"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["PENTASTAR"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["HARRSK"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=4,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=4,
                        Initial=2
                    }
                }
            }
        },
        ["REBEL_GOLAN_ONE"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        },
        ["KELDABE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["RIHKXYRK_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["STARVIPER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["CRIMSON_VICTORY"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["QUASER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["A-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["ENDURANCE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=3,
                        Initial=2,
                        TechLevel = LessThan(4)
                    }
                },
                ["K-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=3,
                        Initial=2,
                        TechLevel = GreaterOrEqualTo(4)
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=7,
                        Initial=4
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=3,
                        Initial=2
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=4,
                        Initial=2
                    }
                }
            }
        },
        ["STAR_HOME"]={
            Scripts={
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["MIYTIL_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=3
                    }
                },
                ["MIYTIL_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["AMM_BATTLEDRAGON"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["MIYTIL_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["MIYTIL_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["EMPIRE_GOLAN_THREE_STRATEGIC"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["CHAF_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=LessOrEqualTo(3)
                    }
                },
                ["FURION_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=2,
                        TechLevel=GreaterThan(3)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=2,
                        Initial=3
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["SCARSISS_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    }
                }
            }
        },
        ["GENERIC_STAR_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PENTASTAR"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PENTASTAR"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["TERADOC"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SCIMMY_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(2)
                    }
                },
                ["SHIELDED_INTERCEPTOR_SQUADRON"]={
                    ["HUTTS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(2)
                    }
                },
                ["A9_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=EqualTo(4)
                    }
                },
                ["PREYBIRD_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(5)
                    }
                },
                ["HOWLRUNNER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=EqualTo(4)
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel=IsOneOf({1,3})
                    },
                    ["PENTASTAR"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_RAPTOR_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_AVENGER_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["ARC_170_SQUADRON"]={
                    ["TERADOC"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=3,
                        Initial=3
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SHIELDED_TIE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["YEVETHA_DREADNAUGHT"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["ARMADIA"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
            }
        },
        ["ARQUITENS"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["SOVEREIGN"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_DROID_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=25,
                        Initial=5
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=3
                    }
                }
            }
        },
        ["NEBULON_B-2_ZSINJ"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["BATTLEDRAGON"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=3
                    }
                },
                ["MIYTIL_BOMBER_SQUADRON"]={
                    ["SARLACC"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["MIYTIL_SQUADRON"]={
                    ["SARLACC"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["KATANA_DREADNAUGHT_EMPIRE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["CALAMARI_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=3
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["BAC"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=3
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["HOME_ONE_TYPE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=6,
                        Initial=4
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=4,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=2,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["KARIEK_SHIELDSHIP"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["SCARSISS_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    }
                }
            }
        },
        ["MC90"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=3,
                        Initial=3
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=2
                    }
                }
            }
        },
        ["NEBULON_B_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["COMBAT_ESCORT_CARRIER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_HUNTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["ALIGNMENT_XQ"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=3
                    }
                }
            }
        },
        ["SACHEEN"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["DEFENDER_STARFIGHTER_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["PELTAST"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["KRSISS_INTERCEPTOR_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["CR90_ZSINJ"]={
            Scripts={
                "MultiLayer"
            },
            Fighters={
            }
        },
        ["QUASAR_ZSINJ"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["TIE_RAPTOR_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SKIPRAY_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["NEUTRON_STAR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_AVENGER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["REBEL_GOLAN_THREE"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        },
        ["ALARIA"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["FURION_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["KRSISS_INTERCEPTOR_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=3,
                        Initial=4
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=2
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=2
                    }
                }
            }
        },
        ["DREADNAUGHT_EMPIRE"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["DREADNAUGHT_REBEL"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_TECTOR"]={
            Scripts={
                "MultiLayer"
            },
            Fighters={
            }
        },
        ["MAJESTIC"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel = LessThan(4)
                    }
                },
                ["K-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel = GreaterOrEqualTo(4)
                    }
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=2,
                        Initial=3
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=2
                    }
                }
            }
        },
        ["EMPIRE_GOLAN_ONE"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2
                    }
                }
            }
        },
        ["CARRACK_CRUISER"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["NEBULON_B_ZSINJ"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Flags = {
                HANGAR = true
            },
            Fighters={
                ["TIE_RAPTOR_SQUADRON"]={
                    ["PIRATES"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_EXECUTOR"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=8,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=8,
                        Initial=2
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=5,
                        Initial=5
                    }
                }
            }
        },
        ["MTC_SENSOR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["TIE_DROID_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=3,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=3,
                        Initial=1
                    }
                }
            }
        },
        ["ISD_1_NR"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["DAUNTLESS"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                }
            }
        },
        ["IPV1_TERADOC"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["STRIKE_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_PRAETOR"]={
            Scripts={
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TIE_FIGHTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["REBEL_GOLAN_TWO"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["E-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        },
        ["RANCOR_BASE"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TIE_RAPTOR_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1000,
                        Initial=4
                    }
                }
            }
        },
        ["BLACK_15"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1000,
                        Initial=4
                    }
                }
            }
        },
        ["SLAYN_KORPIL"]={
            Scripts={
                "TurnStation",
                "FighterSpawn"
            },
            Fighters={
                ["B-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=100,
                        Initial=6
                    }
                }
            }
        },
        ["YEVETHA_BOARDING_SHUTTLE"]={
            Scripts={
                "Boarding"
            },
            Fighters={
            }
        },
        ["PHALANX_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
            Fighters={
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["B-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SCARSISS_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=GreaterThan(3)
                    }
                },
                ["TIE_INTERCEPTOR_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["SYCA_BOMBER_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["TIE_BOMBER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=1
                    }
                },
                ["CLAWCRAFT_SQUADRON"]={
                    ["UNDERWORLD"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=1,
                        TechLevel=LessOrEqualTo(3)
                    }
                }
            }
        },
        ["NEBULON_B-2_FRIGATE"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        }

    }
}
return GameObjectLibrary
