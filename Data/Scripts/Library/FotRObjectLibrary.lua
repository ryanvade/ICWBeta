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
--*   @Last modified time:  2018-04-12T00:17:51+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Comparators")
require("PlanetModifiers")

FotRObjectLibrary = {
    Interdictors={
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
		["CC7700"]={
			Scripts={
				"InterdictorAI"
			},
			Fighters={
			}
		},
        ["GEONOSIAN_CRUISER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
			Flags = {
                HANGAR = true
            },
            Fighters={
                ["NANTEX_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=1,
                        Initial=1
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
                ["TORRENT_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=6,
                        Initial=3
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["ARC_170_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
        ["GENERIC_ACCLAMATOR_ASSAULT_SHIP_I"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
             Fighters={
                ["TORRENT_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=6,
                        Initial=3
                    },
                    ["HOSTILE"] = {
                        Reserve=1,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["ARC_170_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=1
                    }
                }
            }
        },
		["GENERIC_ACCLAMATOR_ASSAULT_SHIP_LEVELER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn",
                "SingleUnitRetreat"
            },
             Fighters={
                ["TORRENT_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=3,
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
                },
                ["ARC_170_SQUADRON"]={
                    ["EMPIRE"] = {
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
                    ["EMPIRE"] = {
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
                    }
                },
				["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=0,
                        Initial=2
                    }
                },
				["SKIPRAY_SQUADRON"]={
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
        ["RECUSANT"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["DIAMOND_FRIGATE"]={
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
                        Reserve=9,
                        Initial=4
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
					["PIRATES"] = {
                        Reserve=10,
                        Initial=3
                    },
					["HUTTS"] = {
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
					["PENTASTAR"] = {
                        Reserve=10,
                        Initial=3
                    },
					["PIRATES"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["TERADOC"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["HUTTS"] = {
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
                    ["PENTASTAR"] = {
                        Reserve=10,
                        Initial=3
                    },
                    ["PIRATES"] = {
                        Reserve=10,
                        Initial=3
                    },
					["TERADOC"] = {
                        Reserve=10,
                        Initial=3
                    },
					["HUTTS"] = {
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
                        Reserve=11,
                        Initial=2
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=11,
                        Initial=2
                    }
                },
                ["A-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=11,
                        Initial=2
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
 		["INVINCIBLE_CRUISER"]={
            Scripts={
                "FighterSpawn"
            },
            Fighters={
                ["Z95_HEADHUNTER_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=10,
                        Initial=5
                    }
                }
            }
        },
        ["GENERIC_VICTORY_DESTROYER"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["ARC_170_Squadron"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
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
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
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
				["B-WING_SQUADRON"]={
                    ["REBEL"] = {
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
        ["GENERIC_VICTORY_DESTROYER_TWO"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["ARC_170_Squadron"]={
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
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
                ["VULTURE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=13,
                        Initial=3
                    }
                },
                ["TRIFIGHTER_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=3,
                        Initial=1
                    }
                },
                ["HYENA_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=2,
                        Initial=2
                    }
                }
            }
        },
        ["GENERIC_LUCREHULK"]={
            Scripts={
                "MultiLayer",
                "FighterSpawn"
            },
            Fighters={
                ["VULTURE_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=83,
                        Initial=7
                    }
                },
                ["TRIFIGHTER_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=12,
                        Initial=3
                    }
                },
                ["HYENA_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=12,
                        Initial=3
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
                    ["EMPIRE"] = {
                        Reserve=3,
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
                },
                ["ARC_170_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=2,
                        Initial=1
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
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
                    },
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
                    ["HUTTS"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["EMPIRE"] = {
                        Reserve=0,
                        Initial=2
                    },
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
                    ["HOSTILE"] = {
                        Reserve=0,
                        Initial=2
                    },
                    ["WARLORDS"] = {
                        Reserve=0,
                        Initial=2
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
                        Initial=2,
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
        ["ARQUITENS"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
        ["GENERIC_TECTOR"]={
            Scripts={
                "MultiLayer"
            },
            Fighters={
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
        ["CARRACK_CRUISER_LASERS"]={
            Scripts={
                "MultiLayer",
                "SingleUnitRetreat"
            },
            Fighters={
            }
        },
		["BULWARK_I"]={
            Scripts={
                "FighterSpawn",
            },
            Fighters={
				["MANKVIM_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
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
                },
                ["TRIFOIL_SQUADRON"]={
                    ["YEVETHA"] = {
                        Reserve=2,
                        Initial=3
                    }
                },
                ["TIE_FIGHTER_SQUADRON"]={
                    ["EMPIRE"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
                        Initial=2
                    }
                },
				["CSA_Y-WING_SQUADRON"]={
                    ["CORPORATE_SECTOR"] = {
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
				["Y-WING_SQUADRON"]={
                    ["REBEL"] = {
                        Reserve=1,
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
                ["TORRENT_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=2
                    }
                },
                ["ARC_170_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=2,
                        Initial=1
                    }
                },
                ["Z95_HEADHUNTER_SQUADRON"]={
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
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = GreaterThan(2)
                    }
                },
                ["REBEL_X-WING_SQUADRON"]={
                    ["DEFAULT"] = {
                        Reserve=0,
                        Initial=2,
                        TechLevel = LessOrEqualTo(2)
                    }
                }
            }
        }
    }
}
return FotRObjectLibrary
