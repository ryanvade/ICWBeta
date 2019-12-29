require("trlib-std/class")

---@class DisplayComponentContainer
DisplayComponentContainer = class()

function DisplayComponentContainer:new()
    ---@private
    self.__display_components = {}
end

function DisplayComponentContainer:add_display_component(component)
    table.insert(self.__display_components, component)
end

function DisplayComponentContainer:update_components()
    local begin_updating = false
    for i, component in ipairs(self.__display_components) do
        if begin_updating or component:needs_update() then
            begin_updating = true
            component:render()
        end
    end
end
