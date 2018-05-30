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
--*   @Filename:            FighterSpawn.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-20T01:01:39+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



FighterSpawn = {}

FighterSpawn.isActive = true

function FighterSpawn:Init( globals)
    if Get_Game_Mode() ~= "Space" then
        self.isActive = false
        return
    end
    self.isActive = true
    self.spawnedFighters = {}
    self.fighterData = TypeLibrary.Units[Object.Get_Type().Get_Name()].Fighters
    self.originalOwner = Object.Get_Owner()
    self:InsertFighters()
    globals.Fighters = self.spawnedFighters
end

function FighterSpawn:Update(globals)
    if not self:HasHangar() then
        self.isActive = false
        Cancel_Timer(self.Spawn)
        return
    end

    self:CheckFighters(globals)
end

function FighterSpawn:InsertFighters()
    for typeString, tab in pairs(self.fighterData) do
        local entry = self:GetFighterEntry(tab)
        if entry then
            local squadronType = Find_Object_Type(typeString)
            entry.Reserve = entry.Reserve + entry.Initial
            for i=1, entry.Initial do
                table.insert(self.spawnedFighters, { Squadron = nil, ObjectType = squadronType, TypeString = typeString })
            end
        end
    end
end

function FighterSpawn:GetFighterEntry(tab)
    local owner = self.originalOwner
    local ownerName = owner.Get_Faction_Name()

    if not tab[ownerName] and not tab["DEFAULT"] then
        return nil
    end

    local techLevel = owner.Get_Tech_Level()
    local techIsEqual
    if tab[ownerName] then
        techIsEqual = (tab[ownerName].TechLevel == nil) or (tab[ownerName].TechLevel:evaluate(techLevel))
        if techIsEqual then
            return tab[ownerName]
        end
    end

    if tab["DEFAULT"] then
        techIsEqual = (tab["DEFAULT"].TechLevel == nil) or (tab["DEFAULT"].TechLevel:evaluate(techLevel))
        if techIsEqual then
            return tab["DEFAULT"]
        end
    end

    return nil
end

function FighterSpawn:HasHangar()
    local hasHangarFlag = false
    local typeName = Object.Get_Type().Get_Name()
    if TypeLibrary.Units[typeName].Flags then
        hasHangarFlag = TypeLibrary.Units[typeName].Flags.HANGAR
    end
    return hasHangarFlag or EvaluatePerception("Has_Hangar", Object.Get_Owner(), Object) == 1
end

function FighterSpawn:CheckFighters(globals)
    for i, data in pairs(self.spawnedFighters) do
        if not data.Squadron or not TestValid(data.Squadron) then
            Register_Timer(self.Spawn, 5, {self, data})
            table.remove(self.spawnedFighters, i)
        end
    end
end

function FighterSpawn.Spawn(wrapper)
    local self = wrapper[1]
    local data = wrapper[2]
    local objectType = data.ObjectType
    local tab = self.fighterData[objectType.Get_Name()]
    local entry = self:GetFighterEntry(tab)

    if not entry then
        DebugMessage("Could not find Fighter Entry for %s on Carrier %s", tostring(objectType.Get_Name()), tostring(Object.Get_Type().Get_Name()))
        return
    end

    if entry.Reserve > 0 then
        local sqadron = Spawn_Unit(objectType, Object.Get_Bone_Position("root"), Object.Get_Owner(), true, false)[1]
        data.Squadron = sqadron
        table.insert(self.spawnedFighters, data)
        entry.Reserve = entry.Reserve - 1
    end
end

return FighterSpawn
