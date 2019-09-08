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
	unit_table = {"CORELLIAN_CORVETTE",
	"MARAUDER_MISSILE_CRUISER",
"CORELLIAN_GUNBOAT",
"SACHEEN",
"ENDURANCE",
"NEBULA",
"DAUNTLESS",
"HOME_ONE_TYPE",
"MAJESTIC",
"MC80B",
"MC90",
"CORONA",
"MC40A",
"QUASER",
"NEBULON_B_FRIGATE",
"CALAMARI_CRUISER",
"ALLIANCE_ASSAULT_FRIGATE",
"BAC",
"VISCOUNT"}

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