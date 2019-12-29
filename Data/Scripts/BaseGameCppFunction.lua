--######################################################################################
--############################## Finder Functions ######################################
--######################################################################################

---Returns the first GameObject of the given type name
---@param type_name string A type name as specified in the XML code
---@return GameObject
function Find_First_Object(type_name) end

---Returns a table of all GameObjects matching the given input
---@param type_or_category string A type or category name as specified in the XML code
---@return GameObject[]
function Find_All_Objects_Of_Type(type_or_category) end

---Returns the GameObject nearest to the source object matching the given input
---@param source_object GameObject The GameObject to which the nearest object shall be found
---@param category string Limits the result to the given category
---@param faction FactionObject
---@param allied boolean Limits the result to allied or enemy units
---@overload fun(source_object: GameObject, faction: FactionObject, allied: boolean)
---@return GameObject
function Find_Nearest(source_object, category, faction, allied) end

---Returns the PlanetObject matching the given planet name
---@param planet_name string The name of the planet
---@return PlanetObject
function FindPlanet(planet_name) end

---Returns the FactionObject matching the given faction name
---@param faction_name string The name of the faction
---@return FactionObject
function Find_Player(faction_name) end

---Returns the GameObjectType matching the given type name
---@param type_name string The type name
---@return GameObjectType
function Find_Object_Type(type_name) end

---Returns the GameObject with the given hint
---@param hint string The hint
---@return GameObject
function Find_Hint(hint) end


--######################################################################################
--############################### Spawn Functions ######################################
--######################################################################################

---Spawns a unit and returns it inside a table with a length of 1
---@param unit_type GameObjectType The type of the unit
---@param location PlanetObject|GameObject|Position The location the unit is supposed to spawn at
---@param owner FactionObject The owner of the unit
---@return GameObject[]
function Spawn_Unit(unit_type, location, owner) end


---Spawns a unit with Hyperspace/landing Transport animation and returns it inside a table with a length of 1
---@param object_type GameObjectType The  GameObjectType of the unit to spawn
---@param location PlanetObject|GameObject|Position The location the unit is supposed to spawn at
---@param allow_ai_usage boolean Determines whether the AI is allowed to control the unit
---@param ignore_reinforcement_rules boolean Ignores reinforcement rules when set to true
---@return GameObject[]
function Reinforce_Unit(object_type, location, player, allow_ai_usage, ignore_reinforcement_rules) end