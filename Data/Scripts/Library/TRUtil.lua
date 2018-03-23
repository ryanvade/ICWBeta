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
--*   @Date:                2018-03-10T15:09:24+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            TRUtil.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-17T02:24:26+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



TRUtil = {
    PlayerAgnosticPlots = {
        Galactic = "Player_Agnostic_Plot.xml",
        Space = "Conquests\\Tactical_Raids.XML"
    },
    ShowTextEventName = "Show_Screen_Text",
    ShowTextNotificationName = "SHOW_SCREEN_TEXT"
}

function TRUtil.GetPlayerAgnosticPlot()
    local plotName = TRUtil.PlayerAgnosticPlots[Get_Game_Mode()]
    return Get_Story_Plot(plotName)
end

function TRUtil.ShowScreenText(textId, time, var, color)
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local screenTextEvent = plot.Get_Event(TRUtil.ShowTextEventName)

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
    Story_Event(TRUtil.ShowTextNotificationName)
end

function TRUtil.RemoveScreenText(textId)
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local screenTextEvent = plot.Get_Event(TRUtil.ShowTextEventName)

    if not screenTextEvent then return end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(3, "remove")
    Story_Event(TRUtil.ShowTextNotificationName)
end

function TRUtil.ValidGlobalValue(val)
    return val and val ~= ""
end

return TRUtil
