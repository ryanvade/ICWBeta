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
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")
TRUtil = require("TRUtil")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction
  }

end

function Find_Faction(message)
  if message == OnEnter then

	local p_cis = Find_Player("Rebel")
	local p_republic = Find_Player("Empire")

	 if p_republic.Is_Human() then
		Story_Event("ENABLE_BRANCH_GAR_FLAG")
	elseif p_cis.Is_Human() then
		Story_Event("ENABLE_BRANCH_CIS_FLAG")
	end
	
	end
end

