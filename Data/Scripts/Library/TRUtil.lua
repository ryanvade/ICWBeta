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
    ShowTextNotificationName = "SHOW_SCREEN_TEXT",
    BuildableUnitEventName = "Buildable_Unit_Template",
    BuildableUnitNotificationName = "BUILDABLE_UNIT",
    LockUnitEventName = "Lock_Unit_Template",
    LockUnitNotificationName = "LOCK_UNIT",
    GenericEventName = "Generic_Event_Template",
    GenericEventNotificationName = "GENERIC_EVENT"
}

function TRUtil.GetPlayerAgnosticPlot()
    local plotName = TRUtil.PlayerAgnosticPlots[Get_Game_Mode()]
    return Get_Story_Plot(plotName)
end

function TRUtil.ShowScreenText(textId, time, var, color, teletype)
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local screenTextEvent = plot.Get_Event(TRUtil.ShowTextEventName)
    
    if not screenTextEvent then return end
    
    local colorString = ""
    if color then
        colorString = color.r .. " " .. color.g .. " " .. color.b
    end
    
    if not var then
        var = ""
    end

    local use_teletype = 0
    if teletype then
        use_teletype = 1
    end

    screenTextEvent.Set_Reward_Parameter(0, textId)
    screenTextEvent.Set_Reward_Parameter(1, tostring(time))
    screenTextEvent.Set_Reward_Parameter(2, var)
    screenTextEvent.Set_Reward_Parameter(3, "")
    screenTextEvent.Set_Reward_Parameter(4, use_teletype)
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

function TRUtil.BuildableUnit(unitType)
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local buildableUnitEvent = plot.Get_Event(TRUtil.BuildableUnitEventName)

    if not buildableUnitEvent then return end

    buildableUnitEvent.Set_Reward_Parameter(0, unitType)
    Story_Event(TRUtil.BuildableUnitNotificationName)
end

function TRUtil.LockUnit(unitType)
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local lockUnitEvent = plot.Get_Event(TRUtil.LockUnitEventName)

    if not lockUnitEvent then return end

    lockUnitEvent.Set_Reward_Parameter(0, unitType)
    Story_Event(TRUtil.LockUnitNotificationName)
end

function TRUtil.SetTechLevel(player, level)
    if type(player) == "string" then
        player = Find_Player(player)
    end
    local event = TRUtil.GetGenericEvent()
    event.Set_Reward_Type("SET_TECH_LEVEL")
    event.Set_Reward_Parameter(0, player)
    event.Set_Reward_Parameter(1, level)
    TRUtil.TriggerGenericEvent()
    TRUtil.ResetGenericEvent()
end

function TRUtil.GetGenericEvent()
    local plot = TRUtil.GetPlayerAgnosticPlot()
    return plot.Get_Event(TRUtil.GenericEventName)
end

function TRUtil.TriggerGenericEvent()
    Story_Event(TRUtil.GenericEventNotificationName)
end

function TRUtil.ResetGenericEvent()
    local plot = TRUtil.GetPlayerAgnosticPlot()
    local genericEvent = plot.Get_Event(TRUtil.GenericEventName)

    if not genericEvent then return end

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

function TRUtil.ValidGlobalValue(val)
    return val and val ~= ""
end

function TRUtil.FindFriendlyPlanet(player)
    if type(player) == "string" then
        player = Find_Player(player)
    end

    local allPlanets = TRUtil.GetAllPlanetsWithoutDummies()
    
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

function TRUtil.GetAllPlanetsWithoutDummies()
    local allPlanets = FindPlanet.Get_All_Planets()
    
    for i, p in pairs(allPlanets) do
        if p == FindPlanet("Dummy_Empire") or p == FindPlanet("Dummy_Rebel") or p == FindPlanet("Dummy_EotH") then
            table.remove(allPlanets, i)
        end
    end
    
    return allPlanets
end

return TRUtil
