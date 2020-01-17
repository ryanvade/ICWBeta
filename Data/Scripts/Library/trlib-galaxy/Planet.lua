require("trlib-std/class")

---@class Planet
---@field private gameObject GameObject
---@field private activeBonusTexts table<string, string>
---@field private ownerInfluence number
---@field private __current_influence_dummies GameObject[]
---@field private __step_calculated boolean
---@field private __orbital_structures_in_current_step table<string, number>
Planet = class()

---@param name string
---@param human_player FactionObject
function Planet:new(name, human_player)
    ---@private
    self.gameObject = FindPlanet(name)

    ---@private
    self.human_player = human_player

    self.weeksControlled = 0

    self.oldOwner = Find_Player("Neutral")

    ---@private
    self.activeBonusTexts = {}

    ---@private
    self.ForcedUpdate = 0

    ---@private
    self.electionCycles = 0

    ---@private
    self.ownerInfluence = 0

    self:update_influence_information()

    ---@private
    self.__current_influence_dummies = nil

    ---@private
    self.__step_calculated = false

    ---@private
    self.__orbital_structures_in_current_step = {}
end

function Planet:enable_ability(ability_name, bool)
    local reward_type = "NEW_POWER_FOR_ALL"
    if not bool then
        reward_type = "REMOVE_POWER_FROM_ALL"
    end
    local generic_event = StoryUtil.GetGenericEvent()
    generic_event.Set_Reward_Type(reward_type)
    generic_event.Set_Reward_Parameter(0, self.gameObject.Get_Type().Get_Name())
    generic_event.Set_Reward_Parameter(1, ability_name)
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()
end

function Planet:update_bonuses()
    local ground_info = self:get_ground_structure_information()
    local orbital_info = self:get_orbital_structure_information()
    self.__step_calculated = true

    for ground_structure_name, _ in pairs(ground_info) do
        local modifier = GameObjectLibrary.GroundStructures[ground_structure_name].Modifier
        if modifier then
            modifier(self)
        end
    end

    for orbital_structure_name, _ in pairs(orbital_info) do
        local modifier = GameObjectLibrary.OrbitalStructures[orbital_structure_name].Modifier
        if modifier then
            modifier(self)
        end
    end

    self.__step_calculated = false
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
    if self.__step_calculated then
        return self.__orbital_structures_in_current_step
    end

    local object_library = ModContentLoader.get("GameObjectLibrary")
    local structure_information = {}
    for structure_name, structure_info in pairs(object_library.OrbitalStructures) do
        structure_information[structure_info.Text] = self:__count_structure_occurences(structure_name, structure_info)
    end

    self.__orbital_structures_in_current_step = structure_information

    return structure_information
end

---Returns the number of structures on the planet with the given structure name. Tries to evaluate an AI Equation to determine the amount. Counts manually otherwise
---@private
---@param structure_name string The name of the structure
---@param structure_info table<string, any> The structure information from GameObjectLibrary
function Planet:__count_structure_occurences(structure_name, structure_info)
    if structure_info.Equation then
        return EvaluatePerception(structure_info.Equation, self.human_player, self.gameObject)
    end

    return self:__count_structures_manually(structure_name)
end

function Planet:forced_update()
    self.ForcedUpdate = 1
    self:update_influence_information()
end

