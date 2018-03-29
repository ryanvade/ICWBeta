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
      Empire_wins_Coruscant = Spawn_Empire_Reward
    }

end

function Find_Faction(message)
  if message == OnEnter then

     p_newrep = Find_Player("Rebel")
     p_empire = Find_Player("Empire")

    if p_newrep.Is_Human() then
      Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
      Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
    end
  end
end

function Palpatine_Joins(message)
  if message == OnEnter then

     p_empire = Find_Player("Empire")
     p_newrep = Find_Player("Rebel")
     start_planet = FindPlanet("Byss")

    --ChangePlanetOwnerAndRetreat(start_planet, p_empire)

     spawn_list_emperor = { "Emperor_Palpatine_Team" }
     EmperorSpawn = SpawnList(spawn_list_emperor, start_planet, p_empire,true,false)


  end
end

function Empire_Fractures(message)
  if message == OnEnter then

     p_empire = Find_Player("Empire")
     p_maldrood = Find_Player("Teradoc")
     p_eriadu = Find_Player("Hutts")
     p_harrsk = Find_Player("Harrsk")
     p_pentastar = Find_Player("Pentastar")


    --Carnor takes control of the Empire

     start_planet = FindPlanet("Byss")
    if start_planet.Get_Owner() == p_empire then
       spawn_list = { "Carnor_Jax_Team" }
       ImperialForces = SpawnList(spawn_list, start_planet, p_empire, true, false)
    end

    --Federated Teradoc Union (Centares for Treutan, Hakassi for Kosh)

     checkTeradoc = Find_First_Object("13X_Teradoc")
    if TestValid(checkTeradoc) then
      checkHarrsk.Despawn()
    end

     start_planet = FindPlanet("Centares")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","13X_Teradoc" , "Crimson_Victory" , "Crimson_Victory" , "Crimson_Victory", "Crimson_Victory", "Crimson_Victory", "Crimson_Victory"}
       ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
    end

     checkKosh = Find_First_Object("Lancet_Kosh")
    if TestValid(checkKosh) then
      checkHarrsk.Despawn()
    end

     start_planet = FindPlanet("Hakassi")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_maldrood)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Lancet_Kosh" , "Strike_Cruiser" ,"Strike_Cruiser" ,"Strike_Cruiser"  }
       ImperialForces = SpawnList(spawn_list, start_planet, p_maldrood, true, false)
    end

    --Zero Command

     checkHarrsk = Find_First_Object("Shockwave_Star_Destroyer")
    if TestValid(checkHarrsk) then
      checkHarrsk.Despawn()
    end

     start_planet = FindPlanet("Kalist")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)
	    spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Strike_Cruiser" ,"Strike_Cruiser"  }
       ImperialForces = SpawnList(spawn_list, start_planet, p_harrsk, true, false)
    end

    --Pentastar
     start_planet = FindPlanet("Entralla")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Strike_Cruiser" ,"Strike_Cruiser" }
       ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
    end

     start_planet = FindPlanet("Bastion")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_pentastar)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Generic_Bellator" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two"}
       ImperialForces = SpawnList(spawn_list, start_planet, p_pentastar, true, false)
    end

    -- Delvardus

     checkDelvardus = Find_First_Object("Thalassa")
    if TestValid(checkDelvardus) then
      checkHarrsk.Despawn()
    end

     start_planet = FindPlanet("Eriadu")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" ,"Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Escort_Carrier","Escort_Carrier", "Torpedo_Sphere" ,"Torpedo_Sphere"  }
       ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
    end

     start_planet = FindPlanet("Kampe")
    if start_planet.Get_Owner() == p_empire then
      ChangePlanetOwnerAndRetreat(start_planet, p_eriadu)
       spawn_list = { "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Assault_Company", "Imperial_Heavy_Scout_Squad", "Imperial_Heavy_Scout_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad","Torpedo_Sphere" , "Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two","Generic_Star_Destroyer_Two", "Escort_Carrier", "Escort_Carrier","Escort_Carrier","Thalassa", "Night_Hammer" }
       ImperialForces = SpawnList(spawn_list, start_planet, p_eriadu, true, false)
    end

  end
end

function Spawn_Empire_Reward(message)
  if message == OnEnter then

     p_empire = Find_Player("Empire")
     start_planet = FindPlanet("Coruscant")


	 spawn_list_coruscant = {"Generic_Star_Destroyer_Two", "Generic_Secutor", "Generic_Allegiance", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Generic_Interdictor_Cruiser", "Generic_Victory_Destroyer", "Vindicator_Cruiser", "Carrack_Cruiser", "Carrack_Cruiser", "Lancer_Frigate", "Lancer_Frigate", "Lancer_Frigate", "Raider_Pentastar", "Generic_Procursator", "Generic_Victory_Destroyer_Two", "Generic_Star_Destroyer", "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "Generic_Victory_Destroyer" }
     CoruscantSpawn = SpawnList(spawn_list_coruscant, start_planet, p_empire,true,false)

  elseif message == OnUpdate then
  end
end
