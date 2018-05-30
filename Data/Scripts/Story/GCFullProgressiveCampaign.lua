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
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction,
    Maldrood_Antem = Antem_Maldrood,
    Maldrood_Kashyyyk = Kashyyyk_Maldrood,
    Maldrood_Commenor = Commenor_Maldrood,
    Eriadu_Elrood = Elrood_Eriadu,
    Set_Subera_Isard = SubEra_Change,
    Set_Subera_Palpatine = DarkEmpireSpawns,
    Set_Subera_Daala = DaalaSpawns,
    Set_Subera_Thrawn = ThrawnSpawns,
    Set_Subera_Jax = Empire_Fractures,
	Yevetha_Spawns = PellaeonSpawns
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
     SpawnList(spawn_list_commenor, start_planet, p_maldrood,true,false)
    end

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
     	SpawnList(spawn_list_kosh, start_planet, p_maldrood,true,false)
      --end
    end


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
    	SpawnList(spawn_list_syn, start_planet, p_maldrood,true,false)
      --end
    end


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
		SpawnList(spawn_list_elrood, start_planet, p_eriadu,true,false)
    end


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

	spawn_list_isard = { "Lusankya" }
	IsardSpawn = SpawnList(spawn_list_isard, start_planet, p_empire,true,false)

	checkPestage = Find_First_Object("Sate_Pestage")
  if TestValid(checkPestage) then
    checkPestage.Despawn()
  end

  checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
  if TestValid(checkHarrsk) then
    checkHarrsk.Despawn()
  end

	ProjectAmbition = Find_First_Object("Project_Ambition_Dummy")
	if TestValid(ProjectAmbition) then
		spawn_list_ambition = { "Makati_Steadfast" , "Takel_MagicDragon" , "Corrupter_Star_Destroyer" }
		SpawnList(spawn_list_ambition, start_planet, p_empire,true,false)
		ProjectAmbition.Despawn()
	end

    --Harrsk spawns

  start_planet = FindPlanet("Kalist")
  if TestValid(start_planet) then
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

     spawn_list = { "Shockwave_Star_Destroyer" }
     SpawnList(spawn_list, start_planet, p_harrsk, true, false)
    end
  end

    start_planet = FindPlanet("Abregado_Rae")
    if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

       spawn_list = { "Generic_Star_Destroyer" }
       SpawnList(spawn_list, start_planet, p_harrsk, true, false)
      end
    end


  end
end

function DarkEmpireSpawns(message)
  if message == OnEnter then

    p_Empire = Find_Player("Empire")
    start_planet = FindPlanet("Byss")

    ChangePlanetOwnerAndRetreat(start_planet, p_Empire)

    spawn_list_Palpatine = { "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Sedriss_Team", "Emperor_Palpatine_Team"  }
    SpawnList(spawn_list_Palpatine, start_planet, p_Empire,true,false)


    RegicideObject = Find_First_Object("Dummy_Regicide_Palpatine")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end

  end
end


function DaalaSpawns(message)
  if message == OnEnter then

    p_Empire = Find_Player("Empire")
    start_planet = FindPlanet("The_Maw")

    ChangePlanetOwnerAndRetreat(start_planet, p_Empire)

    spawn_list_Daala = { "Imperial_Stormtrooper_Squad", "Gorgon", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two"  }
    SpawnList(spawn_list_Daala, start_planet, p_Empire,true,false)

    RegicideObject = Find_First_Object("Dummy_Regicide_Daala")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end


  end
end

function ThrawnSpawns(message)
  if message == OnEnter then

    RegicideObject = Find_First_Object("Dummy_Regicide_Thrawn")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end


  end
end

function Empire_Fractures(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_maldrood = Find_Player("Teradoc")
    p_eriadu = Find_Player("Hutts")
    p_harrsk = Find_Player("Harrsk")
    p_pentastar = Find_Player("Pentastar")

    RegicideObject = Find_First_Object("Dummy_Regicide_Jax")
    if RegicideObject then
        RegicideObject.Despawn()
    else

      --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

      start_planet = FindPlanet("Centares")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
          spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","13X_Teradoc" , "Crimson_Victory" , "Crimson_Victory" , "Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Crimson_Victory"}
          SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end
      end

      start_planet = FindPlanet("Hakassi")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
         spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Lancet_Kosh" , "Strike_Cruiser" ,"Strike_Cruiser" ,"Strike_Cruiser" }
          SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end
      end

      --Zero Command

     start_planet = FindPlanet("Kalist")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
          spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" ,"Strike_Cruiser" ,"Strike_Cruiser" }
          SpawnList(spawn_list, start_planet, p_harrsk, true, false)
        end
      end

      --Pentastar
      start_planet = FindPlanet("Entralla")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
          spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" ,"Strike_Cruiser" ,"Strike_Cruiser"  }
          SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end
      end

      start_planet = FindPlanet("Bastion")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
          spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" }
          SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end
      end

      -- Delvardus

     start_planet = FindPlanet("Eriadu")
      if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
        spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Escort_Carrier","Escort_Carrier", "Torpedo_Sphere" ,"Torpedo_Sphere" ,"P_Ground_Barracks" , "P_Ground_Light_Vehicle_Factory" }
        SpawnList(spawn_list, start_planet, p_eriadu, true, false)
      end
    end

      start_planet = FindPlanet("Kampe")
      if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
        spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" , "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Escort_Carrier", "Escort_Carrier","Escort_Carrier","Thalassa", "Night_Hammer" }
        SpawnList(spawn_list, start_planet, p_eriadu, true, false)
      end
    end
  end
  end
end

function PellaeonSpawns(message)
  if message == OnEnter then

    local RegicideObject = Find_First_Object("Dummy_Regicide_Pellaeon")
    if RegicideObject then
        RegicideObject.Despawn()
    end

    local p_yevetha = Find_Player("Yevetha")

    local start_planet = FindPlanet("Nzoth")
    if TestValid(start_planet) then
      ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
      local spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer_Two", "Spaar_Aramadia", "Toorr_Devotion", "Voota_Splendor", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad"}
      local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
    end

	local start_planet = FindPlanet("Doornik")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
	local spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Attan_Beauty", "Noorr_Purity", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad" }
    local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
  end

	local start_planet = FindPlanet("Zfell")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
	local spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad"}
    local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
  end

	local start_planet = FindPlanet("ILC905")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
    local  spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad"}
    local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
  end

	local start_planet = FindPlanet("Polneye")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
	local spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad"}
   local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
  end

	local start_planet = FindPlanet("Jtptan")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_yevetha)
	local spawn_list_Yevethans = { "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Bille_Pride", "Yevethan_Heavy_Scout_Squad", "Yevethan_Heavy_Scout_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad", "Yevetha_Infantry_Squad"}
    local Yevethanspawn = SpawnList(spawn_list_Yevethans, start_planet, p_yevetha,true,false)
  end

  end
end
