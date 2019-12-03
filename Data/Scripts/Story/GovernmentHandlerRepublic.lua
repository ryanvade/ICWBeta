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
--*   @Author:              Corey
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
require("PGStoryMode")
require("PGSpawnUnits")
require("trlib-util/ChangeOwnerUtilities")
StoryUtil = require("trlib-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Support_Palpatine = Palpatine_Support,
        Lira_Contract = Palpatine_Support,
        KDY_Deal_AI = Spawn_KDY_AI,
        Support_Mothma = Mothma_Support
    }
end

function Palpatine_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_EMPEROR_PALPATINE")
    end
end

function Mothma_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_MOTHMA")
    end
end

function Spawn_KDY_AI(message)
    if message == OnEnter then
        local KDY_OBJECT = {"DUMMY_KUAT_CONTRACT", "Generic_Star_Destroyer"}
        local p_republic = Find_Player("Empire")
        local start_planet = FindPlanet("Kuat")
        local KDYspawn = SpawnList(KDY_OBJECT, start_planet, p_republic, true, false)
    end
end