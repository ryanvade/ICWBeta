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



function CloneTable(tab)
    local clone = {}
    for k, v in pairs(tab) do
        if type(v) == "table" and not v.IsClassInstance then
            clone[k] = CloneTable(v)
        else
            clone[k] = v
        end
    end

    return clone
end

function Class(tab)
    function tab:New(...)
        local obj = CloneTable(self)
        obj.IsClassInstance = true
        obj.New = nil

        if obj.Extends then
            setmetatable(obj, {__index = obj.Extends})
        end

        obj.Extends = nil

        if obj.Constructor then
            obj:Constructor(unpack(arg))
        end

        return obj
    end

    return tab
end
