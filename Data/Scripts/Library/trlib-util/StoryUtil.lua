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
--*   @Filename:            story_util.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-17T02:24:26+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
StoryUtil = {
    PlayerAgnosticPlots = {
        Galactic = "Player_Agnostic_Plot.xml",
        Space = "Conquests\\Tactical_Raids.XML"
    },
    ShowTextEventName = "Show_Screen_Text",
    ShowTextNotificationName = "SHOW_SCREEN_TEXT",
    BuildableUnitEventName = "Buildable_Unit_Template",
    BuildableUnitNotificationName = "BUILDABLE_UNIT",
    LockUnitEventName = "Lock_Unit_Template",
    LockUnitNotificationName = "LOCK_UNIT",
    GenericEventName = "Generic_Event_Template",
    GenericEventNotificationName = "GENERIC_EVENT"
}

function StoryUtil.GetPlayerAgnosticPlot()
    local plotName = StoryUtil.PlayerAgnosticPlots[Get_Game_Mode()]
    return Get_Story_Plot(plotName)
end

function StoryUtil.ShowScreenText(textId, time, var, color, teletype)
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local screenTextEvent = plot.Get_Event(StoryUtil.ShowTextEventName)

    if not screenTextEvent then
        return
    end

    local colorString = ""
    if color then
        colorString = color.r .. " " .. color.g .. " " .. color.b
    end

    if not var then
        var = ""
    end

    local use_teletype = 1
    if teletype == false then
        use_teletype = 0
    end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(1, tostring(time))
    screenTextEvent.Set_Reward_Parameter(2, var)
    screenTextEvent.Set_Reward_Parameter(3, "")
    screenTextEvent.Set_Reward_Parameter(4, use_teletype)
    screenTextEvent.Set_Reward_Parameter(5, colorString)
    Story_Event(StoryUtil.ShowTextNotificationName)
end

function StoryUtil.RemoveScreenText(textId)
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local screenTextEvent = plot.Get_Event(StoryUtil.ShowTextEventName)

    if not screenTextEvent then
        return
    end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(3, "remove")
    Story_Event(StoryUtil.ShowTextNotificationName)
end

function StoryUtil.BuildableUnit(unitType)
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local buildableUnitEvent = plot.Get_Event(StoryUtil.BuildableUnitEventName)

    if not buildableUnitEvent then
        return
    end

    buildableUnitEvent.Set_Reward_Parameter(0, unitType)
    Story_Event(StoryUtil.BuildableUnitNotificationName)
end

function StoryUtil.LockUnit(unitType)
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local lockUnitEvent = plot.Get_Event(StoryUtil.LockUnitEventName)

    if not lockUnitEvent then
        return
    end

    lockUnitEvent.Set_Reward_Parameter(0, unitType)
    Story_Event(StoryUtil.LockUnitNotificationName)
end

function StoryUtil.SetTechLevel(player, level)
    if type(player) == "string" then
        player = Find_Player(player)
    end
    local event = StoryUtil.GetGenericEvent()
    event.Set_Reward_Type("SET_TECH_LEVEL")
    event.Set_Reward_Parameter(0, player)
    event.Set_Reward_Parameter(1, level)
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()
end

function StoryUtil.GetGenericEvent()
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    return plot.Get_Event(StoryUtil.GenericEventName)
end

function StoryUtil.TriggerGenericEvent()
    Story_Event(StoryUtil.GenericEventNotificationName)
end

function StoryUtil.ResetGenericEvent()
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    local genericEvent = plot.Get_Event(StoryUtil.GenericEventName)

    if not genericEvent then
        return
    end

    genericEvent.Set_Reward_Type("")
    genericEvent.Set_Reward_Parameter(0, "")
    genericEvent.Set_Reward_Parameter(1, "")
    genericEvent.Set_Reward_Parameter(2, "")
    genericEvent.Set_Reward_Parameter(3, "")
    genericEvent.Set_Reward_Parameter(4, "")
    genericEvent.Set_Reward_Parameter(5, "")
    genericEvent.Set_Reward_Parameter(6, "")
    genericEvent.Set_Reward_Parameter(7, "")
    genericEvent.Set_Reward_Parameter(8, "")
    genericEvent.Set_Reward_Parameter(9, "")
    genericEvent.Set_Reward_Parameter(10, "")
    genericEvent.Set_Reward_Parameter(11, "")
    genericEvent.Set_Reward_Parameter(12, "")
end

function StoryUtil.ValidGlobalValue(val)
    return val and val ~= ""
end

function StoryUtil.FindFriendlyPlanet(player)
    if type(player) == "string" then
        player = Find_Player(player)
    end

    local allPlanets = StoryUtil.GetAllPlanetsWithoutDummies()

    local random = 0
    local planet = nil

    while table.getn(allPlanets) > 0 do
        random = GameRandom(1, table.getn(allPlanets))
        planet = allPlanets[random]
        table.remove(allPlanets, random)

        if planet.Get_Owner() == player then
            return planet
        end
    end

    return nil
end

function StoryUtil.GetAllPlanetsWithoutDummies()
    local allPlanets = FindPlanet.Get_All_Planets()

    for i, p in pairs(allPlanets) do
        if p == FindPlanet("Dummy_Empire") or p == FindPlanet("Dummy_Rebel") or p == FindPlanet("Dummy_EotH") then
            table.remove(allPlanets, i)
        end
    end

    return allPlanets
end

return StoryUtil
