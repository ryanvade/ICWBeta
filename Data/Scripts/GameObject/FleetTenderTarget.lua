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
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            FleetTenderTarget.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:34:57+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("TRCommands")

FleetTenderTarget = {}

FleetTenderTarget.isActive = true

function FleetTenderTarget:Init(globals)
    if Get_Game_Mode() ~= "Space" then
        self.isActive = false
        return
    end

    local fighterData = TypeLibrary.Units[Object.Get_Type().Get_Name()].Fighters
    local fighterLimits = {}
    for fighterType, data in pairs(fighterData) do
        fighterLimits[fighterType] = data.Reserve
    end

    TR_Register_Prox(Object, FleetTenderProxFunc, 2000, Object.Get_Owner(), fighterLimits)
end

function FleetTenderTarget:Update(globals)
end

function FleetTenderProxFunc(prox_obj, trigger_obj, fighterLimits)
    if not trigger_obj.Has_Property("FleetTender") then
        return
    end

    local resupplied = false
    local fighterData = TypeLibrary.Units[Object.Get_Type().Get_Name()].Fighters

    for fighterType, data in pairs(fighterData) do
        if data.Reserve < fighterLimits[fighterType] then
            data.Reserve = data.Reserve + 1
            resupplied = true
        end
    end

    if not resupplied then
        return
    end

    Register_Timer(Cooldown, 10, fighterLimits)
    TR_Cancel_Prox(obj, FleetTenderProxFunc)
end

function Cooldown()
    Cancel_Timer(Cooldown)
    TR_Register_Prox(Object, FleetTenderProxFunc, 2000, Object.Get_Owner(), fighterLimits)
end

return FleetTenderTarget
