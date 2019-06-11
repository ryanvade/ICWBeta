Planet = {}
setmetatable(Planet,  {
    __call = function(_, ...)
        return Planet.new(unpack(arg))
    end
})

function Planet.new(name)
    local self = setmetatable({}, {__index = Planet})
    self.gameObject = FindPlanet(name)
    self.activeBonusTexts = {}

    return self
end

function Planet:enable_ability(ability_name, bool)
    -- TODO: write code to enable ability
end

function Planet:update_bonuses()
    local ground_info = self:get_ground_structure_information()
    for ground_structure_name, _ in pairs(ground_info) do
        local modifier = GameObjectLibrary.GroundStructures[ground_structure_name].Modifier
        if modifier then
            modifier(self)
        end
    end

    local orbital_info = self:get_orbital_structure_information()
    for orbital_structure_name, _ in pairs(orbital_info) do
        local modifier = GameObjectLibrary.OrbitalStructures[orbital_structure_name].Modifier
        if modifier then
            modifier(self)
        end
    end
end

-- TODO: This should probably not be here
-- Should probably just be a table with bonus names with text entries stored in a config table somewhere
function Planet:set_bonus_text(bonus_name, text)
    self.activeBonusTexts[bonus_name] = text
end

function Planet:get_bonus_text_entries()
    return self.activeBonusTexts
end

function Planet:get_owner()
    return self.gameObject.Get_Owner()
end

function Planet:get_game_object()
    return self.gameObject
end

function Planet:get_name()
    return self.gameObject.Get_Type().Get_Name()
end

function Planet:get_starbase_level()
 -- TODO: write AI equation
end

function Planet:has_structure(structure_name)
    local all_structures = Find_All_Objects_Of_Type(structure_name)
    for _, structure in pairs(all_structures) do
        if structure.Get_Planet_Location() == self.gameObject then
            return true
        end
    end

    return false
end

function Planet:get_ground_structure_information()
    -- TODO: writea AI equations for ground structures + algorithm
end

function Planet:get_orbital_structure_information()
    local object_library = GameObjectLibrary
    local structure_information = {}
    for structure_name, structure_info in pairs(object_library.OrbitalStructures) do
        structure_information[structure_info.Text] = self:__count_structure_occurences(structure_name, structure_info)
    end

    return structure_information
end

function Planet:__count_structure_occurences(structure_name, structure_info)
    if structure_info.Equation then
        return EvaluatePerception(structure_info.Equation, self:get_owner(), self.gameObject)
    end

    return self:__count_structures_manually(structure_name)
end

function Planet:__count_structures_manually(structure_name)
    local all_structures = Find_All_Objects_Of_Type(structure_name)
    local structures_on_planet = 0
    for _, structure in pairs(all_structures) do
        if structure.Get_Planet_Location() == self.gameObject then
            structures_on_planet = structures_on_planet + 1
        end
    end

    return structures_on_planet
end

return Planet