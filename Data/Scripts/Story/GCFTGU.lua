require("PGStoryMode")
require("RandomGCSpawn")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    StoryModeEvents = { Universal_Story_Start = Spawn_Starting_Forces }
	
end		

function Spawn_Starting_Forces(message)
    if message == OnEnter then		
		--Randomly spawn units at all planets owned by neutral or hostile
		--Probably want some screen text to tell the player the game is loading still
		Spawn_At_All_Planets()
	end
end