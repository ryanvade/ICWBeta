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
--*   @Date:                2017-12-18T14:01:25+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            ChangeOwnerUtilities.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-04T10:55:16-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")

function ChangePlanetOwnerAndRetreat(planet, newOwner)
  if planet.Get_Owner() ~= Find_Player("Neutral") then
    AssembleAllUnitsOnPlanetToFleet(planet)
    planet.Change_Owner(newOwner)
  end
end

function ChangeMultiplePlanets(planets, newOwner)
  local allUnitTypes = {}
  local lastPlanet = planets[table.getn(planets)]
  local unitsOnPlanet = nil
  for i, planet in pairs(planets) do
    unitsOnPlanet = GetFriendlyUnitsOnPlanet(planet)
    for j, unit in pairs(unitsOnPlanet) do
      table.insert(allUnitTypes, unit.Get_Type())
      DespawnUnit(unit)
    end
    if planet ~= lastPlanet then
      planet.Change_Owner(newOwner)
    end
  end

  unitsOnPlanet = {}
  for i, type in pairs(allUnitTypes) do
    local unit = Spawn_Unit(type, lastPlanet, lastPlanet.Get_Owner())[1]
    table.insert(unitsOnPlanet, unit)
  end

  local fleet = Assemble_Fleet(unitsOnPlanet)
  lastPlanet.Change_Owner(newOwner)
end

function DespawnUnit(unit)
  SetHeroDeathEnabled(unit, false)
  unit.Despawn()
  SetHeroDeathEnabled(unit, true)
end

function SetHeroDeathEnabled(hero, bool)
  if not unit.Is_Hero() then
    return
  end

  local enabled = 0
  if bool then
    enabled = 1
  end

  --set reward params and trigger event for hero
end

function GetFriendlyUnitsOnPlanet(planet)
  local planetOwner = planet.Get_Owner()
  local ownerUnits = Find_All_Objects_Of_Type(planetOwner)
  local unitsOnPlanet = {}

  for i, unit in pairs(ownerUnits) do
    if TestValid(unit) and unit.Get_Planet_Location then
      if unit.Get_Planet_Location() == planet then
        InsertUnitIfValid(unitsOnPlanet, unit)
      end
    end
  end

  return unitsOnPlanet
end

function InsertUnitIfValid(list, unit)
  if not IsValidCategory(unit) then
    return
  end

  if IsCompany(unit) then
    table.insert(list, unit.Get_Parent_Object())
  else
    table.insert(list, unit)
  end
end

function IsCompany(unit)
  local parent = unit.Get_Parent_Object()
  return parent and parent ~= planet and parent.Get_Type() ~= Find_Object_Type("Galactic_Fleet")
end

function AssembleAllUnitsOnPlanetToFleet(planet)
  local unitsOnPlanet = GetFriendlyUnitsOnPlanet(planet)
  local fleet = Assemble_Fleet(unitsOnPlanet)
end

function IsValidCategory(unit)
  local validCategories = {
    "Fighter",
    "Bomber",
    "Transport",
    "Corvette",
    "Frigate",
    "Capital",
    "SuperCapital",
    "Infantry",
    "Vehicle",
    "Air",
    "LandHero",
    "SpaceHero",
    "NonCombatHero"
  }

  if unit.Is_Category then
    for _, category in pairs(validCategories) do
      if unit.Is_Category(category) then
        return true
      end
    end
  end

  return false
end
