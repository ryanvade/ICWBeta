-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/UpgradeStarbasePlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/UpgradeStarbasePlan.lua $
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

require("pgevents")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 16

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Upgrade_Starbase | Build_Initial_Starbase_Only"
	IgnoreTarget = true
	TaskForce = {
	{
		"BaseForce",
		"NR_STAR_BASE_1 | NR_STAR_BASE_2 | NR_STAR_BASE_3 | REMNANT_STAR_BASE_1 | REMNANT_STAR_BASE_2 | REMNANT_STAR_BASE_3 | EOTH_STAR_BASE_1 | EOTH_STAR_BASE_2 | EOTH_STAR_BASE_3 | ZSINJ_STAR_BASE_1 | ZSINJ_STAR_BASE_2 | ZSINJ_STAR_BASE_3 | HAPAN_STAR_BASE_1 | HAPAN_STAR_BASE_2 | PENTASTAR_STAR_BASE_1 | PENTASTAR_STAR_BASE_2 | PENTASTAR_STAR_BASE_3 | TERADOC_STAR_BASE_1 | TERADOC_STAR_BASE_2 | TERADOC_STAR_BASE_3 | DELVARDUS_STAR_BASE_1 | DELVARDUS_STAR_BASE_2 | DELVARDUS_STAR_BASE_3 | CSA_STAR_BASE_1 | CSA_STAR_BASE_2 | CSA_STAR_BASE_3 | Y_STAR_BASE_1 | Y_STAR_BASE_2 | Y_STAR_BASE_3 = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function BaseForce_Thread()
	DebugMessage("%s -- In BaseForce_Thread.", tostring(Script))
	
	BaseForce.Set_As_Goal_System_Removable(false)
	AssembleForce(BaseForce)
	
	BaseForce.Set_Plan_Result(true)
	DebugMessage("%s -- BaseForce done!", tostring(Script));
	ScriptExit()
end

function BaseForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end