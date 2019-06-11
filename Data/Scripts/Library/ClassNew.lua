classes = {
    currentDef = nil,
    nextName = nil,
    tabLookUp = {}
}

function private(name)
    classes.nextName = name
    return function(tab)
        classes[classes.currentDef].privateDefs[classes.nextName] = tab[1]
        classes.nextName = nil
    end
end

function public(name)
    classes.nextName = name
    return function(tab)
        classes[classes.currentDef].publicDefs[classes.nextName] = tab[1]
        classes.nextName = nil
    end
end

function class(name)
    classes.currentDef = name
    classes[classes.currentDef] = {
        privateDefs = {},
        publicDefs = {},
        class = nil
    }

    return function(tab)
        classes[classes.currentDef].class = tab
        classes.tabLookUp[tab] = classes.currentDef

        function tab:new(...)

            local classdef = classes[classes.tabLookUp[self]]
            local privateObj = {}
            local publicObj = {}

            for funcName, func in pairs(classdef.privateDefs) do
                local clone_func = loadstring(string.dump(func))
                privateObj[funcName] = clone_func
            end

            for funcName, func in pairs(classdef.publicDefs) do
                local clone_func = loadstring(string.dump(func))
                privateObj[funcName] = clone_func
                publicObj[funcName] = clone_func
            end

            local env = {self = privateObj, print = print, unpack = unpack, pairs = pairs}
            for _, v in pairs(privateObj) do
                if type(v) == "function" then
                    setfenv(v, env)
                end
            end

            if publicObj.constructor then
                publicObj.constructor(unpack(arg))
                publicObj.constructor = nil
            end

            return publicObj
        end
        classes.currentDef = nil
    end
end

function getClass(name)
    return classes[name].class
end