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
--*   @Filename:            WorldDevastator.lua
-- @Last modified by:
-- @Last modified time: 2018-02-13T00:41:41+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Util")
require("TRCommands")

WorldDevastator = {}

WorldDevastator.isActive = true

function WorldDevastator:Init(globals)
    if Get_Game_Mode() ~= "Space" then
        self.isActive = false
        return
    end

    self.trackedObjects = {}

    self.levels = {
        [1] = 5,
        [2] = 10
    }

    self.levelDummies = {
        [1] = "WORLD_DEVASTATOR_BONUS_DUMMY",
        [2] = "WORLD_DEVASTATOR_BONUS_DUMMY"
    }

    self.maxLevel = table.getn(self.levels)

    self.consumedCount = GlobalValue.Get("WorldDevastatorConsumedCount")
    if not ValidGlobalValue(self.consumedCount) then
        self.consumedCount = 0
    end

    self.bonusDummy = nil

    if self:GetCurrentLevel() >= self.maxLevel then
        self:ApplyEffects()
        self.isActive = false
        return
    end

    TR_Register_Prox(Object, WorldDevastatorProx, 1000, nil, self)
end

function WorldDevastator:Update(globals)
    for unit, bool in pairs(self.trackedObjects) do
        if not TestValid(unit) then
            self.consumedCount = self.consumedCount + 1
            GlobalValue.Set("WorldDevastatorConsumedCount", self.consumedCount)
        end
        self:StopTrackingIfOutOfRange(unit)
    end

    self:ApplyEffects()
end

function WorldDevastator:GetCurrentLevel()
    local level = table.getn(self.levels)
    while level > 0 do
        if self.consumedCount >= self.levels[level] then
            return level
        end
        level = level - 1
    end

    return level
end

function WorldDevastator:StopTrackingIfOutOfRange(unit)
    if not TestValid(unit) or Object.Get_Distance(unit) > 1000 then
        self.trackedObjects[unit] = nil
    end
end

function WorldDevastator:ApplyEffects()
    local currentLevel = self:GetCurrentLevel()
    local dummyTypeName = self.levelDummies[currentLevel]

    local hasDummy = TestValid(self.bonusDummy)
    if hasDummy then
        if self.bonusDummy.Get_Type().Get_Name() == dummyTypeName then
            return
        end

        self.bonusDummy.Despawn()
    end

    self.bonusDummy = Spawn_Unit(Find_Object_Type(dummyTypeName), Find_First_Object("Attacker Entry Position"), Object.Get_Owner())[1]
    self.bonusDummy.Set_Selectable(false)
    self.bonusDummy.Activate_Ability("STEALTH", true)

    if currentLevel >= self.maxLevel then
        self.isActive = false
    end
end

function WorldDevastatorProx(prox_obj, trigger_obj, self)
    if trigger_obj.Get_Parent_Object() then
        return
    end

    if trigger_obj.Get_Owner() == Find_Player("Neutral") then
        return
    end

    if not self.trackedObjects[trigger_obj] then
        self.trackedObjects[trigger_obj] = true
    end
end

return WorldDevastator
