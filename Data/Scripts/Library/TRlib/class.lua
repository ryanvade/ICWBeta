function TRlib.class(extends)
    local mt = {
        __call = function(class, ...)
            local obj = setmetatable({}, {__index = class})

            if class.__extends and class.__extends.new then
                class.__extends.new(obj, unpack(arg))
            end

            if class.new then
                obj:new(unpack(arg))
            end

            return obj
        end;
    }

    if extends then
        mt.__index = extends
    end

    return setmetatable({
        __extends = extends
    }, mt)
end

