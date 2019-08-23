
---@class GameObjectType Represents the type of a GameObject as specified in the XML code
local GameObjectType = {}

---@class FactionObject Represents a faction in the game
local FactionObject = {}


---@return string Returns the name of the GameObjectType in capital letters
function GameObjectType.Get_Name() end

---@class GameObject Represents an object in the game
local GameObject = {}

---@return GameObjectType Returns the GameObjectType of a GameObject
function GameObject.Get_Type() end

---@return FactionObject Returns FactionObject object that owns the GameObject
function GameObject.Get_Owner() end

---Transfers ownership of a GameObject over to another Player
---@param new_owner FactionObject @The FactionObject the ownership will be transfered to
function GameObject.Change_Owner(new_owner) end

---Despawns the GameObject
function GameObject.Despawn() end

---Enables or disables a behavior defined in the XML entry of the GameObject
---@param behavior_id int The ID of the behavior
---@param enable boolean Enables the behavior if set to true. Disables it if it's false.
function GameObject.Enable_Behavior(behavior_id, enable) end

---@return GameObject Returns the parent object of the given GameObject. In galactic conquest this will return either a planet, a company or a container. In tactical mode it returns the squadron for single fighters.
function GameObject.Get_Parent_Object() end

---@return PlanetObject Returns the Planet the GameObject is located on. Can be nil if the GameObject is in Hyperspace
function GameObject.Get_Planet_Location() end

---@return Position Returns the position of the GameObject
function GameObject.Get_Position() end

---Makes the GameObject visible or invisible
---@param hidden boolean Determines whether the GameObject is visible or invisible
function GameObject.Hide(hidden) end

---Plays an animation on a GameObject
---@param animation_name string The name of the animation
---@param should_repeat boolean Determines whether the animation gets repeated
---@param num number
function GameObject.Play_Animation(animation_name, should_repeat, num) end

