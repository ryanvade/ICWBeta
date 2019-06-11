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

    ServiceRate = 20
    UnitServiceRate = 2

    if Definitions then
        Definitions()
    end

    FREE_STORE_ATTACK_RANGE = 2000.0
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
    aggressive_mode = (EvaluatePerception("Allowed_As_Defender_Land", PlayerObject) > 0.0)

	if TestValid(space_station) then
		station_threat = FindDeadlyEnemy(space_station)
		if station_threat then
			space_station.Attack_Target(station_threat)
		end

		--Maybe this station has a special weapon?
		special_target = FindTarget.Reachable_Target(PlayerObject, "Needs_Hypervelocity_Shot", "Enemy_Unit", "Any_Threat", 0.5, space_station, 1500.0)
		if TestValid(special_target) then
			space_station.Fire_Special_Weapon(special_target, PlayerObject)
		end
	else
		space_station = PlayerObject.Get_Space_Station()
	end
end

function On_Unit_Service(object)

    if not TestValid(object) then
        return
    end

    if object.Is_Category("Structure") or object.Is_Category("Transport") then
        return
    end

    if TR_On_Unit_Service(object) then
        return
    end

    current_target = object.Get_Attack_Target()
    if TestValid(current_target) then

        if Service_Kite(object) then
            return
        end

        object.Activate_Ability("SPOILER_LOCK", false)

        Try_Weapon_Switch(object, current_target)
    end

    if not object.Has_Active_Orders() then

        --Keep bored objects mobile
        object.Activate_Ability("SPOILER_LOCK", true)

        if Service_Kite(object) then
            return
        end

        if Service_Attack(object) then
            return
        end

        Service_Guard(object)

    end
end

function Service_Attack(object)

    closest_enemy = Find_Nearest(object, object.Get_Owner(), false)
	--damaged_enemy = FindTarget.Reachable_Target(PlayerObject, "Low_Health_Unit", "Enemy_Unit", "Any_Threat", 0.9, object, 0.75 * object.Get_Type().Get_Max_Range())

	--if TestValid(damaged_enemy) then
		--object.Attack_Target(damaged_enemy)
		--return true
	--end
	
	if TestValid(closest_enemy) then
		if object.Get_Distance(closest_enemy) < FREE_STORE_ATTACK_RANGE then
			if object.Get_Distance(closest_enemy) > object.Get_Type().Get_Max_Range() then
				object.Attack_Target(closest_enemy)
			else
				object.Attack_Move(Project_By_Unit_Range(object, closest_enemy.Get_Position()))
			end
			return true		
		elseif aggressive_mode then
			object.Attack_Move(Project_By_Unit_Range(object, closest_enemy.Get_Position()))
			return true
		end
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

    closest_friendly_structure = Find_Nearest(object, "Structure", object.Get_Owner(), true)
    if TestValid(closest_friendly_structure) then
        object.Guard_Target(closest_friendly_structure)
        return true
    elseif TestValid(friendly_location) then
        object.Attack_Move(friendly_location)
        return true
	end
	
    if Get_Game_Mode() == "Space" then
		space_station = object.Get_Owner().Get_Space_Station()
		if TestValid(space_station) then
			object.Guard_Target(space_station)
			return true
		end
    end

    return false
end

function Service_Kite(object)

	if object.Is_Category("SuperCapital") then
		return false
	end

    if object.Get_Hull() > 0.5 or not object.Are_Engines_Online() or object.Get_Hull() < 0.1 then
        return false
    end

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
