require("PGCommands")
require("Class")

TimedQueue = Class {
    Constructor = function(self)
        self.head = nil
    end,

    Add = function(self, func, time, arg)
        if not self.head then
            self.head = self:MakeQueueEntry(func, time, arg)
            Register_Timer(self.FunctionWrapper, self.head.time, self.head)
            return
        end

        local current = self.head
        while current.next do
            current = current.next
        end
        current.next = self:MakeQueueEntry(func, time, arg)
    end,

    MakeQueueEntry = function(self, func, time, arg)
        return {
            self = self,
            func = func,
            time = time,
            arg = arg,
            next = nil
        }
    end,

    Clear = function(self)
        self.head = nil
        Cancel_Timer(self.FunctionWrapper)
    end,

    FunctionWrapper = function(wrapper)
        local self = wrapper.self
        wrapper.func(wrapper.arg)

        self.head = wrapper.next
        if not self.head then
            return
        end
        Register_Timer(self.FunctionWrapper, self.head.time, self.head)
    end
}

return TimedQueue