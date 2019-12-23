require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionRepAccumulate
MissionRepBuildShipyards = class()

function MissionRepBuildShipyards:new(player_agnostic_plot)

	self.IsActive = 0

end

function MissionRepBuildShipyards:begin()

	if self.IsActive == 0 then

		shipyard_type = Find_Object_Type("Remnant_Star_Base_2")
		shipyard_count = 2	

		dialog = "MISSION_DIALOG_REP_BUILD_SHIPYARDS"
		
		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Upgrade_Space_Station_Rep.xml")

		reward_unit = Find_Object_Type("Arquitens")
		reward_count = 2
		
		--Setup the first event to pop up a dialog and give the player some money to spend on the cannons				
		event = plot.Get_Event("Build_Generic_Structure_00")
		event.Set_Reward_Parameter(0, shipyard_count * 1000)
		--event.Set_Dialog(dialog)
		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_QUANTITY", shipyard_count)
		event.Add_Dialog_Text("TEXT_INTERVENTION_STRUCTURE", shipyard_type)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
		
		--Set up the second event to fire when we build the correct number of ion cannons
		event = plot.Get_Event("Build_Generic_Structure_01")
		event.Set_Event_Parameter(0, shipyard_type)
		event.Set_Event_Parameter(1, shipyard_count)
		event.Set_Reward_Parameter(1, "EMPIRE")

		plot.Activate()

		Create_Thread("ShipyardMission_Observer_Rep")

	elseif self.IsActive == 1 then
			
	end
	
end

function ShipyardMission_Observer_Rep()

	while not Check_Story_Flag(Find_Player("Empire"), "UPGRADE_SPACE_STATION_NOTIFICATION_00", nil, true) do
		Sleep(1)
	end	
	
	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Upgrade_Space_Station_Rep.xml")

	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Empire"))

	event = plot.Get_Event("Upgrade_Space_Station_05")
	event.Set_Event_Parameter(0, target)
	event.Set_Reward_Parameter(0, reward_unit)
	event.Set_Reward_Parameter(1, reward_location)
	event.Set_Reward_Parameter(2, reward_count)
	event.Set_Dialog(dialog)
	event.Clear_Dialog_Text()
	event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)

	currentSupport = GlobalValue.Get("RepublicApprovalRating")
	GlobalValue.Set("RepublicApprovalRating", currentSupport + 5)

	plot.Suspend()

	plot.Reset()	

	self.IsActive = 0

end

return MissionRepBuildShipyards
