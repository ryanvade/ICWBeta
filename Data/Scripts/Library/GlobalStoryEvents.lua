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
--*   @Date:                2018-03-10T03:14:13+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GlobalStoryEvents.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:26:54+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



CONSTANTS = require("GameConstants")

function ShowScreenText(textId, time, var, color)
    local screenTextEvent = CONSTANTS.PLAYER_AGNOSTIC_PLOT.Get_Event(CONSTANTS.SHOW_TEXT_EVENT_NAME)

    if not screenTextEvent then return end

    local colorString = ""
    if color then
        colorString = color.r.." "..color.g.." "..color.b
    end

    if not var then
        var = ""
    end
    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(1, tostring(time))
    screenTextEvent.Set_Reward_Parameter(2, var)
    screenTextEvent.Set_Reward_Parameter(3, "")
    screenTextEvent.Set_Reward_Parameter(5, colorString)
    Story_Event(CONSTANTS.SHOW_TEXT_NOTIFICATION_NAME)
end

function RemoveScreenText(textId)
    local screenTextEvent = CONSTANTS.PLAYER_AGNOSTIC_PLOT.Get_Event(CONSTANTS.SHOW_TEXT_EVENT_NAME)

    if not screenTextEvent then return end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(3, "remove")
    Story_Event(CONSTANTS.SHOW_TEXT_NOTIFICATION_NAME)
end
