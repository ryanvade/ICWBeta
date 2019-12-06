--//////////////////////////////////////////////////////////////////////////////////////
-- Add Units to the reinforcement pool// This script is part of the Survival Mode
-- � Pox
--//////////////////////////////////////////////////////////////////////////////////////

require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")

function Definitions()
	
	DebugMessage("%s -- In Definitions", tostring(Script))

	-- possible units to spawn
	unit_table = {"CORELLIAN_CORVETTE",
"CORELLIAN_GUNBOAT",
"LAC",
"ARQUITENS",
"CARRACK_CRUISER_LASERS",
"GENERIC_ACCLAMATOR_ASSAULT_SHIP_II",
"GENERIC_ACCLAMATOR_ASSAULT_SHIP_LEVELER",
"GENERIC_ACCLAMATOR_ASSAULT_SHIP_I",
"DREADNAUGHT_LASERS",
"GENERIC_VICTORY_DESTROYER",
"GENERIC_VENATOR",
"INVINCIBLE_CRUISER",
"GENERIC_STAR_DESTROYER",
"GENERIC_TECTOR",
"GENERIC_PRAETOR"}

	Define_State("State_Init", State_Init);


end


function State_Init(message)
	if message == OnEnter then
		if Get_Game_Mode() ~= "Space" then
			ScriptExit()
		end
		empire = Find_Player("Empire")
		my_name = Object.Get_Type().Get_Name()
		empire_spawn_marker = Find_First_Object("INSTANTACTION_MARKER_EMPIRE")
		

		for i, obj in pairs(unit_table) do
			contain_check = string.find(my_name, obj)			
	 			if contain_check ~= nil then
					unit = Find_Object_Type(obj)
					Spawn_Unit(unit, empire_spawn_marker, empire, true, false)
					ScriptExit()
				end
			
		end
		ScriptExit()
		
	end
end