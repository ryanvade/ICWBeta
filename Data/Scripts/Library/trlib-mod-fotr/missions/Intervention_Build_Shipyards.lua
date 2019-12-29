require("pginterventions")

function Declare_Goal_Type()
	
	Category = "Intervention_Build_Shipyards"
		
	plot = nil
	event = nil
	dialog = nil
	shipyard_type = nil
	shipyard_count = nil	
	unit = nil
	reward_location = nil

		
end

function Intervention_Thread()
	
	Begin_Intervention()
	
	-- if PlayerObject.Get_Faction_Name() == "EMPIRE" then
		-- dialog = "Dialog_E_Intervention_Build_Shipyards"
	-- elseif PlayerObject.Get_Faction_Name() == "REBEL" then
		-- dialog = "Dialog_R_Intervention_Build_Shipyards"
	-- else 
		-- ScriptExit()
	-- end		
	
	
	--Reverse order for shipyard level since bigger is better
	if EvaluatePerception("Intervention_Helper_Shipyards_4", PlayerObject) == 1 then
		if PlayerObject.Get_Faction_Name() == "EMPIRE" then
			shipyard_type = Find_Object_Type("E_Orbital_Shipyard_4")
		elseif PlayerObject.Get_Faction_Name() == "REBEL" then
			shipyard_type = Find_Object_Type("R_Orbital_Shipyard_4")
		else
			ScriptExit()
		end
	elseif EvaluatePerception("Intervention_Helper_Shipyards_3", PlayerObject) == 1 then
		if PlayerObject.Get_Faction_Name() == "EMPIRE" then
			shipyard_type = Find_Object_Type("E_Orbital_Shipyard_3")
		elseif PlayerObject.Get_Faction_Name() == "REBEL" then
			shipyard_type = Find_Object_Type("R_Orbital_Shipyard_3")
		else
			ScriptExit()
		end
	elseif EvaluatePerception("Intervention_Helper_Shipyards_2", PlayerObject) == 1 then
		if PlayerObject.Get_Faction_Name() == "EMPIRE" then
			shipyard_type = Find_Object_Type("E_Orbital_Shipyard_2")
		elseif PlayerObject.Get_Faction_Name() == "REBEL" then
			shipyard_type = Find_Object_Type("R_Orbital_Shipyard_2")
		else
			ScriptExit()
		end
	elseif EvaluatePerception("Intervention_Helper_Shipyards_1", PlayerObject) == 1 then
		if PlayerObject.Get_Faction_Name() == "EMPIRE" then
			shipyard_type = Find_Object_Type("E_Orbital_Shipyard_1")
		elseif PlayerObject.Get_Faction_Name() == "REBEL" then
			shipyard_type = Find_Object_Type("R_Orbital_Shipyard_1")
		else
			ScriptExit()
		end
	else
		ScriptExit()
	end
	
	--Could be GameRandom
	shipyard_count = 1
	
	--Select a reward (currently fixed)
	if PlayerObject.Get_Tech_Level() <= 2 then
		reward_unit, reward_count = Select_Reward_Unit(reward_tech_1, PlayerObject, 10000)
	else
		reward_unit, reward_count = Select_Reward_Unit(reward_tech_2, PlayerObject, 10000)
	end

	--find the xml defined plot for building a generic structure and fill in the skeleton so that
	--it asks the player to build the appropraite number of ion cannons
	plot = Get_Story_Plot("Intervention_Build_Generic_Structure.xml")
				
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
	event.Set_Reward_Parameter(1, PlayerObject.Get_Faction_Name())
	
	--Start the plot
	plot.Activate()	
	
	--Wait on notification from the story system that the task has been accomplished
	Wait_On_Flag("BUILD_GENERIC_STRUCTURE_NOTIFICATION_00", nil)
	
	--Find a suitable place to station the reward units
	while not reward_location do
		reward_location = FindTarget(Intervention, "Major_Intervention_Value", "Friendly", 1.0)
		Sleep(1)
	end
	
	--Set up an event to spawn the reward unit at the selected location and congratulate the player
	event = plot.Get_Event("Build_Generic_Structure_02")
	event.Clear_Dialog_Text()
	event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)

	event = plot.Get_Event("Build_Generic_Structure_03")
	event.Set_Reward_Parameter(0, reward_unit)
	event.Set_Reward_Parameter(1, reward_location)
	event.Set_Reward_Parameter(2, reward_count)	

	event = plot.Get_Event("Build_Generic_Structure_04")
	event.Set_Reward_Parameter(1, PlayerObject.Get_Faction_Name())

	--Fire this story event to allow the plot to continue and run the event we just set up
	Story_Event("BUILD_GENERIC_STRUCTURE_NOTIFICATION_01")
	
	--Wait until the plot informs us that it's done, stop and reset it, then sleep for a while before we exit
	--to prevent interventions from spawning back-to-back
	Wait_On_Flag("BUILD_GENERIC_STRUCTURE_NOTIFICATION_02", nil)

	plot.Suspend()

	plot.Reset()

	End_Intervention()



end