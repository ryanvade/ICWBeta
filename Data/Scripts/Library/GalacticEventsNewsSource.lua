require("Class")
require("Observable")
CONSTANTS = require("GameConstants")

---@class GalacticEventsNewsSource : Observable
GalacticEventsNewsSource = class(Observable)

---@param planet_owner_changed_event PlanetOwnerChangedEvent
function GalacticEventsNewsSource:new(planet_owner_changed_event, galactic_hero_killed_event)
    planet_owner_changed_event:AttachListener(self.on_planet_owner_changed, self)
    galactic_hero_killed_event:AttachListener(self.on_galactic_hero_killed, self)
end

---@param planet Planet
function GalacticEventsNewsSource:on_planet_owner_changed(planet)
    local owner_name = planet:get_owner().Get_Faction_Name()
    local conquest_text = CONSTANTS.ALL_FACTION_PLANET_CONQUEST_TEXTS[owner_name]
    self:Notify {
        headline = conquest_text,
        var = planet:get_game_object(),
        color = {r = 255, g = 0, b = 0}
    }
end

function GalacticEventsNewsSource:on_galactic_hero_killed(hero_name)
    self:Notify {
        headline = "TEXT_HERO_KILLED_GALACTIC",
        var = Find_Object_Type(hero_name),
        color = {r = 255, g = 0, b = 0}
    }
end
