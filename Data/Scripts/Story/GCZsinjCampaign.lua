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
	Determine_Faction_LUA = Find_Faction,
    Zsinj_Death = On_Zsinj_Death,
	Spawn_Leia = Leia_Spawn,
	Spawn_Leia_Again = Leia_Respawn,
	Spawn_Hapans = Get_Hapes,
    Maldrood_Antem = Antem_Maldrood,
	Maldrood_Commenor = Commenor_Maldrood,
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


function On_Zsinj_Death(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local p_rebel = Find_Player("Rebel")
    local p_maldrood = Find_Player("Teradoc")
    local p_corporate = Find_Player("Corporate_Sector")
    local p_zsinj = Find_Player("Pirates")

    --Post-Zsinj, Kosh merges with Treutan
    local start_planet = FindPlanet("Centares")
	if start_planet.Get_Owner() == p_maldrood then
		local spawn_list_kosh = { "Lancet_Kosh" }
		local KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood, true, false)
	end
	
    --Corporate Sector Spawns

    local start_planet = FindPlanet("Etti_IV")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Etti")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

		local spawn_list = { "Lucrehulk", "Lucrehulk" }

		local ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, true, false)
    end


     start_planet = FindPlanet("Ession")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Ession")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

      local spawn_list = { "Lucrehulk", "Lucrehulk" }
      local ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, true, false)
    end


     local start_planet = FindPlanet("Bonadan")
    if start_planet.Get_Owner() == p_zsinj then
--			Story_Event("CORPORATE_EMERGE_Bonadan")
      ChangePlanetOwnerAndRetreat(start_planet, p_corporate)

       local spawn_list = { "Lucrehulk", "Lucrehulk" }
       local ImperialForces = SpawnList(spawn_list, start_planet, p_corporate, true, false)
    end
  elseif message == OnUpdate then

  end
end

function Leia_Spawn(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Coruscant")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
       allPlanets = FindPlanet.Get_All_Planets()
       random = GameRandom(1, table.getn(allPlanets))
       start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
         random = GameRandom(1, table.getn(allPlanets))
        local start_planet = allPlanets[random]
      end
    end

    local spawn_list_requiem = { "Princess_Leia_Team" }
    local LeiaSpawn = SpawnList(spawn_list_requiem, start_planet, p_rebel,true,false)

  end
end

function Leia_Respawn(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Coruscant")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
       allPlanets = FindPlanet.Get_All_Planets()
       random = GameRandom(1, table.getn(allPlanets))
       start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
         random = GameRandom(1, table.getn(allPlanets))
        local start_planet = allPlanets[random]
      end
    end

    local spawn_list_requiem = { "Princess_Leia_Team" }
    local LeiaSpawn = SpawnList(spawn_list_requiem, start_planet, p_rebel,true,false)

  end
end

function Get_Hapes(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Hapes")

	local spawn_list_hapan = { "Song_of_War", "AMM_BattleDragon", "AMM_Nova_Cruiser" }
    local HapesSpawn = SpawnList(spawn_list_hapan, start_planet, p_rebel,true,false)
	
    local spawn_list_hapan = { "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_Nova_Cruiser", "AMM_Nova_Cruiser" }
    local start_planet = FindPlanet("MistOne")
	local HapesSpawn = SpawnList(spawn_list_hapan, start_planet, p_rebel,true,false)
	
	local spawn_list_hapan = { "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon" }
	local start_planet = FindPlanet("MistTwo")
    local CharubahSpawn = SpawnList(spawn_list_hapan, start_planet, p_rebel,true,false)
	
	local spawn_list_hapan = { "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_BattleDragon", "AMM_Nova_Cruiser", "AMM_Nova_Cruiser" }
	local start_planet = FindPlanet("MistThree")
    local TerephonSpawn = SpawnList(spawn_list_hapan, start_planet, p_rebel,true,false)

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
       local CommenorSpawn = SpawnList(spawn_list_commenor, start_planet, p_maldrood,true, false)
    end

  elseif message == OnUpdate then
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
       local spawn_list_kosh = { "Getelles_Team" , "Larm_Carrack", "Generic_Star_Destroyer_Two", "Generic_Star_Destroyer_Two" }
       local KoshSpawn = SpawnList(spawn_list_kosh, start_planet, p_maldrood,true, false)
      --end
    end

  elseif message == OnUpdate then

  end
end
