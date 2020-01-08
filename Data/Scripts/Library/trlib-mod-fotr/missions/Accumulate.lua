require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionAccumulate
MissionAccumulate = class()

function MissionAccumulate:new()

end

function MissionAccumulate:begin()

	if not AccumulateObserverThread then
		cis = Find_Player("Rebel")
		republic = Find_Player("Empire")

		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Accumulate_Credits_Agnostic.xml")

		if cis.Is_Human() then

			human = cis

			dialog = "MISSION_DIALOG_CIS_ACCUMULATE_CREDITS"
			reward_unit = Find_Object_Type("Munificent")
			
		elseif republic.Is_Human() then

			human = republic

			dialog = "MISSION_DIALOG_REP_ACCUMULATE_CREDITS"
			reward_unit = Find_Object_Type("Dreadnaught_Lasers")	

		end

	
		reward_count = 2
		target = 25000
		
		event = plot.Get_Event("Accumulate_Credits_00")
		event.Set_Dialog(dialog)
		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_CREDIT_TARGET", target)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)

		plot.Activate()

		AccumulateObserverThread = Create_Thread("Accumulate_Observer_Agnostic")
	end

end

function Accumulate_Observer_Agnostic()

	if Find_Player("Rebel").Is_Human() then

		while Find_Player("Rebel").Get_Credits() <= 25000 do
			Sleep(1)
		end	
		
	elseif Find_Player("Empire").Is_Human() then

		while Find_Player("Empire").Get_Credits() <= 25000 do
			Sleep(1)
		end	

	end

	cis = Find_Player("Rebel")
	republic = Find_Player("Empire")


	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Accumulate_Credits_Agnostic.xml")
	Story_Event("CREDITS_ACCUMULATED")

	reward_location = StoryUtil.FindFriendlyPlanet(human)

	if cis.Is_Human() then

		spawn_list_reward = { "Munificent" , "Munificent" }
		SpawnList(spawn_list_reward, reward_location, cis, true, false)
	
		currentSupport = GlobalValue.Get("IGBCApprovalRating")
		GlobalValue.Set("IGBCApprovalRating", currentSupport + 5)

	elseif republic.Is_Human() then

		spawn_list_reward = { "Dreadnaught_Lasers" , "Dreadnaught_Lasers" }
		SpawnList(spawn_list_reward, reward_location, republic, true, false)
	
		currentSupport = GlobalValue.Get("RepublicApprovalRating")
		GlobalValue.Set("RepublicApprovalRating", currentSupport + 2)

	end

	plot.Suspend()

	plot.Reset()

	if AccumulateObserverThread then
		Thread.Kill(AccumulateObserverThread)
		AccumulateObserverThread = nil
	end

end

return MissionAccumulate
