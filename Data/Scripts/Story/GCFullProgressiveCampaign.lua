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
    Determine_Faction_LUA = Find_Faction,
    Zsinj_Death = On_Zsinj_Death,
    Maldrood_Antem = Antem_Maldrood,
    Maldrood_Kashyyyk = Kashyyyk_Maldrood,
    Maldrood_Commenor = Commenor_Maldrood,
    Eriadu_Elrood = Elrood_Eriadu,
    Set_Subera_Isard = SubEra_Change,
    Talks_End = Pentastar_Talks,
    Hapes_Spawns = HapesSpawns,
    Yevetha_Spawns = PellaeonSpawns,
    Trigger_Council_Thrawn_Death = Ciutric_Breakway,
    Set_Subera_Palpatine = DarkEmpireSpawns,
    Set_Subera_Daala = DaalaSpawns,
    Set_Subera_Thrawn = ThrawnSpawns,
    Set_Subera_Jax = Empire_Fractures
  }

end

function Find_Faction(message)
  if message == OnEnter then

	local p_newrep = Find_Player("Rebel")
	local p_empire = Find_Player("Empire")
	local p_eoth = Find_Player("Underworld")
	local p_eriadu = Find_Player("Hutts")
	local p_pentastar = Find_Player("Pentastar")
	local p_zsinj = Find_Player("Pirates")
	local p_maldrood = Find_Player("Teradoc")
	local p_yevetha = Find_Player("Yevetha")

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

function On_Zsinj_Death(message)
  if message == OnEnter then

   local p_empire = Find_Player("Empire")
   local p_maldrood = Find_Player("Teradoc")
   local p_corporate = Find_Player("Corporate_Sector")
   local p_zsinj = Find_Player("Pirates")

    --Post-Zsinj, Kosh merges with Treutan
   local start_planet = FindPlanet("Centares")
    if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_maldrood then
       local spawn_list_kosh = { "Lancet_Kosh" }
       local KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood, true, false)
      end
    end



  end
end

function Commenor_Maldrood(message)
  if message == OnEnter then

   local p_maldrood = Find_Player("Teradoc")
   local start_planet = FindPlanet("Commenor")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("GENDARR_JOINS_SPEECH")
		end
     local spawn_list_commenor = { "Lott_Team" , "Gendarr_Reliance" }
     local CommenorSpawn = SpawnList(spawn_list_commenor, start_planet, p_maldrood,true,false)
    end

  end
end

function Antem_Maldrood(message)
  if message == OnEnter then

   local p_maldrood = Find_Player("Teradoc")
   local start_planet = FindPlanet("Antem")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("GETELLES_JOINS_SPEECH")
		end
     local spawn_list_kosh = { "Getelles_Team" , "Larm_Carrack" }
     local KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood,true,false)
      --end
    end


  end
end

function Kashyyyk_Maldrood(message)
  if message == OnEnter then

   local p_maldrood = Find_Player("Teradoc")
   local start_planet = FindPlanet("Kashyyyk")


    if start_planet.Get_Owner() == Find_Player("Teradoc") then
		if p_maldrood.Is_Human() then
			Story_Event("SYN_JOINS_SPEECH")
		end
     local spawn_list_syn = { "Syn_Silooth" }
     local SynSpawn = SpawnList(spawn_list_syn, start_planet, p_maldrood,true,false)
      --end
    end


  end
end

function Elrood_Eriadu(message)
  if message == OnEnter then

   local p_eriadu = Find_Player("Hutts")
   local start_planet = FindPlanet("Elrood")

	if start_planet.Get_Owner() == Find_Player("Hutts") then
		if p_eriadu.Is_Human() then
			Story_Event("ELROOD_JOINS_SPEECH")
		end
		local spawn_list_elrood = { "Andal_Team" , "Zed_Stalker" , "Pryl_Thunderflare" }
		local ElroodSpawn = SpawnList(spawn_list_elrood, start_planet, p_eriadu,true,false)
    end


  end

end

function SubEra_Change(message)
  if message == OnEnter then

	local p_empire = Find_Player("Empire")
    local p_harrsk = Find_Player("Harrsk")

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

	local spawn_list_isard = { "Lusankya" }
	local IsardSpawn = SpawnList(spawn_list_isard, start_planet, p_empire,true,false)

	local checkPestage = Find_First_Object("Sate_Pestage")
  if TestValid(checkPestage) then
    checkPestage.Despawn()
  end

  local checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
  if TestValid(checkHarrsk) then
    checkHarrsk.Despawn()
  end

	local ProjectAmbition = Find_First_Object("Project_Ambition_Dummy")
	if TestValid(ProjectAmbition) then
		spawn_list_ambition = { "Makati_Steadfast" , "Takel_MagicDragon" , "Corrupter_Star_Destroyer" }
		AmbitionRewards = SpawnList(spawn_list_ambition, start_planet, p_empire,true,false)
		ProjectAmbition.Despawn()
	end

    --Harrsk spawns

  local start_planet = FindPlanet("Kalist")
  if TestValid(start_planet) then
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

     local spawn_list = { "Shockwave_Star_Destroyer"  }
     local HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
    end
  end

    local start_planet = FindPlanet("Abregado_Rae")
    if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

       local spawn_list = { "Generic_Star_Destroyer" }
       local HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
      end
    end


  end
end

