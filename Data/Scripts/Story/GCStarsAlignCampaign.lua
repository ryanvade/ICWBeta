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
--*   @Author:              Corey
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCStarsAlignCampaign.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:39:24+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
TM = require("TRGameModeTransactions")


function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Talks_End = Begin_GC
  }

end

function Galactic(message)
  if message == OnEnter then

  elseif message == OnUpdate then
  end
end

function Begin_GC(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")
    p_pentastar = Find_Player("Pentastar")

    --Post-Zsinj, Kosh merges with Treutan
    start_planet = FindPlanet("Bastion")
    spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
    ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)



  elseif message == OnUpdate then

  end
end
