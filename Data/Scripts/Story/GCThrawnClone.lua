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
--*   @Filename:            GCThrawnClone.lua
--*   @Last modified by:    [TR]Jorritkarwehr
--*   @Last modified time:  2019-2-12T12:39:24+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
	Determine_Faction_LUA = Find_Faction
  }

end

function Find_Faction(message)
  if message == OnEnter then

	local p_eoth = Find_Player("Underworld")

    if p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
    end
  end
end
