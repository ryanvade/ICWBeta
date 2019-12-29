-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ConquerPiratePlan.lua#1 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ConquerPiratePlan.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGTaskForce")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 4

function Definitions()	
	MinContrastScale = 0.3
	MaxContrastScale = 1.0
	
	PerFailureContrastAdjust = 0.0
		
	Category = "Defend_Planet | CIS_Federation_Defend_Planet"
	TaskForce = {
	{
		"MainForce"
		,"Corvette|Frigate|Capital|SuperCapital = 100%"
		,"-SpaceHero"
		,"-LandHero"
	}
	}
end

function MainForce_Thread()

	if MainForce.Are_All_Units_On_Free_Store() == true then
		AssembleForce(MainForce)
	else
		BlockOnCommand(MainForce.Produce_Force());
		return
	end
	
	MainForce.Set_Plan_Result(true)

	Sleep(20)
	MainForce.Release_Forces(1.0)
	
	ScriptExit()
end

function MainForce_Production_Failed(failed_object_type)
	ScriptExit()
end