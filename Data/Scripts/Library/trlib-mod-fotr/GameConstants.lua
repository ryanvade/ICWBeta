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
--*   @Author:              [TR]Pox
--*   @Date:                2018-03-10T11:56:43+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GameConstants.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:29:08+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

GameConstants = {
    PLAYABLE_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "UNDERWORLD",
        "PENTASTAR",
        "TERADOC",
        "PIRATES",
        "HUTTS",
        "CORPORATE_SECTOR",
        "HAPES_CONSORTIUM"
    },
    ALL_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "UNDERWORLD",
        "PENTASTAR",
        "TERADOC",
        "PIRATES",
        "HUTTS",
        "WARLORDS",
        "CORPORATE_SECTOR",
        "NEUTRAL",
        "HOSTILE",
        "HUTT_CARTELS",
        "HAPES_CONSORTIUM",
		"MANDALORIANS"
    },
    ALL_FACTIONS_NOT_NEUTRAL = {
        "EMPIRE",
        "REBEL",
        --"UNDERWORLD",
        "PENTASTAR",
        "TERADOC",
        "PIRATES",
        "HUTTS",
        --"WARLORDS",
        --"CORPORATE_SECTOR",
        --"HUTT_CARTELS",
        --"HAPES_CONSORTIUM",
		--"MANDALORIANS"
    },
    ALL_FACTION_TEXTS = {
        EMPIRE = "TEXT_FACTION_REPUBLIC",
        REBEL = "TEXT_FACTION_CIS",
        UNDERWORLD = "TEXT_FACTION_EOTH",
        PENTASTAR = "TEXT_FACTION_BANKING_CLAN",
        TERADOC = "TEXT_FACTION_COMMERCE_GUILD",
        PIRATES = "TEXT_FACTION_TRADEFED",
        HUTTS = "TEXT_FACTION_TECHNO_UNION",
        WARLORDS = "TEXT_FACTION_WARLORDS",
        CORPORATE_SECTOR = "TEXT_FACTION_CSA",
        NEUTRAL = "TEXT_FACTION_NEUTRAL",
        HOSTILE = "TEXT_FACTION_HOSTILE",
        HUTT_CARTELS = "TEXT_FACTION_HUTTS",
        HAPES_CONSORTIUM = "TEXT_FACTION_HAPES",
		MANDALORIANS = "TEXT_FACTION_MANDALORIANS"
    },
    ALL_FACTION_PLANET_CONQUEST_TEXTS = {
        EMPIRE = "TEXT_FACTION_REPUBLIC_CONQUEST",
        REBEL = "TEXT_FACTION_CIS_CONQUEST",
        UNDERWORLD = "TEXT_FACTION_EOTH_CONQUEST",
        PENTASTAR = "TEXT_FACTION_BANKING_CLAN_CONQUEST",
        TERADOC = "TEXT_FACTION_COMMERCE_GUILD_CONQUEST",
        PIRATES = "TEXT_FACTION_TRADEFED_CONQUEST",
        HUTTS = "TEXT_FACTION_TECHNO_UNION_CONQUEST",
        WARLORDS = "TEXT_FACTION_WARLORDS_CONQUEST",
        CORPORATE_SECTOR = "TEXT_FACTION_CSA_CONQUEST",
        NEUTRAL = "TEXT_FACTION_NEUTRAL_CONQUEST",
        HOSTILE = "TEXT_FACTION_HOSTILE_CONQUEST",
        HUTT_CARTELS = "TEXT_FACTION_HUTTS_CONQUEST",
        HAPES_CONSORTIUM = "TEXT_FACTION_HAPES_CONQUEST",
		MANDALORIANS = "TEXT_FACTION_MANDALORIANS_CONQUEST"
    },
    FACTION_COLORS = {
        ["EMPIRE"] = {r = 250, g = 44, b = 44},
        ["REBEL"] = {r = 44, g = 121, b = 216},
        ["UNDERWORLD"] = {r = 102, g = 188, b = 217},
        ["PENTASTAR"] = {r = 55, g = 64, b = 184},
        ["TERADOC"] = {r = 20, g = 250, b = 50},
        ["PIRATES"] = {r = 179, g = 148, b = 105},
        ["HUTTS"] = {r = 255, g = 255, b = 255},
        ["WARLORDS"] = {r = 142, g = 195, b = 0},
        ["CORPORATE_SECTOR"] = {r = 176, g = 124, b = 172},
        ["HAPES_CONSORTIUM"] = {r = 212, g = 81, b = 255},
        ["NEUTRAL"] = {r = 100, g = 100, b = 100},
        ["HOSTILE"] = {r = 153, g = 21, b = 223},
		["MANDALORIANS"] = {r = 100, g = 75, b = 75}
    }
}

return GameConstants
