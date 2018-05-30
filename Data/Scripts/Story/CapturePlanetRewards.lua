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
--*   @Author:              [TR]Pox
--*   @Date:                2017-10-05T20:50:45+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            CapturePlanetRewards.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:37:10+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("StoryEvents")
require("StoryEventManager")

function RegisterEmpireCapturePlanetRewards()
  local empire = Find_Player("Empire")

  local e_ground_barracks = Find_Object_Type("E_Ground_Barracks")
  local imperial_stormtrooper_squad = Find_Object_Type("Imperial_Stormtrooper_Squad")
  local planets = {"Coruscant", "Bastion", "Garos_IV", "Brentaal", "Denon", "Muunilinst", "Carida", "Commenor", "Telos", "Nirauan"}
  local defaultSpawns = {e_ground_barracks, imperial_stormtrooper_squad}
  local defaultText = "TEXT_REWARD_CAPTURE_URBAN_EMPIRE"
  RegisterCaptureEventsForPlanets(planets, empire, defaultSpawns, defaultText)


  local e_ground_light_vehicle_factory = Find_Object_Type("E_Ground_Light_Vehicle_Factory")
  planets = {"Corulag", "Ession", "Duro", "Gravan", "Abregado_Rae", "YagDhul", "Adumar"}
  defaultSpawns = { e_ground_light_vehicle_factory }
  defaultText = "TEXT_REWARD_CAPTURE_FACTORY_EMPIRE"
  RegisterCaptureEventsForPlanets(planets, empire, defaultSpawns, defaultText)


  local remnant_star_base_1 = Find_Object_Type("Remnant_Star_Base_1")
  planets = {"Corellia"}
  defaultSpawns = {remnant_star_base_1}
  defaultText = "TEXT_REWARD_CAPTURE_SHIPYARD_EMPIRE"
  RegisterCaptureEventsForPlanets(planets, empire, defaultSpawns, defaultText)


  local remnant_star_base_2 = Find_Object_Type("Remnant_Star_Base_2")
  planets = {"Kuat", "Syca", "Fondor", "Moncalimari", "Trasi", "Sluis_Van"}
  defaultSpawns = {remnant_star_base_2}
  defaultText = "TEXT_REWARD_CAPTURE_SHIPYARD_EMPIRE"
  RegisterCaptureEventsForPlanets(planets, empire, defaultSpawns, defaultText)


  local remnant_star_base_3 = Find_Object_Type("Remnant_Star_Base_3")
  planets = {"Byss"}
  defaultSpawns = {remnant_star_base_3}
  defaultText = "TEXT_REWARD_CAPTURE_SHIPYARD_EMPIRE"
  RegisterCaptureEventsForPlanets(planets, empire, defaultSpawns, defaultText)


  local battleDragon = Find_Object_Type("BattleDragon")
  local nova_cruiser = Find_Object_Type("Nova_Cruiser")
  planets = {"Hapes"}
  defaultSpawns = {battleDragon, battleDragon, battleDragon, nova_cruiser, nova_cruiser}
  defaultText = "TEXT_REWARD_CAPTURE_HAPES"
  RegisterCaptureEventsForPlanets(planets, faction, defaultSpawns, defaultText)


  local armadia = Find_Object_Type("Armadia")
  planets = {"Nzoth"}
  defaultSpawns = {armadia, armadia, armadia, armadia, armadia, armadia}
  defaultText = "TEXT_REWARD_CAPTURE_NZOTH"
  RegisterCaptureEventsForPlanets(planets, faction, defaultSpawns, defaultText)
end

function RegisterCaptureEventsForPlanets(planets, faction, defaultSpawns, defaultText)
  for _, planetName in pairs(planets) do
    local planet = FindPlanet(planetName)
    local name = "Empire_Capture_"..planetName.."_Reward"
    local event = PlanetOwnerChanged(planet, faction)
    local reward = DefaultCapturePlanetReward(planet, faction, defaultSpawns, defaultText)
    RegisterCaptureEvent(name, event, reward)
  end
end

function RegisterCaptureEvent(name, event, reward)
  StoryEventManager:RegisterEvent(
    Event(name):
    WithEventType(event):
    WithRewardType(reward):
    Create())
end

function DefaultCapturePlanetReward(planet, faction, spawnList, text)
  return {
    planet = planet,
    faction = faction,
    spawnList = spawnList,
    text = text,
    execute = function(self)
      SpawnUnits(self.spawnList, self.planet, self.faction):execute()
      ScreenText(self.text, 15, self.planet):execute()
    end
  }
end
