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
require("trlib-util/ChangeOwnerUtilities")
require("trlib-lua-events/StoryEventManager")
require("trlib-lua-events/StoryEvents")
require("trlib-lua-events/Prerequisite")
require("trlib-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Progressive_Story_Start = Begin_Progressive,
        Align_Start = Begin_Align,
        Orinda_Story_Start = Begin_Orinda,
        FIP_Story_Start = Begin_FIP
    }
end

function Begin_Progressive(message)
    if message == OnEnter then
        require("Conquests/GlobalEvents")
        require("Conquests/Progressives/ProgressiveEvents")
        RegisterAndProcessEvents()
    end
end

function Begin_Align(message)
    if message == OnEnter then
        require("Conquests/GlobalEvents")
        require("Conquests/Align/AlignEvents")
        RegisterAndProcessEvents()
    end
end

function Begin_Orinda(message)
    if message == OnEnter then
        require("Conquests/GlobalEvents")
        require("Conquests/Orinda/OrindaEvents")
        RegisterAndProcessEvents()
    end
end

function Begin_FIP(message)
    if message == OnEnter then
        require("Conquests/GlobalEvents")
        require("Conquests/FinalImperialPush/FinalImperialPushEvents")
        RegisterAndProcessEvents()
    end
end

function RegisterAndProcessEvents()
    RegisterGlobalEvents()
    RegisterEvents()
    Create_Thread("StoryEventProcessingThread")
end

function StoryEventProcessingThread()
    while true do
        StoryEventManager:ProcessEvents()
        Sleep(0.1)
    end
end
