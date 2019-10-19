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
		hapan_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_HAPANS")
		eoth_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_EOTH")
		csa_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_CSA")
		pentastar_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_PENTASTAR")
	
		rebel = Find_Player("Rebel")
		empire = Find_Player("Empire")
		hapans = Find_Player("Hapes_Consortium")
		
		 empire.Make_Ally(hapans)
		 empire.Make_Ally(rebel)
		 
		 rebel.Make_Ally(empire)
		 rebel.Make_Ally(hapans)
		 
		 hapans.Make_Ally(rebel)
		 hapans.Make_Ally(empire)
		 
		 	
		empire_spawn_marker.Change_Owner(empire)
		rebel_spawn_marker.Change_Owner(empire)
		
		if TestValid(hapan_spawn_marker) then
			hapan_spawn_marker.Change_Owner(empire)
		end 
		if TestValid(eoth_spawn_marker) then
			eoth_spawn_marker.Change_Owner(empire)
		end
		if TestValid(csa_spawn_marker) then	
			csa_spawn_marker.Change_Owner(empire)
		end
		if TestValid(pentastar_spawn_marker) then		
			pentastar_spawn_marker.Change_Owner(empire)
		end
	end
end

function Begin_Battle(message)
	if message == OnEnter then

		empire_spawn_marker.Make_Invulnerable(true)
		rebel_spawn_marker.Make_Invulnerable(true)
		
		if TestValid(hapan_spawn_marker) then
			hapan_spawn_marker.Make_Invulnerable(true)
		end
		
		 empire.Make_Enemy(hapans)
		 empire.Make_Enemy(rebel)
		 
		 rebel.Make_Enemy(empire)
		 rebel.Make_Enemy(hapans)
		 
		 hapans.Make_Enemy(rebel)
		 hapans.Make_Enemy(empire)
	end
end









