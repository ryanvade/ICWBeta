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
--*   @Author:              [TR]Pox
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            InvadingFleet.lua
--*   @Last modified by:    svenmarcus
--*   @Last modified time:  2018-03-30T03:07:16+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

    DebugMessage("%s -- In Definitions", tostring(Script))
    
    p_newrep = Find_Player("Rebel")
    p_empire = Find_Player("Empire")
    p_eoth = Find_Player("Underworld")
    p_eriadu = Find_Player("Hutts")
    p_pentastar = Find_Player("Pentastar")
    p_zsinj = Find_Player("Pirates")
    p_maldrood = Find_Player("Teradoc")
    p_corporate = Find_Player("Corporate_Sector")
    p_hapes = Find_Player("Hapes_Consortium")

	StoryModeEvents =
	{
		Battle_Start = DetermineEvents
	}



end

function DetermineEvents(message)
    if message == OnEnter then
        victoryPoint = Find_First_Object("Victory_Point")

        if victoryPoint then
            victoryPoint.Highlight(true)
            Story_Event("CAPTURE_POINT_PRESENT")
        else
            Story_Event("CAPTURE_POINT_NOT_PRESENT")
        end
    elseif message == OnUpdate then
        if victoryPoint.Get_Owner() ~= Find_Player("Neutral") then
    
            if victoryPoint.Get_Owner() == Find_Player("Rebel") and EvaluatePerception("Is_Defender", p_newrep) == 0 then
                Story_Event("SET_VICTOR_NEWREP_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Empire") and EvaluatePerception("Is_Defender", p_empire) == 0 then
                Story_Event("SET_VICTOR_EMPIRE_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Underworld") and EvaluatePerception("Is_Defender", p_eoth) == 0 then
                Story_Event("SET_VICTOR_EOTH_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Hutts") and EvaluatePerception("Is_Defender", p_eriadu) == 0 then
                Story_Event("SET_VICTOR_ERIADU_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Pentastar") and EvaluatePerception("Is_Defender", p_pentastar) == 0 then
                Story_Event("SET_VICTOR_PENTASTAR_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Pirates") and EvaluatePerception("Is_Defender", p_zsinj) == 0 then
                Story_Event("SET_VICTOR_ZSINJ_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Teradoc") and EvaluatePerception("Is_Defender", p_maldrood) == 0 then
                Story_Event("SET_VICTOR_TERADOC_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Corporate_Sector") and EvaluatePerception("Is_Defender", p_corporate) == 0 then
                Story_Event("SET_VICTOR_CORPORATE_SECTOR_FLAG")
            elseif victoryPoint.Get_Owner() == Find_Player("Hapes_consortium") and EvaluatePerception("Is_Defender", p_hapes) == 0 then
                Story_Event("SET_VICTOR_HAPES_FLAG")
            end

        end
    end
end
