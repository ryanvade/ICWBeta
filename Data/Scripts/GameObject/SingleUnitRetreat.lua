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
--*   @Date:                2017-12-17T14:11:19+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            SingleUnitRetreat.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-04-12T00:05:00+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("TransactionFactory")

SingleUnitRetreat = {}

function SingleUnitRetreat:Init(globals)
    if Get_Game_Mode() ~= "Space" then
        self.isActive = false
        return
    end
    self.isActive = true
    self.restoreTable = {}
    jumpInProgress = false
    retreatTimerDone = false
end

function SingleUnitRetreat:Update(globals)
    self:PrepareJump(globals)
    if jumpInProgress then
        if self:CheckCancel(globals) then
            return
        end

        if self:RetreatAllowed(globals) then
            self:JumpToHyperSpace(globals)
            return
        end

        if globals.Fighters and self:HasHangar() then
            self:RecallFighters(globals)
        end
    end
end

function SingleUnitRetreat:PrepareJump(globals)
    if Object.Are_Engines_Online() then
        if Object.Is_Ability_Active("TURBO") and not jumpInProgress then
            Object.Stop()
            Register_Timer(self.RetreatTimer, 9, self.RetreatTimer)
            jumpInProgress = true
        end
    end
end

function SingleUnitRetreat:CheckCancel(globals)
    if not Object.Are_Engines_Online() or not Object.Is_Ability_Active("TURBO") or self:InterdictorActive() then
        self:MakeFightersSelectable(globals)
        self:RestoreFighters(globals)
        Object.Activate_Ability("TURBO", false)
        Cancel_Timer(self.RetreatTimer)
        jumpInProgress = false
        retreatTimerDone = false
        return true
    end
    return false
end

function SingleUnitRetreat:InterdictorActive()
    local interdictorTypes = TypeLibrary.Interdictors
    for i, typeString in pairs(interdictorTypes) do
        local interdictorTable = Find_All_Objects_Of_Type(typeString)
        if table.getn(interdictorTable) > 0 then
            for j, interdictor in pairs(interdictorTable) do
                if interdictor.Is_Ability_Active("INTERDICT") then
                    return true
                end
            end
        end
    end
    return false
end

function SingleUnitRetreat:RestoreFighters(globals)
    local fighterTable = TypeLibrary.Units[Object.Get_Type().Get_Name()].Fighters
    for squadronTable, amount in pairs(self.restoreTable) do
        local fighterEntry = fighterTable[squadronTable.TypeString][Object.Get_Owner().Get_Faction_Name()]
        fighterEntry.Reserve = fighterEntry.Reserve + amount
        table.insert(globals.Fighters, squadronTable)
        self.restoreTable[squadronTable] = nil
    end
end

function SingleUnitRetreat:MakeFightersSelectable(globals)
    for i, squadronTable in pairs(globals.Fighters) do
        if TestValid(squadronTable.Squadron) then
            squadronTable.Squadron.Set_Selectable(true)
        end
    end
end

function SingleUnitRetreat:RecallFighters(globals)
    for i, squadronTable in pairs(globals.Fighters) do
        if TestValid(squadronTable.Squadron) then
            self:DespawnFighters(globals, squadronTable, i)
        end
    end
end

function SingleUnitRetreat:DespawnFighters(globals, squadronTable, index)
    squadronTable.Squadron.Set_Selectable(false)
    squadronTable.Squadron.Move_To(Object)
    local distanceFactor = self:GetDistanceFactor()
    if squadronTable.Squadron.Get_Distance(Object) <= (400 * distanceFactor) then
        self:SaveFighters(globals, squadronTable)
        squadronTable.Squadron.Despawn()
        table.remove(globals.Fighters, index)
    end
end

function SingleUnitRetreat:GetDistanceFactor()
    local typeFlags = TypeLibrary.Units[Object.Get_Type().Get_Name()].Flags
    if not typeFlags then
        return 1.0
    end

    return (typeFlags.FighterDespawnFactor or 1.0)
end

function SingleUnitRetreat:SaveFighters(globals, squadronTable)
    if not self.restoreTable[squadronTable] then
        self.restoreTable[squadronTable] = 0
    end
    self.restoreTable[squadronTable] = self.restoreTable[squadronTable] + 1
end

function SingleUnitRetreat:RetreatAllowed(globals)
    local hasHangar = self:HasHangar()
    local fightersRecalled = table.getn(globals.Fighters) == 0
    return ((not hasHangar) or fightersRecalled) and retreatTimerDone
end

function SingleUnitRetreat:HasHangar()
    local hasHangarFlag = false
    local typeName = Object.Get_Type().Get_Name()
    if TypeLibrary.Units[typeName].Flags then
        hasHangarFlag = TypeLibrary.Units[typeName].Flags.HANGAR
    end
    return hasHangarFlag or EvaluatePerception("Has_Hangar", Object.Get_Owner(), Object) == 1
end

function SingleUnitRetreat:JumpToHyperSpace(globals)
    self:MakeFightersSelectable(globals)
    local transaction = CreateSpawnTransaction(Object.Get_Type().Get_Name(), Object.Get_Owner().Get_Faction_Name())
    TM:RegisterGameModeTransaction(transaction)
    Object.Hyperspace_Away()
    self.isActive = false
    jumpInProgress = false
    retreatTimerDone = false
end

function SingleUnitRetreat.RetreatTimer(timerFunc)
    retreatTimerDone = true
    Cancel_Timer(timerFunc)
end

return SingleUnitRetreat
