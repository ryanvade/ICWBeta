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
--*   @Author:              [TR]Pox
--*   @Date:                2017-12-14T10:54:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GenericGameObject.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-13T13:09:14+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGCommands")
require("PGStateMachine")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))
    modules = {}

    globalValues = {
        Fighters = {}
    }

    Define_State("State_Init", State_Init);
end

function State_Init(message)
    if message == OnEnter then
        if Get_Game_Mode() == "Galactic" then
            ScriptExit()
        end


        TM = require("TRGameModeTransactions")
        TypeLibrary = require("GameObjectLibrary")

        local typeEntry = TypeLibrary.Units[Object.Get_Type().Get_Name()]
        if not typeEntry then
            ScriptExit()
        end

        local scripts = typeEntry.Scripts
        for i, script in pairs(scripts) do
            local mod = require(script)
            table.insert(modules, mod)
            mod:Init(globalValues)
        end

    elseif message == OnUpdate then
        for i, mod in pairs(modules) do
            if mod.isActive then
                mod:Update(globalValues)
            else
                table.remove(modules, i)
            end
        end
        if table.getn(modules) == 0 then
            ScriptExit()
        end
    end
end