function Planet:update_influence_information()
    -- Right now influence is all determined again from scratch each time the function is called. Not ideal.

    local oldInfluence = self.ownerInfluence



    if self:get_owner() ~= Find_Player("Neutral") then
        self.ownerInfluence = 3

        self.newOwner = self:get_owner()

        if self.newOwner == self.oldOwner then
            self.weeksControlled =  self.weeksControlled + 1
        else
            self.weeksControlled = 0
        end

        if self.weeksControlled >= 25 then 
            self.ownerInfluence = self.ownerInfluence + 1
        end
        if self.weeksControlled >= 15 then 
            self.ownerInfluence = self.ownerInfluence + 1
        end
        if self.weeksControlled >= 5 then 
            self.ownerInfluence = self.ownerInfluence + 1
        end

        if EvaluatePerception("Planet_Has_Capital_Building", self:get_owner(), self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 3
        end

        self.ownerInfluence = self.ownerInfluence + EvaluatePerception("Planet_Has_Company", self.human_player, self.gameObject)

        if EvaluatePerception("Recent_Conflict_Space", self.human_player, self.gameObject) ~= 0 then
            self.ownerInfluence = self.ownerInfluence - 1
        end

        if EvaluatePerception("Recent_Conflict_Ground", self.human_player, self.gameObject) ~= 0 then
            self.ownerInfluence = self.ownerInfluence - 2
        end

        if EvaluatePerception("Planet_Has_Local_Government_Building", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 1
        end

        if EvaluatePerception("Planet_Has_Trade_Station", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end

        if EvaluatePerception("Planet_Has_Oto", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end

        if EvaluatePerception("Planet_Has_Empress", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end

        if EvaluatePerception("Planet_Has_Validusia", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end

        if EvaluatePerception("Planet_Has_Black_Fifteen", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end
        
        if EvaluatePerception("Planet_Has_Slayn_Korpil", self.human_player, self.gameObject) == 1 then
            self.ownerInfluence = self.ownerInfluence + 2
        end

        if self:get_owner() == Find_Player("Rebel") then
            if GlobalValue.Get("ChiefOfState") == "DUMMY_CHIEFOFSTATE_LEIA" then
                self.ownerInfluence = self.ownerInfluence + 1
            elseif GlobalValue.Get("ChiefOfState") == "DUMMY_CHIEFOFSTATE_MOTHMA" then
                if self:get_name() == "CHANDRILA" then
                    self.ownerInfluence = self.ownerInfluence + 10
                end
            elseif GlobalValue.Get("ChiefOfState") == "DUMMY_CHIEFOFSTATE_FEYLYA" then
                if self:get_name() == "BOTHAWUI" then
                    self.ownerInfluence = self.ownerInfluence + 10
                end
            elseif GlobalValue.Get("ChiefOfState") == "DUMMY_CHIEFOFSTATE_GAVRISOM" then
                if self:get_name() == "HAPES" then
                    self.ownerInfluence = self.ownerInfluence + 5
                end
            end
        end

        if self:get_owner() ~= Find_Player("Rebel") then
            if self:get_name() == "KASHYYYK" then
                self.ownerInfluence = self.ownerInfluence - 2
            end
        end

        if self.ownerInfluence > 10 then
            self.ownerInfluence = 10
        end

        if self.ownerInfluence <= 0 then
            self.ownerInfluence = 1
        end

        self.oldOwner = self:get_owner()

        if self:get_owner() ~= Find_Player("Neutral") then
            self.gameObject.Attach_Particle_Effect("Display_Influence_" .. tostring(self.ownerInfluence))
        end

        if self:get_owner() == Find_Player("Empire") then
            self.gameObject.Attach_Particle_Effect("Republic_Allies")
        elseif self:get_owner() == Find_Player("Corporate_Sector") then
            self.gameObject.Attach_Particle_Effect("Republic_Allies")
        end

        self:apply_loyalty_modifiers()
    end
end

function Planet:apply_loyalty_modifiers()
    -- Right now influence is all determined again from scratch each time the function is called. Not ideal.
    self:remove_influence_dummies()

    local influence_structure_table = {
        {"INFLUENCE_ONE", "Bonus_PlaceHolder"},
        {"INFLUENCE_TWO", "Bonus_PlaceHolder"},
        {"INFLUENCE_THREE", "Bonus_PlaceHolder"},
        {"INFLUENCE_FOUR", "Bonus_PlaceHolder"},
        {"INFLUENCE_FIVE", "Bonus_PlaceHolder"},
        {"INFLUENCE_SIX", "Bonus_PlaceHolder"},
        {"INFLUENCE_SEVEN", "Bonus_PlaceHolder"},
        {"INFLUENCE_EIGHT", "Bonus_PlaceHolder"},
        {"INFLUENCE_NINE", "Bonus_PlaceHolder"},
        {"INFLUENCE_TEN", "Bonus_PlaceHolder"}
    }

    local dummylist = influence_structure_table[self.ownerInfluence]

    table.insert(dummylist, GlobalValue.Get("ChiefOfState"))

    self.__current_influence_dummies = SpawnList(dummylist, self.gameObject, self:get_owner(), false, false)
end

---Despawns all influence dummies currently applied to the planet
---@private
---@return void
function Planet:remove_influence_dummies()
    if not self.__current_influence_dummies then
        return
    end

    for _, influence_dummy in pairs(self.__current_influence_dummies) do
        if TestValid(influence_dummy) then
            influence_dummy.Despawn()
        end
    end
end

---Returns the influence value of the planet
function Planet:get_influence_information()
    return self.ownerInfluence
end

---Returns the number of structures with the given name on the Planet. Serves as fallback if no AI Equation is available.
---@private
---@param structure_name string The name of the structure
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
