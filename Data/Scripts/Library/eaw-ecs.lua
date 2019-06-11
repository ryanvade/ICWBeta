ecs = {}
ecs.__base_entity = {
    components = {};

    add_component = function(self, component)
        if not component.name then
            DebugMessage("Components need to be named")
        end
        self.components[component.name] = component
    end;

    remove_component = function(self, component_name)
        self.components[component_name] = nil
    end;

    get_component = function(self, component_name)
        return self.components[component_name]
    end;

    has_component = function(self, component_name)
        return self.components[component_name] ~= nil
    end;

    init = function(self)
        for _, component in pairs(self.components) do
            component:init(self)
        end
    end;

    update = function(self)
        for _, component in pairs(self.components) do
            component:update()
        end
    end;

}

ecs.entity = function(tab)
    return setmetatable(tab, { __index = ecs.__base_entity })
end

ecs.system = function()
    return {
        running = false;
        thread = nil;
        entities = {};
        add_entity = function(self, entity)
            self.entities[entity] = true
        end;
        remove_entity = function(self, entity)
            self.entities[entity] = nil
        end;
        start = function(self)
            for entity, _ in pairs(self.entities) do
                entity:init()
            end
            self.running = true
        end;
        stop = function(self)
            self.running = false
        end;
        update = function(self)
            if not self.running then return end

            for entity, _ in pairs(self.entities) do
                entity:update()
            end
        end;
    }
end