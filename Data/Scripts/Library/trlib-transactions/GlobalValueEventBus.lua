require("trlib-std/class")
require("trlib-transactions/TableSerializer")
require("trlib-galaxy/GlobalValueQueue")

---@class GlobalValueEventBus
GlobalValueEventBus = class()

---@param name string
function GlobalValueEventBus:new(name)
    self.name = (name or tostring(Script))
    self.message_queue = GlobalValueQueue()
    self.subscribers = {}
end

---@param event_name string
function GlobalValueEventBus:subscribe(event_name, listener_function, optional_self)
    local subscription =
        Serialize {
        name = self.name,
        event = event_name
    }

    if not self.subscribers[event_name] then
        self.subscribers[event_name] = {}
    end

    table.insert(
        self.subscribers[event_name],
        {
            func = listener_function,
            optional_self = optional_self
        }
    )

    self.message_queue:queue_value("busid:master:subscribe", subscription)
    DebugMessage("Registered listener for %s", event_name)
end

---@param event_name string
function GlobalValueEventBus:post(event_name, ...)
    self.message_queue:queue_value(
        "busid:master:post",
        Serialize {
            event_name = event_name,
            args = arg
        }
    )
end

---@private
function GlobalValueEventBus:process_notifications()
    local notification = GlobalValue.Get("busid:" .. self.name .. ":notify")

    if not notification or notification == "" then
        return
    end

    notification = Deserialize(notification)

    local event_name = notification.event_name
    local args = notification.args

    if not self.subscribers[event_name] then
        return
    end

    for _, subscriber in pairs(self.subscribers[event_name]) do
        if subscriber.optional_self then
            subscriber.func(subscriber.optional_self, unpack(args))
        else
            subscriber.func(unpack(args))
        end
    end

    GlobalValue.Set("busid:" .. self.name .. ":notify", "")
end

function GlobalValueEventBus:update()
    self:process_notifications()
    self.message_queue:process_global_values()
end

---@class MasterGlobalValueEventBus
MasterGlobalValueEventBus = class()

function MasterGlobalValueEventBus:new()
    self.name = "busid:master"

    ---@type table<string, string[]>
    self.subscribers = {}
    self.message_queue = GlobalValueQueue()
end

---@private
function MasterGlobalValueEventBus:process_subscriptions()
    local subscriber = GlobalValue.Get("busid:master:subscribe")

    if not subscriber or subscriber == "" then
        return
    end

    DebugMessage("Registering subscriber in MasterGlobalValueEventBus")

    subscriber = Deserialize(subscriber)

    if type(subscriber) ~= "table" then
        return
    end

    if not (subscriber.name and subscriber.event) then
        return
    end

    if not (type(subscriber.name) == "string" and type(subscriber.event) == "string") then
        return
    end

    if not self.subscribers[subscriber.event] then
        self.subscribers[subscriber.event] = {}
    end

    table.insert(self.subscribers[subscriber.event], subscriber.name)
    GlobalValue.Set("busid:master:subscribe", "")
end

---@private
function MasterGlobalValueEventBus:process_posts()
    local post = GlobalValue.Get("busid:master:post")

    if not post or post == "" then
        return
    end

    post = Deserialize(post)

    self:post(post.event_name, unpack(post.args))
    GlobalValue.Set("busid:master:post", "")
end

---@param event_name string
function MasterGlobalValueEventBus:post(event_name, ...)
    local subscribers = self.subscribers[event_name]

    if not subscribers then
        return
    end

    for _, subscriber_name in pairs(subscribers) do
        self.message_queue:queue_value(
            "busid:" .. subscriber_name .. ":notify",
            Serialize {
                event_name = event_name,
                args = arg
            }
        )
    end
end

function MasterGlobalValueEventBus:update()
    self:process_subscriptions()
    self:process_posts()
    self.message_queue:process_global_values()
end
