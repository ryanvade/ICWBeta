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
        Support_Candidate_Leia = Leia_Support,
        Support_Candidate_Borsk = Borsk_Support,
        Support_Candidate_Mothma = Mothma_Support,
        Support_Candidate_Gavrisom = Gavrisom_Support
    }
end

function Leia_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_LEIA")
    end
end

function Borsk_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_FEYLYA")
    end
end

function Mothma_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_MOTHMA")
    end
end

function Gavrisom_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_GAVRISOM")
    end
end
