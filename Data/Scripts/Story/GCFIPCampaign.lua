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
--*   @Last modified time:  2018-02-05T07:31:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")
require("StoryEventManager")
require("StoryEvents")
require("Conquests/GlobalEvents")
require("Conquests/FinalImperialPush/FinalImperialPushEvents")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))
    
    StoryModeEvents = {
        Universal_Story_Start = Begin_GC
    }
end

function Begin_GC(message)
    if message == OnEnter then
        RegisterGlobalEvents()
        RegisterEvents()
    elseif message == OnUpdate then
        StoryEventManager:ProcessEvents()
    end
end
