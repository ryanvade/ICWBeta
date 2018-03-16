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
--*   @Date:                2017-12-14T10:54:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GameGlobals.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T03:06:07+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("GalacticEvents")
require("Util")

GLOBALS = {
    PLAYABLE_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "UNDERWORLD",
        "PENTASTAR",
        "YEVETHA",
        "TERADOC",
        "PIRATES",
        "HUTTS"
    },
    ALL_FACTIONS = {
        "EMPIRE",
        "REBEL",
        "UNDERWORLD",
        "PENTASTAR",
        "YEVETHA",
        "TERADOC",
        "PIRATES",
        "HUTTS",
        "WARLORDS",
        "CORPORATE_SECTOR",
        "HARRSK",
        "NEUTRAL",
        "HOSTILE"
    },
    FACTION_COLORS = {
        ["EMPIRE"] = {r = 8, g = 122, b = 16},
        ["REBEL"] = {r = 239, g = 139, b = 9},
        ["UNDERWORLD"] = {r = 102, g = 188, b = 217},
        ["PENTASTAR"] = {r = 55, g = 64, b = 184},
        ["YEVETHA"] = {r = 248, g = 237, b = 60},
        ["TERADOC"] = {r = 255, g = 20, b = 50},
        ["PIRATES"] = {r = 179, g = 148, b = 105},
        ["HUTTS"] = {r = 255, g = 255, b = 255},
        ["WARLORDS"] = {r = 142, g = 195, b = 0},
        ["CORPORATE_SECTOR"] = {r = 176, g = 124, b = 172},
        ["HARRSK"] = {r = 142, g = 195, b = 0},
        ["NEUTRAL"] = {r = 100, g = 100, b = 100},
        ["HOSTILE"] = {r = 153, g = 21, b = 223}
    },
    ALL_PLANETS = {},
    Events = {
        SelectedPlanetChanged = nil,
        PlanetOwnerChanged = PlanetOwnerChangedEvent:New(),
        GalacticProductionFinished = ProductionFinishedEvent:New()
    }
}

function GLOBALS.Init()
    if Get_Game_Mode() == "Galactic" then
        GLOBALS.PLAYER_AGNOSTIC_PLOT = Get_Story_Plot("Player_Agnostic_Plot.xml")
        GLOBALS.ALL_PLANETS = FindPlanet.Get_All_Planets()

        for i, faction in pairs(GLOBALS.PLAYABLE_FACTIONS) do
            if Find_Player(faction).Is_Human() then
                GLOBALS.PLAYER = Find_Player(faction)
            end
        end

        GLOBALS.Events.SelectedPlanetChanged = SelectedPlanetChangedEvent:New(GLOBALS.PLAYER)

    elseif Get_Game_Mode() == "Space" then
        GLOBALS.PLAYER_AGNOSTIC_PLOT = Get_Story_Plot("Conquests\\Tactical_Raids.XML")
    end

    if GLOBALS.PLAYER_AGNOSTIC_PLOT then
        GLOBALS.SHOW_TEXT_EVENT = GLOBALS.PLAYER_AGNOSTIC_PLOT.Get_Event("Show_Screen_Text")
        GLOBALS.SHOW_TEXT_NOTIFICATION_NAME = "SHOW_SCREEN_TEXT"
    end
end

function GLOBALS.InitializeEvents()
    if not CONST_STORY_THREAD_FLAG then
        return
    end

    for i, planet in pairs(GLOBALS.ALL_PLANETS) do
        local planetName = planet.Get_Type().Get_Name()
        local event = GLOBALS.PLAYER_AGNOSTIC_PLOT.Get_Event("Zoom_Into_"..planetName)
        if event then
            event.Set_Reward_Parameter(1, GLOBALS.PLAYER.Get_Faction_Name())
        end
    end
end

function GLOBALS.Update()
    GLOBALS.Events.SelectedPlanetChanged:Check()
    GLOBALS.Events.PlanetOwnerChanged:Check()
    GLOBALS.Events.GalacticProductionFinished:Check()
end

function GLOBALS.GetSelectedPlanet()
    local selectedPlanetName = GlobalValue.Get("SELECTED_PLANET")
    if not ValidGlobalValue(selectedPlanetName) then
        return nil
    end
    return FindPlanet(selectedPlanetName)
end

function GLOBALS.ShowScreenText(textId, time, var, color)
    if not GLOBALS.SHOW_TEXT_EVENT then return end

    local colorString = ""
    if color then
        colorString = color.r.." "..color.g.." "..color.b
    end

    if not var then
        var = ""
    end
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(0, textId)
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(1, tostring(time))
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(2, var)
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(3, "")
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(5, colorString)
    Story_Event(GLOBALS.SHOW_TEXT_NOTIFICATION_NAME)
end

function GLOBALS.RemoveScreenText(textId)
    if not GLOBALS.SHOW_TEXT_EVENT then return end
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(0, textId)
    GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(3, "remove")
    Story_Event(GLOBALS.SHOW_TEXT_NOTIFICATION_NAME)
end

return GLOBALS