function Ciutric_Breakway(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_harrsk = Find_Player("Warlords")

    start_planet = FindPlanet("Ciutric")
    if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

        spawn_list = { "Generic_Star_Destroyer"  }
        HarrskForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
      end
    end



  end
end

function Pentastar_Talks(message)
  if message == OnEnter then

  local p_pentastar = Find_Player("Pentastar")

	local start_planet = FindPlanet("Bastion")
  if TestValid(start_planet) then
  	if start_planet.Get_Owner() == Find_Player("Pentastar") then
  		if p_pentastar.Is_Human() then
  			Story_Event("KAINE_JOINS_SPEECH")
  		end
  		local spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
  		local ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)
  	end
  end


  end
end

function HapesSpawns(message)
  if message == OnEnter then

   local p_hapes = Find_Player("Sarlacc")
   local start_planet = FindPlanet("Terephon")
  if TestValid(start_planet) then
    ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
    local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
    local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
  end

	local start_planet = FindPlanet("Charubah")
  if TestValid(start_planet) then
    ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
    local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
    local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
  end

	local start_planet = FindPlanet("Hapes")
  if TestValid(start_planet) then
  ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
    local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Star_Home", "Song_of_War"}
    local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
  end

	local start_planet = FindPlanet("MistOne")
  if TestValid(start_planet) then
    ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
    local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
    local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
  end

	local start_planet = FindPlanet("MistTwo")
  if TestValid(start_planet) then
    ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
    local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
    local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
  end

	local start_planet = FindPlanet("MistThree")
   if TestValid(start_planet) then
    ChangePlanetOwnerAndRetreat(start_planet, p_hapes)
   local spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
   local HapanSpawn = SpawnList(spawn_list_Hapans, start_planet, p_hapes,true,false)
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

function DarkEmpireSpawns(message)
  if message == OnEnter then

    local p_Empire = Find_Player("Empire")
    local start_planet = FindPlanet("Byss")

    ChangePlanetOwnerAndRetreat(start_planet, p_Empire)

    local spawn_list_Palpatine = { "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Sedriss_Team", "Emperor_Palpatine_Team"  }
    local PalpaSpawn = SpawnList(spawn_list_Palpatine, start_planet, p_Empire,true,false)


    local RegicideObject = Find_First_Object("Dummy_Regicide_Palpatine")
    if RegicideObject then
        RegicideObject.Despawn()
    end

  end
end


function DaalaSpawns(message)
  if message == OnEnter then

    local p_Empire = Find_Player("Empire")
    local start_planet = FindPlanet("The_Maw")

    ChangePlanetOwnerAndRetreat(start_planet, p_Empire)

    local spawn_list_Daala = { "Gorgon", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two"  }
    local DaalaSpawn = SpawnList(spawn_list_Daala, start_planet, p_Empire,true,false)

    local RegicideObject = Find_First_Object("Dummy_Regicide_Daala")
    if RegicideObject then
        RegicideObject.Despawn()
    end


  end
end

function ThrawnSpawns(message)
  if message == OnEnter then

    local RegicideObject = Find_First_Object("Dummy_Regicide_Thrawn")
    if RegicideObject then
        RegicideObject.Despawn()
    end


  end
end

function Empire_Fractures(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_maldrood = Find_Player("Teradoc")
    local p_eriadu = Find_Player("Hutts")
    local p_harrsk = Find_Player("Harrsk")
    local p_pentastar = Find_Player("Pentastar")

    local RegicideObject = Find_First_Object("Dummy_Regicide_Jax")
    if RegicideObject then
        RegicideObject.Despawn()
    else
    --Carnor takes control of the Empire

     local  start_planet = FindPlanet("Byss")
      if start_planet.Get_Owner() == p_empire then
        local spawn_list = { "Carnor_Jax_Team" }
        local ImperialForces = SpawnList(spawn_list, start_planet, p_empire, true, false)
      end

      --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

      local start_planet = FindPlanet("Centares")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
          local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","13X_Teradoc" , "Crimson_Victory" , "Crimson_Victory" , "Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Crimson_Victory"}
          local ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end
      end

      local start_planet = FindPlanet("Hakassi")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
         local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Lancet_Kosh" , "Strike_Cruiser" ,"Strike_Cruiser" ,"Strike_Cruiser" }
          local ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
        end
      end

      --Zero Command

     local start_planet = FindPlanet("Kalist")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
          local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" ,"Strike_Cruiser" ,"Strike_Cruiser" }
          local ImperialForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
        end
      end

      --Pentastar
      local start_planet = FindPlanet("Entralla")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
          local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" ,"Strike_Cruiser" ,"Strike_Cruiser"  }
          local ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end
      end

      local start_planet = FindPlanet("Bastion")
      if TestValid(start_planet) then
        if start_planet.Get_Owner() == p_empire then
          ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
          local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two" }
          local ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
        end
      end

      -- Delvardus

     local start_planet = FindPlanet("Eriadu")
      if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
        local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Escort_Carrier","Escort_Carrier", "Torpedo_Sphere" ,"Torpedo_Sphere" ,"P_Ground_Barracks" , "P_Ground_Light_Vehicle_Factory" }
        local ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
      end
    end

      local start_planet = FindPlanet("Kampe")
      if TestValid(start_planet) then
      if start_planet.Get_Owner() == p_empire then
        ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
        local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" , "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Escort_Carrier", "Escort_Carrier","Escort_Carrier","Thalassa", "Night_Hammer" }
        local ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
      end
    end
  end
  end
end
