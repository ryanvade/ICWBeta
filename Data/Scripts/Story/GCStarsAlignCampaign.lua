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
--*   @Author:              Corey
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCStarsAlignCampaign.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:39:24+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
	Determine_Faction_LUA = Find_Faction,
    Talks_End = Begin_GC
  }

end

function Find_Faction(message)
  if message == OnEnter then

	local p_pentastar = Find_Player("Pentastar")

    if p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
    end
  end
end

function Begin_GC(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")
    p_pentastar = Find_Player("Pentastar")

    start_planet = FindPlanet("Bastion")
	
	if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
       allPlanets = FindPlanet.Get_All_Planets()
       random = GameRandom(1, table.getn(allPlanets))
       start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Pentastar") do
         random = GameRandom(1, table.getn(allPlanets))
         start_planet = allPlanets[random]
      end
    end
	
	if p_pentastar.Is_Human() then
  		Story_Event("KAINE_JOINS_SPEECH")
  	end
	
    spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
    ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)

	ScriptExit()
  elseif message == OnUpdate then

  end
end

