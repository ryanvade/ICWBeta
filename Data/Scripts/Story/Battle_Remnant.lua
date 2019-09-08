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
--*   @Date:                2017-12-14T10:54:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Survival_Remnant.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T13:18:54+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")


------------------------------------------------------------------------------------------------




function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = { Setup_Start = Begin_GC,
						Battle_Start = Begin_Battle}

	pirates = Find_Player("Hutts")




end


function Begin_GC(message)
	if message == OnEnter then

		empire_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_EMPIRE")
		rebel_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_NEWREP")
		

		rebel = Find_Player("Rebel")
		empire = Find_Player("Empire")
		
		 empire.Make_Ally(rebel)
		 rebel.Make_Ally(empire)

	end
end

function Begin_Battle(message)
	if message == OnEnter then

	    empireBase = Find_First_Object("Empire_InstantAction")
	    rebelBase = Find_First_Object("Rebel_InstantAction")
		empireBase.Take_Damage(100000)
		rebelBase.Take_Damage(100000)
		
		empire.Make_Enemy(rebel)
		rebel.Make_Enemy(empire)
	end
end









