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
--*   @Last modified time:  2018-02-05T07:31:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")
TM = require("TRGameModeTransactions")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
  Universal_Story_Start = Begin_GC,
    Determine_Faction_LUA = Find_Faction,
    Rogriss_Joins = Rogriss_Deployed
  }

end

function Find_Faction(message)
  if message == OnEnter then

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	end

  end
end

function Rogriss_Deployed(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")

	local start_planet = FindPlanet("Bastion")
	if start_planet.Get_Owner() == Find_Player("Empire") then
		if p_empire.Is_Human() then
			Story_Event("ROGRISS_JOINS_SPEECH")
		end
		local spawn_list_Rogriss = { "Rogriss_Dominion" }
		local RogrissSpawn = SpawnList(spawn_list_Rogriss, start_planet, p_empire,true, false)
	end


  elseif message == OnUpdate then

  end
end


