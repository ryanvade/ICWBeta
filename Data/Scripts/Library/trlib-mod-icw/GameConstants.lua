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
        "HAPES_CONSORTIUM"
    },
    ALL_FACTIONS_NOT_NEUTRAL = {
        "EMPIRE",
        "REBEL",
        "UNDERWORLD",
        "PENTASTAR",
        "TERADOC",
        "PIRATES",
        "HUTTS",
        "WARLORDS",
        "CORPORATE_SECTOR",
        --"HUTT_CARTELS",
        "HAPES_CONSORTIUM"
    },
    ALL_FACTION_TEXTS = {
        EMPIRE = "TEXT_FACTION_EMPIRE",
        REBEL = "TEXT_FACTION_REBELS",
        UNDERWORLD = "TEXT_FACTION_EOTH",
        PENTASTAR = "TEXT_FACTION_PENTASTAR",
        TERADOC = "TEXT_FACTION_TERADOC",
        PIRATES = "TEXT_FACTION_ZSINJ",
        HUTTS = "TEXT_FACTION_DELVARDUS",
        WARLORDS = "TEXT_FACTION_WARLORDS",
        CORPORATE_SECTOR = "TEXT_FACTION_CSA",
        NEUTRAL = "TEXT_FACTION_NEUTRAL",
        HOSTILE = "TEXT_FACTION_HOSTILE",
        HUTT_CARTELS = "TEXT_FACTION_HUTTS",
        HAPES_CONSORTIUM = "TEXT_FACTION_HAPES"
    },
    ALL_FACTION_PLANET_CONQUEST_TEXTS = {
        EMPIRE = "TEXT_FACTION_EMPIRE_CONQUEST",
        REBEL = "TEXT_FACTION_REBELS_CONQUEST",
        UNDERWORLD = "TEXT_FACTION_EOTH_CONQUEST",
        PENTASTAR = "TEXT_FACTION_PENTASTAR_CONQUEST",
        TERADOC = "TEXT_FACTION_TERADOC_CONQUEST",
        PIRATES = "TEXT_FACTION_ZSINJ_CONQUEST",
        HUTTS = "TEXT_FACTION_DELVARDUS_CONQUEST",
        WARLORDS = "TEXT_FACTION_WARLORDS_CONQUEST",
        CORPORATE_SECTOR = "TEXT_FACTION_CSA_CONQUEST",
        NEUTRAL = "TEXT_FACTION_NEUTRAL_CONQUEST",
        HOSTILE = "TEXT_FACTION_HOSTILE_CONQUEST",
        HUTT_CARTELS = "TEXT_FACTION_HUTTS_CONQUEST",
        HAPES_CONSORTIUM = "TEXT_FACTION_HAPES_CONQUEST"
    },
    FACTION_COLORS = {
        ["EMPIRE"] = {r = 8, g = 122, b = 16},
        ["REBEL"] = {r = 239, g = 139, b = 9},
        ["UNDERWORLD"] = {r = 102, g = 188, b = 217},
        ["PENTASTAR"] = {r = 55, g = 64, b = 184},
        ["TERADOC"] = {r = 255, g = 20, b = 50},
        ["PIRATES"] = {r = 179, g = 148, b = 105},
        ["HUTTS"] = {r = 255, g = 255, b = 255},
        ["WARLORDS"] = {r = 142, g = 195, b = 0},
        ["CORPORATE_SECTOR"] = {r = 176, g = 124, b = 172},
        ["HAPES_CONSORTIUM"] = {r = 212, g = 81, b = 255},
        ["NEUTRAL"] = {r = 100, g = 100, b = 100},
        ["HOSTILE"] = {r = 153, g = 21, b = 223}
    }
}

return GameConstants
