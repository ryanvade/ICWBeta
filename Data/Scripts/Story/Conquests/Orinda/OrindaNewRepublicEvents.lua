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
--*    @Filename:            OrindaNewRepublicEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Wed Jun 13 2018 02:45:12
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
function RegisterNewRepublicEvents()

    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Corthenia")
        local rebel = Find_Player("Rebel")
        Spawn_Unit(Find_Object_Type("Han_Solo_Team"), spawnPlanet, rebel)
        
        spawnPlanet = FindPlanet("Darkon")
        Spawn_Unit(Find_Object_Type("Luke_Skywalker_Jedi_Team"), spawnPlanet, rebel)
        
        spawnPlanet = FindPlanet("Bilbringi")
        Spawn_Unit(Find_Object_Type("Wedge_Lusankya"), spawnPlanet, rebel)

        spawnPlanet = FindPlanet("Lonnaw")
        Spawn_Unit(Find_Object_Type("Bell_Endurance"), spawnPlanet, rebel)
        Spawn_Unit(Find_Object_Type("Rogue_Squadron_Space"), spawnPlanet, rebel)
        
    end)
end
