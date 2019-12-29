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
--*   @Filename:            MultiLayer.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:34:25+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



MultiLayer = {}

MultiLayer.isActive = true

function MultiLayer:Init(globals)
  self.isActive = false
  if Get_Game_Mode() ~= "Space" then
     ScriptExit()
  end
  local unitEntry = TypeLibrary.Units[Object.Get_Type().Get_Name()]

  local heights = {"ZLayer_Medium"}

  if Object.Is_Category("Capital") then
    table.insert(heights, "ZLayer_Low")
  else
    table.insert(heights, "ZLayer_High")
  end

  Object.Prevent_All_Fire(true)

  Object.Cancel_Hyperspace()

  Object.Hide(true)
  Object.Hide(true)

  local heightType = Find_Object_Type(heights[GameRandom(1,table.getn(heights))])
  local zLayerDummyList = Spawn_Unit(heightType, Object.Get_Position(), Object.Get_Owner())
  zLayerDummy = zLayerDummyList[1]
  Object.Teleport(zLayerDummy)

  Object.Cinematic_Hyperspace_In(1)
  zLayerDummy.Despawn()
  Object.Prevent_All_Fire(false)
  Object.Make_Invulnerable(false)
  Object.Prevent_AI_Usage(false)
end

function MultiLayer:Update(globals)
end

return MultiLayer
