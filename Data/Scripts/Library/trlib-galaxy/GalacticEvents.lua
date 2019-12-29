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
--*   @Date:                2018-03-10T01:31:48+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GalacticEvents.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:30:51+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("trlib-std/class")
require("trlib-std/Observable")
require("trlib-transactions/TableSerializer")
require("trlib-util/StoryUtil")

---@class PlanetOwnerChangedEvent : Observable
PlanetOwnerChangedEvent = class(Observable)

function PlanetOwnerChangedEvent:new(planets)
    self.planets = planets
end

function PlanetOwnerChangedEvent:Check()
    local planetOwnerChangedData = GlobalValue.Get("PLANET_OWNER_CHANGED")
    if StoryUtil.ValidGlobalValue(planetOwnerChangedData) then
        local planet = self.planets[planetOwnerChangedData]
        self:Notify(planet)
        GlobalValue.Set("PLANET_OWNER_CHANGED", "")
    end
end

---@class ProductionStartedEvent : Observable
ProductionStartedEvent = class(Observable)

function ProductionStartedEvent:new(planets)
    ---@private
    ---@type Planet[]
    self.planets = planets
end

function ProductionStartedEvent:Check()
    if StoryUtil.ValidGlobalValue(GlobalValue.Get("PRODUCTION_STARTED")) then
        local event_info = Deserialize(GlobalValue.Get("PRODUCTION_STARTED"))
        local productionPlanet = event_info.planet_name
        local object_type_name = event_info.object_type_name
        local planet = self.planets[productionPlanet]
        self:Notify(planet, object_type_name)
        GlobalValue.Set("PRODUCTION_STARTED", "")
    end
end

---@class ProductionFinishedEvent : Observable
ProductionFinishedEvent = class(Observable)

function ProductionFinishedEvent:new(planets)
    self.planets = planets
end

function ProductionFinishedEvent:Check()
    if StoryUtil.ValidGlobalValue(GlobalValue.Get("PRODUCTION_FINISHED")) then
        local event_info = Deserialize(GlobalValue.Get("PRODUCTION_FINISHED"))
        local productionPlanet = event_info.planet_name
        local object_type_name = event_info.object_type_name
        local planet = self.planets[productionPlanet]
        self:Notify(planet, object_type_name)
        GlobalValue.Set("PRODUCTION_FINISHED", "")
    end
end

---@class ProductionCanceledEvent : Observable
ProductionCanceledEvent = class(Observable)

function ProductionCanceledEvent:new(planets)
    ---@private
    ---@type Planet[]
    self.planets = planets
end

function ProductionCanceledEvent:Check()
    if StoryUtil.ValidGlobalValue(GlobalValue.Get("PRODUCTION_CANCELED")) then
        local event_info = Deserialize(GlobalValue.Get("PRODUCTION_CANCELED"))
        local productionPlanet = event_info.planet_name
        local object_type_name = event_info.object_type_name
        local planet = self.planets[productionPlanet]
        self:Notify(planet, object_type_name)
        GlobalValue.Set("PRODUCTION_CANCELED", "")
    end
end

---@class TacticalBattleStartingEvent : Observable
TacticalBattleStartingEvent = class(Observable)

function TacticalBattleStartingEvent:Check()
    if StoryUtil.ValidGlobalValue(GlobalValue.Get("TACTICAL_BATTLE_BEGINNING")) then
        self:Notify()
        GlobalValue.Set("TACTICAL_BATTLE_BEGINNING", "")
    end
end

---@class TacticalBattleEndingEvent : Observable
TacticalBattleEndingEvent = class(Observable)

function TacticalBattleEndingEvent:Check()
    if StoryUtil.ValidGlobalValue(GlobalValue.Get("TACTICAL_BATTLE_ENDING")) then
        self:Notify()
        GlobalValue.Set("TACTICAL_BATTLE_ENDING", "")
    end
end

---@class SelectedPlanetChangedEvent : Observable
SelectedPlanetChangedEvent = class(Observable)

function SelectedPlanetChangedEvent:new(player, planets)
    self.player = player
    self.planets = planets
end

function SelectedPlanetChangedEvent:Check()
    for _, planet in pairs(self.planets) do
        if Check_Story_Flag(self.player, "ZOOMED_INTO_" .. planet:get_name(), nil, true) then
            GlobalValue.Set("SELECTED_PLANET", planet:get_name())
            self:Notify(planet)
            break
        end
    end
end

---@class GalacticWeekChangedEvent : Observable
GalacticWeekChangedEvent = class(Observable)

function GalacticWeekChangedEvent:new(player)
    self.player = player
end

function GalacticWeekChangedEvent:Check()
    if Check_Story_Flag(self.player, "GALACTIC_CYCLE_ELAPSED", nil, true) then
        self:Notify()
    end
end

---@class GalacticHeroKilledEvent : Observable
GalacticHeroKilledEvent = class(Observable)

function GalacticHeroKilledEvent:Check()
    local hero_name = GlobalValue.Get("GALACTIC_HERO_KILLED")
    if StoryUtil.ValidGlobalValue(hero_name) then
        self:Notify(hero_name)
        GlobalValue.Set("GALACTIC_HERO_KILLED", "")
    end
end

IncomingFleetEvent = class(Observable)

function IncomingFleetEvent:new(planets)
    self.Planets = planets
end

function IncomingFleetEvent:Check()
    local planet_name = GlobalValue.Get("CONQUER_OPPONENT")
    if StoryUtil.ValidGlobalValue(planet_name) then
        local planet = self.Planets[planet_name]
        self:Notify(planet)
        GlobalValue.Set("CONQUER_OPPONENT", "")
    end
end
