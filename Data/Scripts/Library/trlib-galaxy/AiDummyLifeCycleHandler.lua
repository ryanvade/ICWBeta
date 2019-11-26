require("trlib-std/class")
require("trlib-std/GalacticUtil")

---@class AiDummyLifeCycleHandler
AiDummyLifeCycleHandler = class()

---@param planets Planet[]
---@param planet_owner_changed_event PlanetOwnerChangedEvent
---@param interval number
function AiDummyLifeCycleHandler:new(planets, planet_owner_changed_event, interval)
    planet_owner_changed_event:AttachListener(self.__on_planet_owner_changed, self)

    ---@private
    self.interval = interval or 10

    ---@private
    self.__ai_planet_dummy_set = {}

    ---@private
    self.__ai_planet_dummy_objects = {}

    self.__all_planets = planets

    for _, planet in pairs(self.__all_planets) do
        self.__ai_planet_dummy_objects[planet] = {}
    end

    ---@private
    ---@type number
    self.__last_update = nil
end

---@param dummy_set table<string, number>
function AiDummyLifeCycleHandler:add_to_ai_dummy_set(dummy_set)
    for dummy_name, amount in pairs(dummy_set) do
        if not self.__ai_planet_dummy_set[dummy_name] then
            self.__ai_planet_dummy_set[dummy_name] = 0
        end

        self.__ai_planet_dummy_set[dummy_name] = self.__ai_planet_dummy_set[dummy_name] + amount
    end
end

function AiDummyLifeCycleHandler:update()
    if not self:__should_update() then
        return
    end

    local dummies_on_planet
    for _, planet in pairs(self.__all_planets) do
        dummies_on_planet = self.__ai_planet_dummy_objects[planet]
        DebugMessage("Planet: %s, Dummies: %s", tostring(planet:get_name()), tostring(dummies_on_planet))
        self:__remove_invalid_entries(dummies_on_planet)
        if not planet:get_owner().Is_Human() and table.getn(dummies_on_planet) == 0 then
            self:__spawn_dummies_on_planet(planet, self.__ai_planet_dummy_set)
        end
    end

    self.__last_update = GetCurrentTime()
end


---@private
---@param planet Planet
function AiDummyLifeCycleHandler:__on_planet_owner_changed(planet)
    if not planet then
        return
    end

    self:__clear_dummies(planet)
    if planet:get_owner().Is_Human() then
        return
    end

    self:__spawn_dummies_on_planet(planet, self.__ai_planet_dummy_set)
end

---@private
function AiDummyLifeCycleHandler:__should_update()
    return not self.__last_update or GetCurrentTime() - self.__last_update > self.interval
end

---@private
function AiDummyLifeCycleHandler:__clear_dummies(planet)
    for _, dummy in pairs(self.__ai_planet_dummy_objects[planet]) do
        if TestValid(dummy) then
            dummy.Despawn()
        end
    end

    self.__ai_planet_dummy_objects[planet] = {}
end

---@private
function AiDummyLifeCycleHandler:__remove_invalid_entries(tab)
    for i, object in pairs(tab) do
        if not TestValid(object) then
            table.remove(tab, i)
        end
    end
end

---@private
---@param planet Planet
function AiDummyLifeCycleHandler:__spawn_dummies_on_planet(planet, dummy_set)
    local units =
        GalacticUtil.spawn {
        location = planet:get_name(),
        objects = dummy_set,
        owner = planet:get_owner().Get_Faction_Name()
    }

    self.__ai_planet_dummy_objects[planet] = units
end

return AiDummyLifeCycleHandler
