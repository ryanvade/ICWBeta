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
			"SARLACC"
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
            "SARLACC"
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
            "SARLACC"
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
            SARLACC = "TEXT_FACTION_HAPES"
        }
}

return GameConstants
