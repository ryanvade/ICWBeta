--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox <Pox>
--*   @Date:                2018-02-27T20:37:34+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Class.lua
--*   @Last modified by:    Pox
--*   @Last modified time:  2018-02-27T20:38:04+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

---@alias Class table<string, any>

---Creates a new class
---@param extends string @The name of the parent class
---@return Class
function class(extends)
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