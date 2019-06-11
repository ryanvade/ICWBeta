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
--*    @Date:                Wed Jun 13 2018
--*    @Project:             Imperial Civil War
--*    @Filename:            FIPNewRepublicEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Wed Jun 13 2018 22:40:22
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
function RegisterNewRepublicEvents()

    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Coruscant")
        local rebel = Find_Player("Rebel")

        SpawnList({"Han_Solo_Team", "Luke_Skywalker_Jedi_Team"}, spawnPlanet, rebel, not rebel.Is_Human(), false)

        spawnPlanet = FindPlanet("Bilbringi")
        Spawn_Unit(Find_Object_Type("Ackbar_Guardian"), spawnPlanet, rebel)

        spawnPlanet = FindPlanet("Obredaan")
        SpawnList({"Iblis_Selonian_Fire", "Rogue_Squadron_Space", "Abaht_Intrepid"}, spawnPlanet, rebel, not rebel.Is_Human(), false)
    end)
end
