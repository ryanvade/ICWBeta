--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              Jorritkarwehr
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCDeltaSource.lua
--*   @Last modified by:    Jorritkarwehr
--*   @Last modified time:  2017-12-21T12:39:33+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
    ServiceRate = 0.005

    StoryModeEvents = {Launch_Controller = Begin_GC}
end

function Begin_GC(message)
  if message == OnEnter then
  

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Hutts")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Pirates")
	p_maldrood = Find_Player("Teradoc")
	p_corporate = Find_Player("Corporate_Sector")
	p_hapes = Find_Player("Hapes_Consortium")

	if p_newrep.Is_Human() then
		player = p_newrep
	elseif p_empire.Is_Human() then
		player = p_empire
	elseif p_eoth.Is_Human() then
		player = p_eoth
	elseif p_eriadu.Is_Human() then
		player = p_eriadu
	elseif p_pentastar.Is_Human() then
		player = p_pentastar
	elseif p_zsinj.Is_Human() then
		player = p_zsinj
	elseif p_maldrood.Is_Human() then
		player = p_maldrood
	elseif p_corporate.Is_Human() then
		player = p_corporate
	elseif p_hapes.Is_Human() then
		player = p_hapes
	end
	
	credits = player.Get_Credits()

  elseif message == OnUpdate then
  
	oldCredits = credits
	credits = player.Get_Credits()

	if oldCredits < credits then
		Story_Event("CANCELED_OBJECT")
	end

  end
end