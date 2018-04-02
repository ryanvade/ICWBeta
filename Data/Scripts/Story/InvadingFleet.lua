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
--*   @Filename:            InvadingFleet.lua
--*   @Last modified by:    svenmarcus
--*   @Last modified time:  2018-03-30T03:07:16+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")
require("RaidFleet")
require("RandomEventQueue")
require("TRGameModeTransactions")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))
  --Define_State("State_Init", State_Init);
  --invaders = Find_Player("Hostile")
  --attack_chance = 0
  StoryModeEvents = {Battle_Start = State_Init,
    SWITCH_CONTROL_None1 = Remove_Huttlist,
    SWITCH_CONTROL_None2 = Remove_Huttlist,
    SWITCH_CONTROL_None3 = Remove_Huttlist,
    SWITCH_CONTROL_None4 = Remove_Huttlist,
    SWITCH_CONTROL_None5 = Remove_Huttlist,
    SWITCH_CONTROL_None6 = Remove_Huttlist,
    SWITCH_CONTROL_None7 = Remove_Huttlist,
    SWITCH_CONTROL_None8 = Remove_Huttlist,
    SWITCH_CONTROL_None9 = Remove_Huttlist,
    SWITCH_CONTROL_None10 = Remove_Huttlist,
    Retreat_Complete = Remove_Huttlist
  }

end


function State_Init(message)
  if message == OnEnter then
    TM = TransactionManager:New()
    TM:ResetBoardingTransactions()
    local fleet = MakeRaidFleet(15)
    --fleet:initialize()
    queue = MakeRandomEventQueue()
    queue:addEvent(fleet)
    queue:beginEvents()
    Game_Message("TEXT_STRANGE_SIGNAL")
  end
end

function Remove_Huttlist(message)
  if message == OnEnter then
    queue:postBattleCleanUp()
    --RegisterBoardingTransactions()
  end
end

function RegisterBoardingTransactions()
  TM:ExecuteBoardingTransactions()
end
