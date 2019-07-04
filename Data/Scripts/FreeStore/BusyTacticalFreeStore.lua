-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/BusyTacticalFreeStore.lua#12 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/BusyTacticalFreeStore.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 55010 $
--
--          $DateTime: 2006/09/19 19:14:06 $
--
--          $Revision: #12 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgcommands")
require("TRTacticalFreeStore")

function Base_Definitions()

    Common_Base_Definitions()

    ServiceRate = 10
    UnitServiceRate = 2

    if Definitions then
        Definitions()
    end

    FREE_STORE_ATTACK_RANGE = 4000.0
	
	aggressive_mode = false
	outnumbered = 0
end

function main()

    if FreeStoreService then
        while 1 do
            FreeStoreService()
            PumpEvents()
        end
    end

    ScriptExit()
end

function On_Unit_Added(object)
end


function FreeStoreService()
    enemy_location = FindTarget.Reachable_Target(PlayerObject, "Current_Enemy_Location", "Tactical_Location", "Any_Threat", 0.5)
    friendly_location = FindTarget.Reachable_Target(PlayerObject, "Current_Friendly_Location", "Tactical_Location", "Any_Threat", 0.5)

	outnumbered = EvaluatePerception("Outnumbered", PlayerObject)

	if (EvaluatePerception("Allowed_As_Defender_Space_Untargeted", PlayerObject) > 0.0) then
		DebugMessage("%s -- Aggressive mode activated", tostring(Script))
		aggressive_mode = true
	else
		aggressive_mode = false
	end
	
	if TestValid(space_station) then
		station_threat = FindDeadlyEnemy(space_station)
		if station_threat then
			space_station.Attack_Target(station_threat)
		end
	else
		space_station = PlayerObject.Get_Space_Station()
	end
end

function On_Unit_Service(object)

    if not TestValid(object) then
        return
    end

    if object.Is_Category("SpaceStructure") or object.Is_Category("Transport") then
        return
    end

    if TR_On_Unit_Service(object) then
        return
    end

    current_target = object.Get_Attack_Target()
    if TestValid(current_target) then

		if object.Is_Category("Fighter") or object.Is_Category("Bomber") or object.Is_Category("Transport") or object.Is_Category("Corvette") or object.Is_Category("Frigate") then
			if Service_Kite(object) then
				return
			end
		end

        object.Activate_Ability("SPOILER_LOCK", false)
    end
	
	-- Are we completely outnumbered?
	if (outnumbered > 0) and TestValid(space_station) then	
		object.Move_To(space_station.Get_Position())
		
		Service_Attack(object)
		return
	end

    if not object.Has_Active_Orders() then

        --Keep bored objects mobile
        object.Activate_Ability("SPOILER_LOCK", true)
		
		--Small units kite, or guard
		if object.Is_Category("Fighter") or object.Is_Category("Bomber") or object.Is_Category("Transport") or object.Is_Category("Corvette") then
			
			if Service_Kite(object) then
				return
			end

			Service_Guard(object)
				
		end

        if Service_Attack(object) then
            return
        end

        Service_Guard(object)

    end
end

function Service_Attack(object)

	closest_enemy = Find_Nearest(object, "Corvette|Frigate|Capital|SuperCapital|SpaceStructure", object.Get_Owner(), false)
	if TestValid(closest_enemy) then
		DebugMessage("%s -- closest enemy is %s units away", tostring(Script), tostring(object.Get_Distance(closest_enemy)))
	end
	
	deadly_enemy = FindDeadlyEnemy(object)
	
	if TestValid(closest_enemy) then
		if object.Get_Distance(closest_enemy) < FREE_STORE_ATTACK_RANGE then
			if object.Get_Distance(closest_enemy) > object.Get_Type().Get_Max_Range() then
				object.Attack_Target(closest_enemy)
			else
				object.Attack_Move(Project_By_Unit_Range(object, closest_enemy.Get_Position()))
			end
			return true		
		elseif aggressive_mode then
			if object.Get_Distance(closest_enemy) > object.Get_Type().Get_Max_Range() then
				object.Attack_Target(closest_enemy)
			else
				object.Attack_Move(Project_By_Unit_Range(object, closest_enemy.Get_Position()))
			end
			return true
		end
	elseif TestValid(deadly_enemy) then
		DebugMessage("%s -- attacking enemy attacker", tostring(Script))
		if object.Get_Distance(deadly_enemy) > object.Get_Type().Get_Max_Range() then
			object.Attack_Move(Project_By_Unit_Range(object, deadly_enemy.Get_Position()))
		else
			object.Attack_Target(deadly_enemy)
		end
		return true
	elseif TestValid(enemy_location) then
		if aggressive_mode or object.Is_Category("SuperCapital") then
			object.Attack_Move(Project_By_Unit_Range(object, enemy_location))
			return true
		end
	end			

    return false
end

function Service_Guard(object)

	if object.Is_Category("SuperCapital") then
		return false
	end

    friendly_structures = Find_All_Objects_Of_Type("SpaceStructure", object.Get_Owner())
	
	if object.Has_Property("Carrier") then
	
		if TestValid(friendly_location) then
			object.Attack_Move(friendly_location)
			return true	
		elseif friendly_structures then
			for i,structure in pairs(friendly_structures) do
				object.Attack_Move(structure.Get_Position())
			end
			return true
		elseif aggressive_mode and TestValid(enemy_location) then
			object.Move_To(Project_By_Unit_Range(object, enemy_location))
			return true
		end
		
	elseif object.Is_Category("Frigate") or object.Is_Category("Capital") or object.Is_Category("SuperCapital") then
		return false
	end
	
	if TestValid(friendly_location) then
		object.Attack_Move(friendly_location)
		return true	
	elseif friendly_structures then
		for i,structure in pairs(friendly_structures) do
			object.Attack_Move(structure.Get_Position())
		end
		return true
	elseif aggressive_mode and TestValid(enemy_location) then
		object.Move_To(Project_By_Unit_Range(object, enemy_location))
		return true
	end

    return false
end

function Service_Kite(object)

    lib_fs_deadly_enemy = FindDeadlyEnemy(object)

    if TestValid(lib_fs_deadly_enemy) then

        if lib_fs_deadly_enemy.Is_Good_Against(object) then

            if Try_Ability(object, "BUZZ_DROIDS", object) then
                return true
            end
			
            Try_Ability(object, "SPOILER_LOCK")
            Try_Ability(object, "STEALTH")

            lib_fs_kite_pos = Project_By_Unit_Range(lib_fs_deadly_enemy, object)

            object.Move_To(lib_fs_kite_pos)

            return true
        end

    end

    return false
end
