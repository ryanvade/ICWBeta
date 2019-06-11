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
--*   @Author:              Jorritkarwehr
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCDeltaSource.lua
--*   @Last modified by:    Jorritkarwehr
--*   @Last modified time:  2017-12-21T12:39:33+01:00
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
		Determine_Faction_LUA = Find_Faction,
		Spawn_Delta = Place_Informant
	}

end

function Place_Informant(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")

    start_planet = FindPlanet("Coruscant")
	
    spawn_list_Delta_Source = { "Delta_Source"  }
    DeltaSourceSpawn = SpawnList(spawn_list_Delta_Source, start_planet, p_empire,true,false)

	ScriptExit()
  elseif message == OnUpdate then

  end
end

function Find_Faction(message)
  if message == OnEnter then

	local p_empie = Find_Player("Empire")

    if p_empie.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
    end
  end
end