require("trlib-std/class")
require("trlib-util/StoryUtil")

---@class ObjectivesDisplayComponentContainer : DisplayComponentContainer
ObjectivesDisplayComponentContainer = class()

---@param battle_start_event TacticalBattleStartingEvent
---@param battle_end_event TacticalBattleEndingEvent
function ObjectivesDisplayComponentContainer:new(battle_start_event, battle_end_event)
    ---@private
    self.components = {}

    battle_start_event:AttachListener(self.on_tactical_battle_start, self)
    battle_end_event:AttachListener(self.on_tactical_battle_end, self)
end

function ObjectivesDisplayComponentContainer:add_display_component(component)
    table.insert(self.components, component)
end

function ObjectivesDisplayComponentContainer:update_components(force_update)
    if force_update then
        self:render_components()
        return
    end

    local needs_update = false
    for _, component in pairs(self.components) do
        if component:needs_update() then
            needs_update = true
            break
        end
    end

    if not needs_update then
        return
    end

    self:render_components()
end

---@private
function ObjectivesDisplayComponentContainer:render_components()
    self:enable_objective_display(false)
    self:enable_objective_display(true)
    for _, component in pairs(self.components) do
        component:render()
    end
end

---@private
function ObjectivesDisplayComponentContainer:on_tactical_battle_start()
    self:enable_objective_display(false)
end

---@private
function ObjectivesDisplayComponentContainer:on_tactical_battle_end()
    self:enable_objective_display(true)
    self:render_components()
end

---@private
function ObjectivesDisplayComponentContainer:enable_objective_display(bool)
    local value = tostring(1)
    if not bool then
        value = tostring(0)
        self:remove_all_objectives()
    end

    local event = StoryUtil.GetGenericEvent()
    event.Set_Reward_Type("ENABLE_OBJECTIVE_DISPLAY")
    event.Set_Reward_Parameter(0, value)
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()
end

---@private
function ObjectivesDisplayComponentContainer:remove_all_objectives()
    local event = StoryUtil.GetGenericEvent()
    event.Set_Reward_Type("REMOVE_ALL_OBJECTIVES")
    StoryUtil.TriggerGenericEvent()
    StoryUtil.ResetGenericEvent()
end
