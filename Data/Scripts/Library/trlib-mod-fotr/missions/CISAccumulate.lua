require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionCISAccumulate
MissionCISAccumulate = class()

function MissionCISAccumulate:new(player_agnostic_plot)

	
	self.IsActive = 0

end

function MissionCISAccumulate:begin()

	if self.IsActive == 0 then

	self.IsActive = 1

	dialog = "MISSION_DIALOG_CIS_ACCUMULATE_CREDITS"
	
	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Accumulate_Credits_CIS.xml")

	reward_unit = Find_Object_Type("Munificent")
	reward_count = 2
	target = 20000
	
	event = plot.Get_Event("Accumulate_Credits_00")
	event.Set_Dialog(dialog)
	event.Clear_Dialog_Text()
	event.Add_Dialog_Text("TEXT_INTERVENTION_CREDIT_TARGET", target)
	event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
	
	event = plot.Get_Event("Accumulate_Credits_03")
	event.Set_Reward_Parameter(1, "REBEL")

	plot.Activate()


	Create_Thread("Accumulate_Observer")

	elseif self.IsActive == 1 then
			
	end
end

function Accumulate_Observer()

	while not Check_Story_Flag(Find_Player("Rebel"), "ACCUMULATE_CREDITS_NOTIFICATION_00", nil, true) do
		Sleep(1)
	end	

	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Accumulate_Credits_CIS.xml")

	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))

	event = plot.Get_Event("Accumulate_Credits_04")
	event.Set_Event_Parameter(0, target)
	event.Set_Reward_Parameter(0, reward_unit)
	event.Set_Reward_Parameter(1, reward_location)
	event.Set_Reward_Parameter(2, reward_count)
	event.Set_Dialog(dialog)
	event.Clear_Dialog_Text()
	event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)


	currentSupport = GlobalValue.Get("IGBCApprovalRating")
	GlobalValue.Set("IGBCApprovalRating", currentSupport + 5)

	plot.Suspend()

	plot.Reset()	

	self.IsActive = 0

end

return MissionCISAccumulate
