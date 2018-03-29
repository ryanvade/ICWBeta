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
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:31:34-05:00
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
    Universal_Story_Start = Begin_GC,
    Determine_Faction_LUA = Find_Faction,
    Maldrood_Antem = Antem_Maldrood,
    Maldrood_Kashyyyk = Kashyyyk_Maldrood,
    Maldrood_Commenor = Commenor_Maldrood,
    Eriadu_Elrood = Elrood_Eriadu,
    Set_Subera_Isard = SubEra_Change,
    Talks_End = Pentastar_Talks
  }

end

function Find_Faction(message)
  if message == OnEnter then

	 p_newrep = Find_Player("Rebel")
	 p_empire = Find_Player("Empire")
	 p_eoth = Find_Player("Underworld")
	 p_eriadu = Find_Player("Hutts")
	 p_pentastar = Find_Player("Pentastar")
	 p_zsinj = Find_Player("Pirates")
	 p_maldrood = Find_Player("Teradoc")
	 p_yevetha = Find_Player("Yevetha")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
	elseif p_eriadu.Is_Human() then
		Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
	elseif p_zsinj.Is_Human() then
		Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
	elseif p_maldrood.Is_Human() then
		Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
	elseif p_yevetha.Is_Human() then
		Story_Event("ENABLE_BRANCH_YEVETHA_FLAG")
	end

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
       CommenorSpawn = SpawnList(spawn_list_commenor, start_planet, p_maldrood,true, false)
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
       spawn_list_kosh = { "Getelles_Team" , "Larm_Carrack" }
       KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood,true, false)
      --end
    end

  elseif message == OnUpdate then

  end
end

function Kashyyyk_Maldrood(message)
  if message == OnEnter then

     p_maldrood = Find_Player("Teradoc")
     start_planet = FindPlanet("Kashyyyk")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("SYN_JOINS_SPEECH")
		end
       spawn_list_syn = { "Syn_Silooth" }
       SynSpawn = SpawnList(spawn_list_syn, start_planet, p_maldrood,true, false)
      --end
    end

  elseif message == OnUpdate then

  end
end

function Elrood_Eriadu(message)
  if message == OnEnter then

     p_eriadu = Find_Player("Hutts")
     start_planet = FindPlanet("Elrood")

	if start_planet.Get_Owner() == Find_Player("Hutts") then
		if p_eriadu.Is_Human() then
			Story_Event("ELROOD_JOINS_SPEECH")
		end
		 spawn_list_elrood = { "Andal_Team" , "Zed_Stalker" , "Pryl_Thunderflare" }
		 ElroodSpawn = SpawnList(spawn_list_elrood, start_planet, p_eriadu,true, false)
    end

  elseif message == OnUpdate then

  end

end

function SubEra_Change(message)
  if message == OnEnter then

	 p_empire = Find_Player("Empire")
     p_harrsk = Find_Player("Harrsk")

	 start_planet = FindPlanet("Coruscant")

	if start_planet.Get_Owner() ~= Find_Player("Empire") then
		 allPlanets = FindPlanet.Get_All_Planets()
		 random = GameRandom(1, table.getn(allPlanets))
		 start_planet = allPlanets[random]
	  while start_planet.Get_Owner() ~= Find_Player("Empire") do
			 random = GameRandom(1, table.getn(allPlanets))
			 start_planet = allPlanets[random]
		end
	end

	 spawn_list_isard = { "Lusankya" , "Implacable_Star_Destroyer" }
	 IsardSpawn = SpawnList(spawn_list_isard, start_planet, p_empire,true, false)

	 checkPestage = Find_First_Object("Sate_Pestage")
  if TestValid(checkPestage) then
    checkPestage.Despawn()
  end

   checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
  if TestValid(checkHarrsk) then
    checkHarrsk.Despawn()
  end

	 ProjectAmbition = Find_First_Object("Project_Ambition_Dummy")
	if ProjectAmbition then
		 spawn_list_ambition = { "Makati_Steadfast" , "Takel_MagicDragon" , "Corrupter_Star_Destroyer" }
		 AmbitionRewards = SpawnList(spawn_list_ambition, start_planet, p_empire,true, false)
		ProjectAmbition.Despawn()
	end

    --Harrsk spawns

     start_planet = FindPlanet("Kalist")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

       spawn_list = { "Shockwave_Star_Destroyer" , "P_Ground_Barracks"  , "P_Ground_Light_Vehicle_Factory"   }
       HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, false, false)
    end

     start_planet = FindPlanet("Abregado_Rae")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

       spawn_list = { "P_Ground_Barracks" , "P_Ground_Light_Vehicle_Factory"   }
       HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, false, false)
    end

	elseif message == OnUpdate then

  end
end

function Pentastar_Talks(message)
  if message == OnEnter then

      p_pentastar = Find_Player("Pentastar")

	 start_planet = FindPlanet("Bastion")
	if start_planet.Get_Owner() == Find_Player("Pentastar") then
		if p_pentastar.Is_Human() then
			Story_Event("KAINE_JOINS_SPEECH")
		end
		 spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
		 ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true, false)
	end


  elseif message == OnUpdate then

  end
end
