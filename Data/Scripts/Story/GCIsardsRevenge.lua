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
--*   @Last modified time:  2018-02-03T12:22:17-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")
TM = require("TRGameModeTransactions")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
    {
      Determine_Faction_LUA = Find_Faction,
	  Requiem_Appears = Requiem_Spawn,
	  NR_Builds_Lusankya = NR_Lusankya,
	  Isard_Takes_Lusankya = CH_Lusankya
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
      Story_Event("ENABLE_BRANCH_MALDROOD_FLAG")
    elseif p_yevetha.Is_Human() then
      Story_Event("ENABLE_BRANCH_YEVETHA_FLAG")
    end
  end
end

function Requiem_Spawn(message)
  if message == OnEnter then

    p_rebel = Find_Player("Rebel")
    start_planet = FindPlanet("Ciutric")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_requiem = { "Requiem_Squadron_Space" }
    RequiemSpawn = SpawnList(spawn_list_requiem, start_planet, p_rebel,false,false)

  end
end

function NR_Lusankya(message)
  if message == OnEnter then

    p_rebel = Find_Player("Rebel")
    start_planet = FindPlanet("Bilbringi")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_lusankya = { "Wedge_Lusankya" }
    LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_rebel,false,false)

  end
end

function CH_Lusankya(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    start_planet = FindPlanet("Bilbringi")

    if start_planet.Get_Owner() ~= Find_Player("Empire") then
      allPlanets = FindPlanet.Get_All_Planets()
      random = GameRandom(1, table.getn(allPlanets))
      start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Empire") do
        random = GameRandom(1, table.getn(allPlanets))
        start_planet = allPlanets[random]
      end
    end

    spawn_list_lusankya = { "Lusankya", "TIE_Defender_Squadron_Buildable", "TIE_Defender_Squadron_Buildable" }
    LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_empire,false,false)

  end
end