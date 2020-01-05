require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionCISConquerPlanet
MissionCISConquerPlanet = class()

function MissionCISConquerPlanet:new(player_agnostic_plot)

end

function MissionCISConquerPlanet:begin()

	if CISConquerObserverThread then

	else

		dialog = "MISSION_DIALOG_CIS_CONQUER_PLANET"
		
		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Conquer_Planet_CIS.xml")

		target = StoryUtil.FindFriendlyPlanet(Find_Player("Empire"))
		
		reward_unit = Find_Object_Type("Auxilia")
		reward_count = 4
		
		event = plot.Get_Event("Conquer_Planet_00")
		event.Set_Dialog(dialog)
		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_OBJECTIVE_CONQUER_TARGET", target)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
		
		
		event = plot.Get_Event("Conquer_Planet_01")
		event.Set_Event_Parameter(0, target)

		plot.Activate()

		CISConquerObserverThread = Create_Thread("Conquer_Observer_CIS")
	end

end

function Conquer_Observer_CIS()

	while not Check_Story_Flag(Find_Player("Empire"), "CONQUER_PLANETS_NOTIFICATION_00", nil, true) do
		Sleep(1)
	end	

	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Conquer_Planet_CIS.xml")

	cis = Find_Player("Rebel")
	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))

	spawn_list_reward = { "Auxilia" , "Auxilia", "Auxilia", "Auxilia" }
	SpawnList(spawn_list_reward, reward_location, cis, true, false)

	currentSupport = GlobalValue.Get("TechnoApprovalRating")
	GlobalValue.Set("TechnoApprovalRating", currentSupport + 5)

	plot.Suspend()

	plot.Reset()

	if CISConquerObserverThread then
		Thread.Kill(CISConquerObserverThread)
		CISConquerObserverThread = nil
	end

end

return MissionCISConquerPlanet
