require("trlib-std/class")
require("trlib-util/StoryUtil")

ShipCrewDisplayComponent = class()

---@param resource_manager DummyBasedResourceManager
function ShipCrewDisplayComponent:new(resource_manager)
    self.ship_crews = resource_manager.ship_crews
    self.current_text_id = ""
    self.__needs_update = true
    resource_manager.resources_changed_event:AttachListener(self.on_ship_crews_changed, self)
end


function ShipCrewDisplayComponent:needs_update()
    return self.__needs_update
end

function ShipCrewDisplayComponent:render()
    self.__needs_update = false
    -- StoryUtil.RemoveScreenText(self.current_text_id)
    self.current_text_id = "TEXT_RESOURCE_"..tostring(self.ship_crews)
    self:add_objective(self.current_text_id)
    -- StoryUtil.ShowScreenText(self.current_text_id, -1)
end

function ShipCrewDisplayComponent:on_ship_crews_changed(ship_crews)
    self.ship_crews = ship_crews
    self.__needs_update = true
end

function ShipCrewDisplayComponent:add_objective(text_id)
    local event = StoryUtil.GetGenericEvent()
    event.Set_Reward_Type("ADD_OBJECTIVE")
    event.Set_Reward_Parameter(0, text_id)
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()
end