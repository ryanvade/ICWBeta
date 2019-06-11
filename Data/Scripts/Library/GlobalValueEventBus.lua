require("Class")
require("Observable")
require("TableSerializer")

GlobalValueObservable = Class {
    Extends = Observable,
    Constructor = function(self, globalValue, deserializedKey)
        self.globalValue = globalValue
        self.deserializedKey = deserializedKey
    end,

    Update = function(self)
        local publishString = GlobalValue.Get(self.globalValue)
        if publishString and publishString ~= "" then
            local publishData = Deserialize(publishString)
            self:Notify(publishData[self.deserializedKey])
        end
        GlobalValue.Set(self.globalValue, "")
    end
}

GlobalValueEventBus = Class {
    Constructor = function(self)
        local currentId = GlobalValue.Get("GlobalValueEventBus.id")
        if not currentId or currentId == "" then
            currentId = -1
        end
        currentId = currentId + 1
        GlobalValue.Set("GlobalValueEventBus.id", currentId)
        self.globalValues = {}
        self.id = currentId
        self.registerKey = "GlobalValueEventBus.register.target="..self.id
        self.publishKey = "GlobalValueEventBus.publish.target="..self.id
        self.registerObservable = self:makeRegisterObservable(self.registerKey)
        self.registerObservable:AttachListener(self.registerNewKey, self)
    end,

    register = function(self, globalValue)
        local registerData = Serialize({
                source = self.id,
                globalValue = globalValue
        })

        local currentId = GlobalValue.Get("GlobalValueEventBus.id")
        for id=0, currentId do
            GlobalValue.Set("GlobalValueEventBus.register.target="..id, registerData)
        end
    end,

    subscribe = function(self, listener, globalValue, tab)
        self:registerNewKey(globalValue)
        self.globalValues[globalValue]:AttachListener(listener, tab)
    end,

    publish = function(self, globalValue, message)
        local publishData = Serialize({
            globalValue = globalValue,
            message = message
        })

        local currentId = GlobalValue.Get("GlobalValueEventBus.id")
        for id=0, currentId do
            GlobalValue.Set("GlobalValueEventBus.publish.target="..id..".globalValue="..globalValue, publishData)
        end
    end,

    update = function(self)
        self.registerObservable:Update()

        for _, observable in pairs(self.globalValues) do
            observable:Update()
        end
    end,

    makePublishObservable = function(self, globalValue)
        return GlobalValueObservable:New("GlobalValueEventBus.publish.target="..self.id..".globalValue="..globalValue, "message")
    end,

    makeRegisterObservable = function(self)
        return GlobalValueObservable:New(self.registerKey, "globalValue")
    end,

    registerNewKey = function(self, key)
        if not self.globalValues[key] then
            self.globalValues[key] = self:makePublishObservable(key)
        end
    end
}

return GlobalValueEventBus