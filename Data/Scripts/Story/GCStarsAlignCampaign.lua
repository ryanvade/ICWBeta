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

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
	Determine_Faction_LUA = Find_Faction,
    Talks_End = Begin_GC
  }

end

function Find_Faction(message)
  if message == OnEnter then

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Hutts")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Pirates")
	p_maldrood = Find_Player("Teradoc")
	p_corporate = Find_Player("Corporate_Sector")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
	elseif p_eriadu.Is_Human() then
		Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
	elseif p_zsinj.Is_Human() then
		Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
	elseif p_maldrood.Is_Human() then
		Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
	elseif p_corporate.Is_Human() then
		Story_Event("ENABLE_BRANCH_CORPORATE_SECTOR_FLAG")
	end
	
  end
end

function Begin_GC(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_rebel = Find_Player("Rebel")
    p_pentastar = Find_Player("Pentastar")

    start_planet = FindPlanet("Bastion")
	if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
		start_planet = TRUtil.FindFriendlyPlanet(p_pentastar)
	end
	if start_planet then
	    spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
		ReaperSpawn = SpawnList(spawn_list_Reaper, start_planet, p_pentastar,true,false)
	end
	
	if p_pentastar.Is_Human() then
  		Story_Event("KAINE_JOINS_SPEECH")
  	end
	


	ScriptExit()
  elseif message == OnUpdate then

  end
end

