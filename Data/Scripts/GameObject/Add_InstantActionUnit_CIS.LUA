--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- © Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {"GOZANTI_CRUISER_SQUADRON",
"DIAMOND_FRIGATE",
"HARDCELL",
"GEONOSIAN_CRUISER",
"C9979_CARRIER",
"MUNIFICENT",
"RECUSANT",
"BULWARK_II",
"BULWARK_I",
"GENERIC_PROVIDENCE",
"GENERIC_LUCREHULK",
"SUBJUGATOR",
"CAPTOR",
"AUXILIA"}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		if Get_Game_Mode() ~= "Space" then
			ScriptExit()
		end
		rebel = Find_Player("Rebel")
		my_name = Object.Get_Type().Get_Name()
		rebel_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_NEWREP")
		

		for i, obj in pairs(unit_table) do
			contain_check = string.find(my_name, obj)			
	 			if contain_check ~= nil then
					unit = Find_Object_Type(obj)
					Spawn_Unit(unit, rebel_spawn_marker, rebel, true, false)
					ScriptExit()
				end
			
		end
		ScriptExit()
		
	end
end