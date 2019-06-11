--[[
--******************************************************************************
--*     _______ __
--*    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--*      |   | |     |   _|  _  |  |  |  |     |__ --|
--*      |___| |__|__|__| |___._|________|__|__|_____|
--*     ______
--*    |   __ \.-----.--.--.-----.-----.-----.-----.
--*    |      <|  -__|  |  |  -__|     |  _  |  -__|
--*    |___|__||_____|\___/|_____|__|__|___  |_____|
--*                                    |_____|
--*    @Author:              [TR]Pox
--*    @Date:                Tue Jun 12 2018
--*    @Project:             Imperial Civil War
--*    @Filename:            FinalImperialPushEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Wed Jun 13 2018 02:43:33
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
function RegisterEmpireEvents()

    Event("Universal_Story_Start"):
    When(Always()):
    End()

    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Borosk")
        local empire = Find_Player("Empire")

        SpawnList({"Chimera_Pellaeon_Grand", "181st_Stele"}, spawnPlanet, empire, not empire.Is_Human(), false)

        spawnPlanet = FindPlanet("Hakassi")
        SpawnList({"Scylla", "Brakiss_Team"}, spawnPlanet, empire, not empire.Is_Human(), false)
    end)
end
