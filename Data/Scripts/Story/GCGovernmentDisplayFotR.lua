require("PGStoryMode")
require("PGBase")

CONSTANTS = ModContentLoader.get("GameConstants")
require("TRCommands")

--
-- Definitions -- This function is called once when the script is first created.
--
function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    ServiceRate = 5

    StoryModeEvents = {
        Government_Setup = Government_Display_Setup
    }

    setup_complete = false
    human_faction = nil
end

function Government_Display_Setup(message)
    if message == OnEnter then
        plot = Get_Story_Plot("GCGovernmentDisplay.xml")

        DebugMessage("%s -- plot is %s", tostring(Script), tostring(plot))

        government_display_event = plot.Get_Event("Government_Display")

        DebugMessage("%s -- event is %s", tostring(Script), tostring(government_display_event))

        setup_complete = true
    end
end

function Story_Mode_Service()
    DebugMessage("%s -- Servicing script", tostring(Script))

    if setup_complete == true then
        DebugMessage("%s -- Refreshing perceptions", tostring(Script))
        government_display_event.Clear_Dialog_Text()

        if Find_Player("Empire").Is_Human() then
            government_display_event.Add_Dialog_Text("STAT_SEPARATOR")
            government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC")
            government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CURRENT_APPROVAL", GlobalValue.Get("RepublicApprovalRating"))
            government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_CURRENT_CHANCELLOR", Find_Object_Type(GlobalValue.Get("ChiefOfState")))
            government_display_event.Add_Dialog_Text("STAT_SEPARATOR")
            government_display_event.Add_Dialog_Text("TEXT_GOVERNMENT_REPUBLIC_FUNCTION")
            government_display_event.Add_Dialog_Text("TEXT_TOOLTIP_NONE")  
      
        end
        
            

  
    end
end
