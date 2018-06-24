require("PGStoryMode")
require("PGBase")
CONSTANTS = require("GameConstants")
require("TRCommands")

--
-- Definitions -- This function is called once when the script is first created.
--
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))

	ServiceRate = 5

	StoryModeEvents = {
						Stat_Setup = Stat_Display_Setup
					}
					
	setup_complete = false
end

function Stat_Display_Setup(message)
	if message == OnEnter then
		plot = Get_Story_Plot("GCStatDisplay.xml")

		DebugMessage("%s -- plot is %s", tostring(Script), tostring(plot))

		stat_display_event = plot.Get_Event("Stat_Display")

		DebugMessage("%s -- event is %s", tostring(Script), tostring(stat_display_event))
		
		liveFactionTable = CreateFactionTable(CONSTANTS.ALL_FACTIONS_NOT_NEUTRAL)
		
		setup_complete = true
	end
end

function Story_Mode_Service()
	DebugMessage("%s -- Servicing script", tostring(Script))

	if setup_complete == true then
		DebugMessage("%s -- Refreshing perceptions", tostring(Script))
		stat_display_event.Clear_Dialog_Text()

		for _, faction in pairs(liveFactionTable) do
			stat_display_event.Add_Dialog_Text("STAT_SEPARATOR")
			stat_display_event.Add_Dialog_Text(CONSTANTS.ALL_FACTION_TEXTS[faction.Get_Faction_Name()])
			stat_display_event.Add_Dialog_Text("STAT_SEPARATOR")
			stat_display_event.Add_Dialog_Text("STAT_PLANET_COUNT", EvaluatePerception("Planet_Ownership", faction))
			stat_display_event.Add_Dialog_Text("STAT_FORCE_PERCENT", EvaluatePerception("Percent_Forces", faction))
			stat_display_event.Add_Dialog_Text("STAT_INCOME", EvaluatePerception("Current_Income", faction))
			DebugMessage("%s -- Faction %s, planets: %s, forces: %s, income %s", tostring(Script), faction.Get_Faction_Name(), tostring(EvaluatePerception("Planet_Ownership", faction)), tostring(EvaluatePerception("Percent_Forces", faction)), tostring(EvaluatePerception("Current_Income", faction)))
		end
	end
end