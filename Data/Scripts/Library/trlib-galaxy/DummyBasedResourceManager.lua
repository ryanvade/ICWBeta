require("trlib-std/class")
require("trlib-std/Observable")
require("trlib-std/GalacticUtil")
require("trlib-util/StoryUtil")

---@class DummyBasedResourceManager
DummyBasedResourceManager = class()

function DummyBasedResourceManager:new(planets, gc)
    ---@type table<Planet, table<string, any>>
    self.planets = {}

    self.crew_resource_dummy_name = "Crew_Resource_Dummy"
    self.crew_resource_dummy_type = Find_Object_Type("Crew_Resource_Dummy")
    self.placeholder_dummy_type_name = "Placeholder_Category_Dummy"

    ---@type GalacticConquest
    self.galactic_conquest = gc

    ---@type string
    self.active_tier_ability_name = nil

    self.ship_crews = 50

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

    self.galactic_conquest.Events.SelectedPlanetChanged:AttachListener(self.on_selected_planet_changed, self)
    self.galactic_conquest.Events.GalacticProductionStarted:AttachListener(self.on_production_queued, self)
    self.galactic_conquest.Events.GalacticProductionCanceled:AttachListener(self.on_production_canceled, self)

    self.resources_changed_event = Observable()
end

---@private
---@param planets table<string, Planet>
function DummyBasedResourceManager:place_initial_placeholders(planets)
    ---@param planet Planet
    for _, planet in pairs(planets) do
        self.planets[planet] = {
            dummy_objects = {}
        }

        if not planet:get_owner().Is_Human() then
            self.planets[planet].dummy_objects =
                GalacticUtil.spawn {
                objects = self:get_ai_dummy_table(),
                owner = planet:get_owner(),
                location = planet:get_game_object()
            }
        end
        DebugMessage("Placeholder spawn sequence cycled")
    end
end

---@private
function DummyBasedResourceManager:get_ai_dummy_table()
    return {
        Ship_Crew_Tier_12 = 1,
        Ship_Crew_Tier_11 = 1,
        Ship_Crew_Tier_10 = 1,
        Ship_Crew_Tier_9 = 1,
        Ship_Crew_Tier_8 = 1,
        Ship_Crew_Tier_7 = 1,
        Ship_Crew_Tier_6 = 1,
        Ship_Crew_Tier_5 = 1,
        Ship_Crew_Tier_4 = 1,
        Ship_Crew_Tier_3 = 1,
        Ship_Crew_Tier_2 = 1,
        Ship_Crew_Tier_1 = 1
    }
end

---@param planet Planet
function DummyBasedResourceManager:on_selected_planet_changed(planet)
    if not planet:get_owner().Is_Human() then
        return
    end

    local planet_entry = self.planets[planet]

    for _, dummy in pairs(planet_entry.dummy_objects) do
        if TestValid(dummy) then
            dummy.Despawn()
        end
    end

    planet_entry.dummy_objects =
        GalacticUtil.spawn {
        objects = self:get_required_dummy_types(),
        owner = planet:get_owner(),
        location = planet:get_game_object()
    }
end

---@param planet Planet
---@param game_object_type_name string
function DummyBasedResourceManager:on_production_queued(planet, game_object_type_name)
    DebugMessage("In ResourceManager:on_production_queued")
    if not planet:get_owner().Is_Human() then
        return
    end

    local planet_entry = self.planets[planet]

    local removed_resources = self:remove_resources(game_object_type_name)

    if not removed_resources then
        return
    end

    for _, dummy in pairs(planet_entry.dummy_objects) do
        if TestValid(dummy) then
            dummy.Despawn()
        end
    end

    planet_entry.dummy_objects =
        GalacticUtil.spawn {
        objects = self:get_required_dummy_types(),
        owner = planet:get_owner(),
        location = planet:get_game_object()
    }

    self.resources_changed_event:Notify(self.ship_crews)
end

---@private
---@param game_object_type_name string
function DummyBasedResourceManager:remove_resources(game_object_type_name)
    if not GameObjectLibrary.Units[game_object_type_name] then
        DebugMessage("Did not find GameObjectLibrary entry for %s. Returning.", tostring(game_object_type_name))
        return false
    end

    local resource = GameObjectLibrary.Units[game_object_type_name].Ship_Crew_Requirement

    if not resource then
        DebugMessage(
            "Did not find GameObjectLibrary Ship Crew Requirement for %s. Returning.",
            tostring(game_object_type_name)
        )
        return false
    end

    self.ship_crews = self.ship_crews - resource

    return true
end

---@param planet Planet
function DummyBasedResourceManager:on_production_canceled(planet, game_object_type_name)
    DebugMessage("In ResourceManager:on_production_canceled")
    if not planet:get_owner().Is_Human() then
        return
    end

    if not GameObjectLibrary.Units[game_object_type_name] then
        DebugMessage("Did not find GameObjectLibrary entry for %s. Returning.", tostring(game_object_type_name))
        return
    end

    local resource = GameObjectLibrary.Units[game_object_type_name].Ship_Crew_Requirement

    if not resource then
        DebugMessage(
            "Did not find GameObjectLibrary Ship Crew Requirement for %s. Returning.",
            tostring(game_object_type_name)
        )
        return
    end

    self.ship_crews = self.ship_crews + resource

    local planet_entry = self.planets[planet]

    for _, dummy in pairs(planet_entry.dummy_objects) do
        if TestValid(dummy) then
            dummy.Despawn()
        end
    end

    planet_entry.dummy_objects =
        GalacticUtil.spawn {
        objects = self:get_required_dummy_types(),
        owner = planet:get_owner(),
        location = planet:get_game_object()
    }

    self.resources_changed_event:Notify(self.ship_crews)
end

function DummyBasedResourceManager:get_required_dummy_types()
    local required_dummies = {}

    for dummy_type_name, tier_limit in pairs(self.ship_crew_tiers) do
        if self.ship_crews >= tier_limit then
            required_dummies[dummy_type_name] = 1
        else
            if not required_dummies[self.placeholder_dummy_type_name] then
                required_dummies[self.placeholder_dummy_type_name] = 0
            end

            required_dummies[self.placeholder_dummy_type_name] = required_dummies[self.placeholder_dummy_type_name] + 1
        end
    end

    return required_dummies
end
