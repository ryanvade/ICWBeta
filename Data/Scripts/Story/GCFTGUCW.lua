require("PGStoryMode")
require("RandomGCSpawnCW")

function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    StoryModeEvents = { Universal_Story_Start = Spawn_Starting_Forces }
	
end		

function Spawn_Starting_Forces(message)
    if message == OnEnter then		
	
	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Hutts")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Pirates")
	p_maldrood = Find_Player("Teradoc")
	p_corporate = Find_Player("Corporate_Sector")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
	elseif p_eriadu.Is_Human() then
		Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
	elseif p_zsinj.Is_Human() then
		Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
	elseif p_maldrood.Is_Human() then
		Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
	elseif p_corporate.Is_Human() then
		Story_Event("ENABLE_BRANCH_CORPORATE_SECTOR_FLAG")
	end
		--Randomly spawn units at all planets owned by neutral or hostile
		--Probably want some screen text to tell the player the game is loading still
		Spawn_At_All_Planets_CW()
	end
end