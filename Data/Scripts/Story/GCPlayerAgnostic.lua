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
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCPlayerAgnostic.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-19T22:04:47+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGDebug")
require("PGStateMachine")
require("PGStoryMode")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    ServiceRate = 0.1

    StoryModeEvents = {Zoom_Zoom = Begin_GC}
end

function Begin_GC(message)
    if message == OnEnter then
        ModContentLoader.get("GameModImpl")
        ActiveMod = GameModImpl()
    elseif message == OnUpdate then
        ActiveMod:update()
    end
end
