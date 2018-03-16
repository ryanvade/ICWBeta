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
--*   @Author:              [TR]Pox <svenmarcus>
--*   @Date:                2018-03-09T12:06:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GameObject.lua
--*   @Last modified by:    svenmarcus
--*   @Last modified time:  2018-03-09T12:30:44+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Class")
TypeLibrary = require("GameObjectLibrary")

GameObject = Class {
  Constructor = function(self, obj)
    self.GameObject = obj
    self.Type = obj.Get_Type()
    self.TypeName = obj.Get_Type().Get_Name()
  end,

  ActivateAbility = function(self, abilityName)
    self.GameObject.Activate_Ability(abilityName, true)
  end,

  AttackMove = function(self, target)
    self.GameObject.Attack_Move(target)
  end,

  AttackTarget = function(self, target)
    self.GameObject.Attack_Target(target)
  end,

  ChangeOwner = function(self, newOwner)
    self.GameObject.Change_Owner(newOwner)
  end,

  DeactivateAbility = function(self, abilityName)
    self.GameObject.Activate_Ability(abilityName, false)
  end,

  Despawn = function(self)
    self.GameObject.Despawn()
  end,

  GetOwner = function(self)
    return self.GameObject.Get_Owner()
  end,

  HasEngines = function(self)
    return self.GameObject.Are_Engines_Online()
  end,

  HasHangar = function(self)
    local hasHangarFlag = false
    if TypeLibrary.Units[self.TypeName].Flags then
        hasHangarFlag = TypeLibrary.Units[self.TypeName].Flags.HANGAR
    end
    return hasHangarFlag or EvaluatePerception("Has_Hangar", Object.Get_Owner(), Object) == 1
  end,

  MoveTo = function(self, target)
    self.GameObject.Move_To(target)
  end,

  Teleport = function(self, target)
    self.GameObject.Teleport(target)
  end,

  UseAbilityOnTarget = function(self, abilityName, target)
    self.GameObject.Activate_Ability(abilityName, target)
  end

}
