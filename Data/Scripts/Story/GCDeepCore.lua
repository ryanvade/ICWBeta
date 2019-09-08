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
require("ChangeOwnerUtilities")
TRUtil = require("TRUtil")


function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction,
	Era_Selection = Era_Setup,
	Night_Hammer_Complete = Night_Hammer_Spawn,
	The_game_has_gone_too_long = Duo_spawn
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
	end

  end
end

function Era_Setup(message)
  if message == OnEnter then
    p_maldrood = Find_Player("Teradoc")
	p_harrsk = Find_Player("Empire")
	p_eriadu = Find_Player("Hutts")
	techLevel = p_maldrood.Get_Tech_Level()
	if techLevel < 3 then
		Story_Event("START_ERA_2")
		
		--Kosh in the core, Crimson Command out in Maldrood sector with Treutan
		start_planet = FindPlanet("Hakassi")
		spawn_list_hakassi = { "Lancet_Kosh", "Generic_Procursator", "Strike_Cruiser", "Strike_Cruiser", "Arquitens", "IPV1_Teradoc", "IPV1_Teradoc" }
		SpawnList(spawn_list_hakassi, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Ojom")
		spawn_list_ojom = { "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser" }
		SpawnList(spawn_list_ojom, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Ebaq")
		spawn_list_ebaq = { "Generic_Procursator", "Generic_Victory_Destroyer", "Escort_Carrier", "Escort_Carrier" }
		SpawnList(spawn_list_ebaq, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Columus")
		spawn_list_columus = { "Tavira_Invidious", "Neutron_Star", "Escort_Carrier", "Arquitens", "IPV1_Teradoc" }
		SpawnList(spawn_list_columus, start_planet, p_maldrood,true,false)
		
		start_planet = FindPlanet("Kalist")
		spawn_list_kalist = { "Whirlwind_Star_Destroyer", "Noils_Team", "Generic_Allegiance", "Lancer_Frigate", "Agamar_Meniscus", "Vindicator_Cruiser" } --Ilthmar's fist
		SpawnList(spawn_list_kalist, start_planet, p_harrsk,true,false)
		
		--Extra starting forces for the Night Hammerless EA
		start_planet = FindPlanet("Kampe")
		spawn_list_kampe = { "Torpedo_Sphere" }
		SpawnList(spawn_list_kampe, start_planet, p_eriadu,true,false)
		
		start_planet = FindPlanet("Tsoss")
		spawn_list_tsoss = { "Generic_Victory_Destroyer_Two", "Vigil", "Vindicator_Cruiser" }
		SpawnList(spawn_list_tsoss, start_planet, p_eriadu,true,false)
	else
		Story_Event("START_ERA_4")
		
		start_planet = FindPlanet("Hakassi")
		spawn_list_hakassi = { "13X_Pellaeon", "CrimsonSunrise_Star_Destroyer", "Crimson_Victory", "Crimson_Victory", "Arquitens", "IPV1_Teradoc" }
		SpawnList(spawn_list_hakassi, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Ojom")
		spawn_list_ojom = { "Crimson_Victory", "Crimson_Victory", "Strike_Cruiser", "Strike_Cruiser" }
		SpawnList(spawn_list_ojom, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Ebaq")
		spawn_list_ebaq = { "Crimson_Victory", "Crimson_Victory", "Escort_Carrier", "Escort_Carrier" }
		SpawnList(spawn_list_ebaq, start_planet, p_maldrood,true,false)
		start_planet = FindPlanet("Columus")
		spawn_list_columus = { "Neutron_Star", "Escort_Carrier", "Arquitens", "IPV1_Teradoc" }
		SpawnList(spawn_list_columus, start_planet, p_maldrood,true,false)
		
		start_planet = FindPlanet("Kalist")
		spawn_list_kalist = { "Shockwave_Star_Destroyer", "Noils_Team", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer", "Generic_Star_Destroyer_Two", "Desanne_Redemption" } --The battlecruiser is probably gone by Darksaber
		SpawnList(spawn_list_kalist, start_planet, p_harrsk,true,false)
	end
	
	end
end

function Night_Hammer_Spawn(message)
  if message == OnEnter then
	p_eriadu = Find_Player("Hutts")
  
	start_planet = FindPlanet("Kampe")
	if start_planet.Get_Owner() ~= Find_Player("Hutts") then
		start_planet = TRUtil.FindFriendlyPlanet(p_eriadu)
	end
	if start_planet then
		spawn_list_Night_Hammer = { "Night_Hammer" }
		SpawnList(spawn_list_Night_Hammer, start_planet, p_eriadu, true, false)
	end	

	end
end

function Duo_spawn(message)
  if message == OnEnter then
	p_harrsk = Find_Player("Empire")
  
	start_planet = FindPlanet("Thomork")
	if start_planet.Get_Owner() ~= Find_Player("Empire") then
		start_planet = TRUtil.FindFriendlyPlanet(p_harrsk)
	end
	if start_planet then
		spawn_list_duo = { "Megador", "Dominion" }
		SpawnList(spawn_list_duo, start_planet, p_harrsk, true, false)
	end	

	end
end