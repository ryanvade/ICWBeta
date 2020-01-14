require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionRepBuildShipyards
MissionCISBuildShipyards = class()

function MissionCISBuildShipyards:new(player_agnostic_plot)

end

function MissionCISBuildShipyards:begin()

	if not CISBuildShipyardsObserverThread then
		dialog = "MISSION_DIALOG_CIS_BUILD_SHIPYARDS"
		
		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Upgrade_Space_Station_CIS.xml")


		shipyard_type = Find_Object_Type("NR_Star_Base_2")
		shipyard_count = 2	

		reward_unit = Find_Object_Type("MTT_Company")
		reward_count = 2
		reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))
		
		--Setup the first event to pop up a dialog and give the player some money to spend on the cannons				
		event = plot.Get_Event("Upgrade_Space_Station_00")
		event.Set_Dialog(dialog)

		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", shipyard_count)
		event.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE", shipyard_type)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
		
		--Set up the second event to fire when we build the correct number of ion cannons
		event = plot.Get_Event("Upgrade_Space_Station_01")
		event.Set_Event_Parameter(0, shipyard_type)
		event.Set_Event_Parameter(1, shipyard_count)
		event.Set_Reward_Parameter(1, "REBEL")

		plot.Activate()

		CISBuildShipyardsObserverThread = Create_Thread("ShipyardMission_Observer_CIS")

	end
	
end

function ShipyardMission_Observer_CIS()

	while not Find_First_Object("Dummy_Intervention_Shipyard") do
		Sleep(1)
	end	

	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Upgrade_Space_Station_CIS.xml")
	cis = Find_Player("Rebel")

	object = Find_First_Object("Dummy_Intervention_Shipyard")
	object.Despawn()
	
	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))
	spawn_list_reward = { "MTT_Company" , "MTT_Company" }
	SpawnList(spawn_list_reward, reward_location, cis, true, false)

	currentSupport = GlobalValue.Get("CommerceApprovalRating")
	GlobalValue.Set("CommerceApprovalRating", currentSupport + 5)

	plot.Suspend()
	plot.Reset()	

	if CISBuildShipyardsObserverThread then
		Thread.Kill(CISBuildShipyardsObserverThread)
		CISBuildShipyardsObserverThread = nil
	end

end

return MissionCISBuildShipyards
