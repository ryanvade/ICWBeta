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
	Spawn_Isard = Spawn_Lusankya,
    Talks_End = Begin_GC
  }

end

function Find_Faction(message)
  if message == OnEnter then

    local p_newrep = Find_Player("Rebel")
    local p_empire = Find_Player("Empire")
	local p_pentastar = Find_Player("Pentastar")

    if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
    end
  end
end

function Galactic(message)
  if message == OnEnter then

  elseif message == OnUpdate then
  end
end

function Begin_GC(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_rebel = Find_Player("Rebel")
    local p_pentastar = Find_Player("Pentastar")

    local start_planet = FindPlanet("Bastion")
	
	if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
       allPlanets = FindPlanet.Get_All_Planets()
       random = GameRandom(1, table.getn(allPlanets))
       start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Pentastar") do
         random = GameRandom(1, table.getn(allPlanets))
         start_planet = allPlanets[random]
      end
    end
	
    local spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
    local ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)



  elseif message == OnUpdate then

  end
end

function Spawn_Lusankya(message)
  if message == OnEnter then

     p_empire = Find_Player("Empire")

    --Post-Zsinj, Kosh merges with Treutan
     start_planet = FindPlanet("Ketaris")
     spawn_list_Lusankya = { "Lusankya" }
     LusankyaSpawn = SpawnList(spawn_list_Lusankya, start_planet, p_empire,true,false)

  elseif message == OnUpdate then

  end
end
