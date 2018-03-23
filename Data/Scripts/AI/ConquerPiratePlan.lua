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

require("pgtaskforce")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 4

function Definitions()
	MinContrastScale = 1.1
	MaxContrastScale = 1.15

	Category = "Conquer_Pirate | Warlord_Conquer_Pirate"
	TaskForce = {
	-- First Task Force
	{
		"SpaceForce"				
		,"SpaceHero | Frigate | Capital | Corvette | Bomber | Fighter | Super = 100%"
	},
	{
		"GroundForce"
		,"Vehicle | Infantry | Air = 100%"
	}
	}
	RequiredCategories = { "Infantry | Vehicle", "Corvette | Frigate | Capital" }		--Must have at least one ground unit, also make sure space force is reasonable
	
	SpaceSecured = true
	LandSecured = false
	MovingGroundForceToTarget = false
	WasConflict = false
end

function SpaceForce_Thread()
	-- Since we're using plan failure to adjust contrast, we're 
	-- only concerned with failures in battle. Default the 
	-- plan to successful and then 
	-- only on the event of our task force being killed is the
	-- plan set to a failed state.
	SpaceForce.Set_Plan_Result(true)
	
	SpaceSecured = false

	if SpaceForce.Are_All_Units_On_Free_Store() == true then
		AssembleForce(SpaceForce)
	else
		BlockOnCommand(SpaceForce.Produce_Force());
		return
	end

	if SpaceForce.Get_Force_Count() == 0 then
		SpaceSecured = true
	else
		BlockOnCommand(SpaceForce.Move_To(Target))
		WasConflict = true
		if SpaceForce.Get_Force_Count() == 0 then
			SpaceForce.Set_Plan_Result(false)		
			Exit_Plan()
		end
				
		SpaceSecured = true
		
		while not LandSecured do
			Sleep(5)
		end
		
		SpaceForce.Release_Forces(1.0)
	end
end

function GroundForce_Thread()
	--Needs to be done by both taskforces - sometimes we may only create a ground force, and if we
	--declare it a failure we'll just end up with crazy contrast escalation.
	GroundForce.Set_Plan_Result(true)	
	
	if GroundForce.Are_All_Units_On_Free_Store() == true then
		AssembleForce(GroundForce)
	else
		BlockOnCommand(GroundForce.Produce_Force());
		return
	end
	
	LandUnits(GroundForce)
	
	while not SpaceSecured do
		if WasConflict then
			Exit_Plan()
		end
		Sleep(5)
	end
	
	if not LaunchUnits(GroundForce) then
		Exit_Plan()
	end
	
	MovingGroundForceToTarget = true
	BlockOnCommand(GroundForce.Move_To(Target))	
	MovingGroundForceToTarget = false
	WasConflict = true	
	if Invade(GroundForce) == false then
		GroundForce.Set_Plan_Result(false)
		Exit_Plan()
	end

	-- This plan has all but succeeded; make sure AI systems don't remove it
	GroundForce.Set_As_Goal_System_Removable(false)	
	GroundForce.Test_Target_Contrast(false)	
	
	LandSecured = true
				
	GroundForce.Release_Forces(1.0)
	
	FundBases(PlayerObject, Target)

	Exit_Plan()
end

function Exit_Plan()
	if SpaceForce then
		SpaceForce.Release_Forces(1.0)
	end
	GroundForce.Release_Forces(1.0)
	ScriptExit()
end

function SpaceForce_Production_Failed(tf, failed_object_type)
	ScriptExit()
end

function GroundForce_Production_Failed(tf, failed_object_type)
	ScriptExit()
end

function SpaceForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) then
			ScriptExit()
		end
	end
end

function GroundForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) then
			ScriptExit()
		end
	end
end

function SpaceForce_No_Units_Remaining()
	if not LandSecured then
		SpaceForce.Set_Plan_Result(false) 
		ScriptExit()
	end
end

function GroundForce_No_Units_Remaining()
	if not LandSecured then
		GroundForce.Set_Plan_Result(false) 
		ScriptExit()
	end
end