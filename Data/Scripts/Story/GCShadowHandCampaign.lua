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
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCShadowHandCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:30:29-04:00
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
      Determine_Faction_LUA = Find_Faction,
      Eclipse_Completed_Generic = Palpatine_Joins,
	  Warlords_Breakoff = Empire_Fractures,
	  Luke_Completed = Luke_Joins,
	  Lose_Luke = Luke_Betrays_Empire,
	  Save_Luke = Luke_Rejoins,
      Empire_wins_Coruscant = Spawn_Empire_Reward,
	  Balmorran_Revolt_Narrative = Spawn_Balmorrans,
	  Conquer_Balmorra = Balmorran_Reward,
	  Balmorra_Mission_Won = Noncanonical_Byss_Takeover
    }

end

function Find_Faction(message)
  if message == OnEnter then

    local p_newrep = Find_Player("Rebel")
    local p_empire = Find_Player("Empire")

    if p_newrep.Is_Human() then
      Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
      Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
    end
  end
end

function Palpatine_Joins(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_newrep = Find_Player("Rebel")
    local start_planet = FindPlanet("Byss")

    --ChangePlanetOwnerAndRetreat(start_planet, p_empire)

	start_planet.Change_Owner(p_empire)
    local spawn_list_emperor = { "Emperor_Palpatine_Team", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "E_Ground_Heavy_Vehicle_Factory", "E_Ground_Advanced_Vehicle_Factory", "E_Ground_Advanced_Vehicle_Factory" }
    local EmperorSpawn = SpawnList(spawn_list_emperor, start_planet, p_empire,true,false)
	
	if p_newrep.Is_Human() then
        spawn_list_luke = { "Luke_Skywalker_Darkside_Team" }
        LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_empire,true,false)
      end


  end
end

function Empire_Fractures(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_maldrood = Find_Player("Teradoc")
    local p_eriadu = Find_Player("Hutts")
    local p_harrsk = Find_Player("Warlords")
    local p_pentastar = Find_Player("Pentastar")


    --Carnor takes control of the Empire

     start_planet = FindPlanet("Byss")
    if start_planet.Get_Owner() == p_empire then
       local spawn_list = { "Carnor_Jax_Team" }
       local ImperialForces = SpawnList(spawn_list, start_planet, p_empire, true, false)
    end

    --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

    local checkTeradoc = Find_First_Object("CrimsonSunrise_Star_Destroyer")
    if TestValid(checkTeradoc) then
      checkTeradoc.Despawn()
    end

    local start_planet = FindPlanet("Centares")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
      local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","13X_Teradoc" , "Crimson_Victory" , "Crimson_Victory" , "Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Crimson_Victory"}
       local ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
    end

    local checkKosh = Find_First_Object("Lancet_Kosh")
    if TestValid(checkKosh) then
      checkKosh.Despawn()
    end

    local start_planet = FindPlanet("Hakassi")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
       local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Lancet_Kosh" , "Strike_Cruiser" ,"Strike_Cruiser" ,"Strike_Cruiser"  }
       local ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
    end

    --Zero Command

    local checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
    if TestValid(checkHarrsk) then
      checkHarrsk.Despawn()
    end

    local start_planet = FindPlanet("Kalist")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
	   local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Strike_Cruiser" ,"Strike_Cruiser", "Shockwave_Star_Destroyer" }
       local ImperialForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
    end

    --Pentastar
    local start_planet = FindPlanet("Entralla")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
      local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Strike_Cruiser" ,"Strike_Cruiser" }
      local ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
    end

    local start_planet = FindPlanet("Bastion")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
      local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two"}
      local ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
    end

    -- Delvardus

    local checkDelvardus = Find_First_Object("Thalassa")
    if TestValid(checkDelvardus) then
      checkDelvardus.Despawn()
    end

    local start_planet = FindPlanet("Eriadu")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
      local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Escort_Carrier","Escort_Carrier", "Torpedo_Sphere" ,"Torpedo_Sphere"  }
      local ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
    end

    local start_planet = FindPlanet("Kampe")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
      local spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" , "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Escort_Carrier", "Escort_Carrier","Escort_Carrier","Thalassa", "Night_Hammer" }
      local ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
    end

  end
end

function Spawn_Empire_Reward(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local start_planet = FindPlanet("Coruscant")


	local spawn_list_coruscant = {"Generic_Star_Destroyer_Two", "Generic_Secutor", "Generic_Allegiance", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Generic_Interdictor_Cruiser", "Generic_Victory_Destroyer", "Vindicator_Cruiser", "Carrack_Cruiser", "Carrack_Cruiser", "Lancer_Frigate", "Lancer_Frigate", "Lancer_Frigate", "Raider_Pentastar", "Generic_Procursator", "Generic_Victory_Destroyer_Two", "Generic_Star_Destroyer", "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "Generic_Victory_Destroyer" }
    local CoruscantSpawn = SpawnList(spawn_list_coruscant, start_planet, p_empire,false,false)

  end
end

function Luke_Joins(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    start_planet = FindPlanet("Byss")

    if start_planet.Get_Owner() ~= Find_Player("Empire") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Empire") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_luke = { "Luke_Skywalker_Darkside_Team" }
    LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_empire,true,false)

  end
end

function Luke_Betrays_Empire(message)
  if message == OnEnter then

    p_rebel = Find_Player("Rebel")
    start_planet = FindPlanet("Yavin")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_luke = { "Luke_Skywalker_Jedi_Team" }
    LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_rebel,true,false)

  end
end

function Luke_Rejoins(message)
  if message == OnEnter then

    p_rebel = Find_Player("Rebel")
    start_planet = FindPlanet("Yavin")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_luke = { "Luke_Skywalker_Jedi_Team" }
    LukeSpawn = SpawnList(spawn_list_luke, start_planet, p_rebel,true,false)
 
   end
 end
 
 function Spawn_Balmorrans(message)
  if message == OnEnter then
  
	local p_empire = Find_Player("Empire")
	local p_balmorra = Find_Player("Warlords")

    local start_planet = FindPlanet("Balmorra")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_balmorra)

      local spawn_list = { "Generic_Star_Destroyer", "Generic_Star_Destroyer_Two", "Generic_Procursator", "Generic_Procursator", "Dreadnaught_Empire", "Dreadnaught_Empire", "Dreadnaught_Empire", "Raider_Pentastar", "Raider_Pentastar", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid", "C_Hailfire_Company", "C_Hailfire_Company", "B1_Droid_Squad", "B1_Droid_Squad", "B1_Droid_Squad" }
      local Balmorrans = SpawnList(spawn_list, start_planet, p_balmorra, false, false)
    end

  elseif message == OnUpdate then

  end
end

function Balmorran_Reward(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local start_planet = FindPlanet("Balmorra")


    if start_planet.Get_Owner() == Find_Player("Empire") then
      local spawn_list_balmorra = { "Imperial_Heavy_Assault_Company" , "Imperial_Heavy_Assault_Company", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid" }
      local BalmorraSpawn = SpawnList(spawn_list_balmorra, start_planet, p_empire,true, false)
    end

  elseif message == OnUpdate then
  end
end

function Noncanonical_Byss_Takeover(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Byss")

	start_planet.Change_Owner(p_rebel)
    local spawn_list_unlikely_conquerors = { "Delvardus_Heavy_Assault_Company", "Imperial_XR85_Tankdroid" }
    local BalmorraSpawn = SpawnList(spawn_list_unlikely_conquerors, start_planet, p_rebel,true, false)

  elseif message == OnUpdate then
  end
end