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
        local spawnPlanet = FindPlanet("Brentaal")
        local rebel = Find_Player("Rebel")
        Spawn_Unit(Find_Object_Type("Mon_Mothma_Team"), spawnPlanet, rebel)
        Spawn_Unit(Find_Object_Type("Luke_Skywalker_Jedi_Team"), spawnPlanet, rebel)
        Spawn_Unit(Find_Object_Type("Home_One"), spawnPlanet, rebel)
        
        spawnPlanet = FindPlanet("Generis")
        Spawn_Unit(Find_Object_Type("Han_Solo_Team"), spawnPlanet, rebel)
        Spawn_Unit(Find_Object_Type("Airen_Cracken_Team"), spawnPlanet, rebel)
        
        spawnPlanet = FindPlanet("Ithor")
        Spawn_Unit(Find_Object_Type("Iillor_Corusca"), spawnPlanet, rebel)

        spawnPlanet = FindPlanet("Levian")
        Spawn_Unit(Find_Object_Type("Lando_Calrissian_Team"), spawnPlanet, rebel)
        Spawn_Unit(Find_Object_Type("Katarn_Team"), spawnPlanet, rebel)
        
    end)
end
