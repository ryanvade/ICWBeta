require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionRepBuildShipyards
MissionCISDestroyShips = class()

function MissionCISDestroyShips:new(player_agnostic_plot)

end

function MissionCISDestroyShips:begin()

	if not CISDestroyShipsObserverThread then
		dialog = "MISSION_DIALOG_CIS_KILL_UNITS"
		
		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Destroy_Ships_CIS.xml")

		target_type = Find_Object_Type("Arquitens")
		target_count = 5	

		reward_unit = Find_Object_Type("Recusant")
		reward_count = 1
		reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))
		
		--Setup the first event to pop up a dialog and give the player some money to spend on the cannons				
		event = plot.Get_Event("Destroy_Ships_00")
		event.Set_Dialog(dialog)

		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", target_count)
		event.Add_Dialog_Text("TEXT_INTERVENTION_UNIT", target_type)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
		
		plot.Activate()

		CISDestroyShipsObserverThread = Create_Thread("DestroyShips_Observer_CIS")

	end
	
end

function DestroyShips_Observer_CIS()

	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Destroy_Ships_CIS.xml")

	while not Find_First_Object("Dummy_Intervention_Hunt") do
		Sleep(1)
	end	

	object = Find_First_Object("Dummy_Intervention_Hunt")
	object.Despawn()
	
	cis = Find_Player("Rebel")
	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))
	spawn_list_reward = { "Recusant" }
	SpawnList(spawn_list_reward, reward_location, cis, true, false)

	currentSupport = GlobalValue.Get("TradeFedApprovalRating")
	GlobalValue.Set("TradeFedApprovalRating", currentSupport + 5)

	plot.Suspend()

	plot.Reset()
	
	if CISDestroyShipsObserverThread then
		Thread.Kill(CISDestroyShipsObserverThread)
		CISDestroyShipsObserverThread = nil
	end

end

return MissionCISDestroyShips
