--////////////////////////////////////////////////
-- Katana Mission (New Republic)
--////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Battle_Start = Begin_Battle
	}
end


function Begin_Battle(message)
	if message == OnEnter then
		local p_empire = Find_Player("Empire")
		local p_rebel = Find_Player("Rebel")
		local entry_marker = Find_First_Object("Reinforcement_Point")
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus1_Cap")
		end
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus2_Cap")
		end
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus3_Cap")
		end
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus4_Cap")
		end
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus5_Cap")
		end
		if not entry_marker then
			entry_marker = Find_First_Object("Reinforcement_Point_Plus10_Cap")
		end
		
		--Delardus AT-ATs used as army troopers seem more fitting as disguised rebels
		--local spawn_list_byss = { "Delvardus_Heavy_Assault_Company" , "Delvardus_Heavy_Assault_Company", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid" }
		local spawn_list_byss = { "AT_AT_Walker_Armytrooper" , "AT_AT_Walker_Armytrooper", "XR85", "XR85", "XR85" }
		local raiders = SpawnList(spawn_list_byss, entry_marker, p_rebel, false, false)
	end
end