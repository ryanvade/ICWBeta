require("trlib-std/class")
require("trlib-std/Queue")
require("trlib-util/StoryUtil")

---@class AbilityBasedResourceManager
AbilityBasedResourceManager = class()


function AbilityBasedResourceManager:new(planets, gc)
    ---@type table<Planet, table<string, any>>
    self.planets = {}

    self.crew_resource_dummy_name = "Crew_Resource_Dummy"
    self.crew_resource_dummy_type = Find_Object_Type("Crew_Resource_Dummy")

    ---@type GalacticConquest
    self.galactic_conquest = gc

    ---@type string
    self.active_tier_ability_name = nil

    self.ship_crews = 0

    self.ship_crew_tiers = {
        Ship_Crew_Tier_12 = 300,
        Ship_Crew_Tier_11 = 150,
        Ship_Crew_Tier_10 = 50,
        Ship_Crew_Tier_9 = 40,
        Ship_Crew_Tier_8 = 35,
        Ship_Crew_Tier_7 = 30,
        Ship_Crew_Tier_6 = 25,
        Ship_Crew_Tier_5 = 20,
        Ship_Crew_Tier_4 = 15,
        Ship_Crew_Tier_3 = 10,
        Ship_Crew_Tier_2 = 5,
        Ship_Crew_Tier_1 = 1
    }

    self:place_initial_placeholders(planets)

    self.galactic_conquest.Events.GalacticProductionStarted:AttachListener(self.on_production_queued, self)
    self.galactic_conquest.Events.GalacticProductionFinished:AttachListener(self.on_production_finished, self)
    self.galactic_conquest.Events.GalacticProductionCanceled:AttachListener(self.on_production_canceled, self)
end

---@param planets table<string, Planet>
function AbilityBasedResourceManager:place_initial_placeholders(planets)
    ---@param planet Planet
    for _, planet in pairs(planets) do
        self.planets[planet] = {
            production_queue = Queue(),
            dummy_object = Spawn_Unit(
                Find_Object_Type("Placeholder_Category_Dummy"),
                planet:get_game_object(),
                planet:get_owner()
            )[1]
        }
        DebugMessage("Placeholder spawn sequence cycled")
    end
end

---@param planet Planet
function AbilityBasedResourceManager:on_selected_planet_changed(planet)
    if not planet:get_owner().Is_Human() then
        return
    end
end

---@param planet Planet
---@param game_object_type_name string
function AbilityBasedResourceManager:on_production_queued(planet, game_object_type_name)
    DebugMessage("In ResourceManager:on_production_queued")
    if not planet:get_owner().Is_Human() then
        return
    end

    local planet_entry = self.planets[planet]

    ---@type Queue
    local queue = planet_entry.production_queue
    queue:add(game_object_type_name)

    if queue.size > 1 then
        DebugMessage("Queue size larger than 1. Returning. Size: %s", tostring(queue.size))
       return
    end

    self:on_production_started(planet, game_object_type_name)
end

function AbilityBasedResourceManager:on_production_started(planet, game_object_type_name)
    DebugMessage("In ResourceManager:on_production_started. Planet: %s, Object Type: %s", tostring(planet:get_game_object().Get_Type().Get_Name()), tostring(game_object_type_name))
    local planet_entry = self.planets[planet]

    ---@type Queue
    local queue = planet_entry.production_queue

    if not GameObjectLibrary.Units[game_object_type_name] then
        DebugMessage("Did not find GameObjectLibrary entry for %s. Returning.", tostring(game_object_type_name))
        return
    end

    local resource = GameObjectLibrary.Units[game_object_type_name].Ship_Crew_Requirement

    if not resource then
        DebugMessage("Did not find GameObjectLibrary Ship Crew Requirement for %s. Returning.", tostring(game_object_type_name))
        return
    end

    self.ship_crews = self.ship_crews - resource

    local dummy_object = planet_entry.dummy_object
    if TestValid(dummy_object) then
        dummy_object.Despawn()
    end

    self:swap_to_new_ability()

    planet_entry.dummy_object =
        Spawn_Unit(self.crew_resource_dummy_type, planet:get_game_object(), planet:get_owner())[1]
end

---@param planet Planet
function AbilityBasedResourceManager:on_production_finished(planet, game_object_type_name)
    if not planet:get_owner().Is_Human() then
        return
    end

    local planet_entry = self.planets[planet]

    ---@type Queue
    local queue = planet_entry.production_queue
    local finished_game_object_type_name = queue:remove()
    local next_game_object_type_name = queue:peek()

    self:on_production_started(planet, next_game_object_type_name)
end

---@param planet Planet
function AbilityBasedResourceManager:on_production_canceled(planet, game_object_type_name)
    if not planet:get_owner().Is_Human() then
        return
    end

    if not GameObjectLibrary.Units[game_object_type_name] then
        return
    end

    local resource = GameObjectLibrary.Units[game_object_type_name].Ship_Crew_Requirement

    if resource then
        self.ship_crews = self.ship_crews + resource
    end

    self:on_production_finished(planet, game_object_type_name)
end

function AbilityBasedResourceManager:swap_to_new_ability()
    local ability_name = self:get_ship_crew_tier_ability_name()

    if ability_name == self.active_tier_ability_name then
        return
    end

    local event = StoryUtil.GetGenericEvent()
    if self.active_tier_ability_name then
        event.Set_Reward_Type("REMOVE_POWER_FOR_ALL")
        event.Set_Reward_Parameter(0, self.crew_resource_dummy_name)
        event.Set_Reward_Parameter(1, ability_name)
        StoryUtil.TriggerGenericEvent()
        StoryUtil.ResetGenericEvent()
    end

    event.Set_Reward_Type("NEW_POWER_FOR_ALL")
    event.Set_Reward_Parameter(0, self.crew_resource_dummy_name)
    event.Set_Reward_Parameter(1, ability_name)
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()

    self.active_tier_ability_name = ability_name
end

function AbilityBasedResourceManager:get_ship_crew_tier_ability_name()
    local final_ability_name
    for ability_name, tier_limit in pairs(self.ship_crew_tiers) do
        if self.ship_crews < tier_limit then
            final_ability_name = ability_name
        end
    end

    return final_ability_name
end
