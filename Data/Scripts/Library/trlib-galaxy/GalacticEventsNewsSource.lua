require("trlib-std/class")
require("trlib-std/Observable")

CONSTANTS = ModContentLoader.get("GameConstants")

---@class GalacticEventsNewsSource : Observable
GalacticEventsNewsSource = class(Observable)

---@param planet_owner_changed_event PlanetOwnerChangedEvent
function GalacticEventsNewsSource:new(planet_owner_changed_event, galactic_hero_killed_event, incoming_fleet_event)
    planet_owner_changed_event:AttachListener(self.on_planet_owner_changed, self)
    galactic_hero_killed_event:AttachListener(self.on_galactic_hero_killed, self)
    incoming_fleet_event:AttachListener(self.on_incoming_fleet, self)
end

---@param planet Planet
function GalacticEventsNewsSource:on_planet_owner_changed(planet)
    local owner_name = planet:get_owner().Get_Faction_Name()
    local conquest_text = CONSTANTS.ALL_FACTION_PLANET_CONQUEST_TEXTS[owner_name]
    local color = CONSTANTS.FACTION_COLORS[owner_name]
    self:Notify {
        headline = conquest_text,
        var = planet:get_game_object(),
        color = color
    }
end

---@param hero_name string
function GalacticEventsNewsSource:on_galactic_hero_killed(hero_name)
    self:Notify {
        headline = "TEXT_NEWS_HERO_KILLED_GALACTIC",
        var = Find_Object_Type(hero_name),
        color = {r = 255, g = 0, b = 0}
    }
end

function GalacticEventsNewsSource:on_incoming_fleet(planet)
    if not planet:get_owner().Is_Human() then
        return
    end

    self:Notify {
        headline = "TEXT_NEWS_ENEMY_FLEET_INCOMING",
        duration = 20,
        var = planet:get_game_object(),
        color = {r = 255, g = 0, b = 0}
    }
end
