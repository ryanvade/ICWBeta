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
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCZsinjCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:33:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Universal_Story_Start = Begin_GC,
    Zsinj_Death = On_Zsinj_Death,
    Maldrood_Antem = Antem_Maldrood,
	Maldrood_Commenor = Commenor_Maldrood,
  }

end

function Begin_GC(message)
  if message == OnEnter then
--    Testing Zsinj Kill
--    Sleep(10)
--    Find_First_Object("Iron_Fist").Despawn()
  end
end

function On_Zsinj_Death(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")
    p_maldrood = Find_Player("Teradoc")
    p_corporate = Find_Player("Corporate_Sector")
    p_zsinj = Find_Player("Pirates")

    --Post-Zsinj, Kosh merges with Treutan
    start_planet = FindPlanet("Centares")
	if start_planet.Get_Owner() == p_maldrood then
		spawn_list_kosh = { "Lancet_Kosh" }
		KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood, false, false)
	end
	
    --Corporate Sector Spawns

    start_planet = FindPlanet("Etti_IV")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Etti")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

    spawn_list = { "Lucrehulk", "Lucrehulk" }

      ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, false, false)
    end


    start_planet = FindPlanet("Ession")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Ession")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

      spawn_list = { "Lucrehulk", "Lucrehulk" }
      ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, false, false)
    end


    start_planet = FindPlanet("Bonadan")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Bonadan")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

      spawn_list = { "Lucrehulk", "Lucrehulk" }
      ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, false, false)
    end
  elseif message == OnUpdate then

  end
end

function Commenor_Maldrood(message)
  if message == OnEnter then

    p_maldrood = Find_Player("Teradoc")
    start_planet = FindPlanet("Commenor")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("GENDARR_JOINS_SPEECH")
		end
      spawn_list_commenor = { "Lott_Team" , "Gendarr_Reliance" }
      CommenorSpawn = SpawnList(spawn_list_commenor, start_planet, p_maldrood,false,false)
    end

  elseif message == OnUpdate then
  end
end

function Antem_Maldrood(message)
  if message == OnEnter then

    p_maldrood = Find_Player("Teradoc")
    start_planet = FindPlanet("Antem")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("GETELLES_JOINS_SPEECH")
		end
      spawn_list_kosh = { "Getelles_Team" , "Larm_Carrack", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two" }
      KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood,false,false)
      --end
    end

  elseif message == OnUpdate then

  end
end
