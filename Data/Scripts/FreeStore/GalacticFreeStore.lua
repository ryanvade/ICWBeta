-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/GalacticFreeStore.lua#3 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/GalacticFreeStore.lua $
--
--    Original Author: Brian Hayes
--
--            $Author: James_Yarrow $
--
--            $Change: 56727 $
--
--          $DateTime: 2006/10/24 14:14:26 $
--
--          $Revision: #3 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgcommands")
require("GalacticHeroFreeStore")
require("TRCommands")

function Base_Definitions()
    DebugMessage("%s -- In Base_Definitions", tostring(Script))

    -- how often does this script get serviced?
    ServiceRate = 4
    UnitServiceRate = 4

    Common_Base_Definitions()

    -- Percentage of units to move on each service.
    SpaceMovePercent = 0.1
    GroundMovePercent = 0.1

    CachedEquationEvaluator = require("trlib-util/CachedEquationEvaluator")
    Evaluator = CachedEquationEvaluator()

    if Definitions then
        Definitions()
    end
end

function main()
    DebugMessage("%s -- In main for %s", tostring(Script), tostring(FreeStore))

    if FreeStoreService then
        while 1 do
            FreeStoreService()
            PumpEvents()
        end
    end

    ScriptExit()
end

function MoveUnit(object)
    dest_target = nil
    object_type = object.Get_Type()
    if object_type.Is_Hero() then
        dest_target = Find_Custom_Target(object)
    end

    if not TestValid(dest_target) then
        if object.Is_Transport() then
            dest_target = Find_Ground_Unit_Target(object)
        else
            dest_target = Find_Space_Unit_Target(object)
        end
    end

    if dest_target then
        FreeStore.Move_Object(object, dest_target)
        return true
    else
        DebugMessage(
            "%s -- Object: %s, unable to find a suitable destination for this object.",
            tostring(Script),
            tostring(object)
        )
        return false
    end
end

function On_Unit_Service(object)
	
	if not CanRunFreeStore then
        return
    end

    -- If this unit isn't in a safe spot move him regardless of the MovedUnitsThisService
    -- Also, Heroes need to be where they most want to be asap
    if (FreeStore.Is_Unit_Safe(object) == false) or (object.Get_Type().Is_Hero()) then
        DebugMessage("%s -- Object: %s emergency move order issued", tostring(Script), tostring(object))
        MoveUnit(object)
        return
    end

    if object.Is_Transport() then
        if
            GameRandom.Get_Float() < GroundAvailablePercent and GroundUnitsMoved < GroundUnitsToMove and
                FreeStore.Is_Unit_In_Transit(object) == false
         then
            DebugMessage("%s -- Object: %s service move order issued", tostring(Script), tostring(object))
            if MoveUnit(object) then
                GroundUnitsMoved = GroundUnitsMoved + 1
            end
        end
    else
        if
            GameRandom.Get_Float() < SpaceAvailablePercent and SpaceUnitsMoved < SpaceUnitsToMove and
                FreeStore.Is_Unit_In_Transit(object) == false
         then
            DebugMessage("%s -- Object: %s service move order issued", tostring(Script), tostring(object))
            if MoveUnit(object) then
                SpaceUnitsMoved = SpaceUnitsMoved + 1
            end
        end
    end
end

--	// param 1: playerwrapper.
--	// param 2: perception function name
--	// param 3: goal application type string
--	// param 4: reachability type string
--	// param 5: The probability of selecting the target with highest desire
--	// param 6: The source from which the find target should search for relative targets.
--	// param 7: The maximum distance from source to target.
function On_Unit_Added(object)
    DebugMessage("%s -- Object: %s added to freestore", tostring(Script), tostring(object))

    obj_type = object.Get_Type()
    if obj_type.Is_Hero() then
        DebugMessage("%s -- Hero Object: %s added to freestore", tostring(Script), obj_type.Get_Name())
    end

	if not CanRunFreeStore then
        return
    end

    MoveUnit(object)
end

function FreeStoreService()
    MovedUnitsThisService = 0
    GroundUnitsMoved = 0
    GroundUnitsToMove = 0
    SpaceUnitsMoved = 0
    SpaceUnitsToMove = 0
    SpaceAvailablePercent = 0
    GroundAvailablePercent = 0

    object_count = FreeStore.Get_Object_Count()

    if Evaluator then
        Evaluator:reset()
    end

    if not FactionTable then
        ModContentLoader = require("trlib-std/ModContentLoader")
        local constants = ModContentLoader.get("GameConstants")
		if EvaluatePerception("Planet_Ownership", PlayerObject) ~= nil then
			FactionTable = CreateFactionTable(constants.ALL_FACTIONS_NOT_NEUTRAL)
		else
			FactionTable = nil
			return
		end
        FactionIndex = 0
    end

    FactionIndex = FactionIndex + 1
    if FactionIndex > table.getn(FactionTable) then
        FactionIndex = 1
    end

    CanRunFreeStore = false
    if PlayerObject == FactionTable[FactionIndex] then
        DebugMessage("%s's turn to run GalacticFreeStore", PlayerObject.Get_Faction_Name())
        CanRunFreeStore = true
    end

    ---@type table<Planet, Planet>
    OriginTargetLocationCacheGround = {}

    ---@type table<Planet, Planet>
    OriginTargetLocationCacheSpace = {}

    if object_count ~= 0 then
        -- get the count of space force in the freestore
        scnt = FreeStore.Get_Object_Count(true)
        -- get the count of ground force in the freestore
        gcnt = FreeStore.Get_Object_Count(false)

        SpaceAvailablePercent = scnt / object_count
        GroundAvailablePercent = gcnt / object_count
        SpaceUnitsToMove = SpaceMovePercent * scnt
        GroundUnitsToMove = GroundMovePercent * gcnt
        DebugMessage(
            "%s -- SpaceAvailablePercent: %f, GroundAvailablePercent: %f, SpaceUnitsToMove: %f, GroundUnitsToMove: %f, scnt: %f, gcnt: %f",
            tostring(Script),
            SpaceAvailablePercent,
            GroundAvailablePercent,
            SpaceUnitsToMove,
            GroundUnitsToMove,
            scnt,
            gcnt
        )
    end
end

function Find_Ground_Unit_Target(object)
    my_planet = object.Get_Planet_Location()

    can_move = 0

    if TestValid(my_planet) then
        can_move = Evaluator:evaluate("Is_Connected_To_Me", PlayerObject, my_planet)
    end

    if can_move == 0 then
        DebugMessage(
            "%s --  %s can't move from current planet %s",
            tostring(Script),
            tostring(object),
            tostring(my_planet)
        )
        return nil
    end
	
	if OriginTargetLocationCacheGround then
		if OriginTargetLocationCacheGround[my_planet] then
			return OriginTargetLocationCacheGround[my_planet]
		end
	end

    if FreeStore.Is_Unit_Safe(object) == false then
        DebugMessage("%s -- Object: %s Planet: %s is not safe", tostring(Script), tostring(object), tostring(my_planet))
        my_planet = nil
    end

    max_force_target = 2500
    force_target = Evaluator:evaluate("Friendly_Global_Land_Unit_Raw_Total", PlayerObject)
    if not force_target then
        return nil
    end
    force_target = force_target / 4.0
    if force_target > max_force_target then
        force_target = max_force_target
    end

    priority_planet =
        FindTarget.Reachable_Target(
        PlayerObject,
        "Ground_Priority_Defense_Score",
        "Friendly",
        "Friendly_Only",
        0.9,
        object
    )
    if priority_planet then
        priority_planet = priority_planet.Get_Game_Object()

        if priority_planet == my_planet then
            DebugMessage(
                "%s -- Object: %s, current planet %s is already priority.",
                tostring(Script),
                tostring(object),
                tostring(my_planet)
            )
            return nil
        elseif
            priority_planet.Get_Is_Planet_AI_Usable() and object.Can_Land_On_Planet(priority_planet) and
                Evaluator:evaluate("Friendly_Land_Unit_Raw_Total", PlayerObject, priority_planet) < force_target
         then
            DebugMessage(
                "%s -- Object: %s, moving to priority planet %s.",
                tostring(Script),
                tostring(object),
                tostring(priority_planet)
            )

            OriginTargetLocationCacheGround[my_planet] = priority_planet
            return priority_planet
        end
    end

    if my_planet and Evaluator:evaluate("Low_Ground_Defense_Score", PlayerObject, my_planet) > 0.5 then
        DebugMessage(
            "%s -- Object: %s, current planet %s undefended with score %s.",
            tostring(Script),
            tostring(object),
            tostring(my_planet),
            tostring(Evaluator:evaluate("Low_Ground_Defense_Score", PlayerObject, my_planet))
        )
        return nil
    end

    poorly_defended_planet =
        FindTarget.Reachable_Target(PlayerObject, "Low_Ground_Defense_Score", "Friendly", "Friendly_Only", 1.0, object)
    if poorly_defended_planet then
        poorly_defended_planet = poorly_defended_planet.Get_Game_Object()

        if poorly_defended_planet.Get_Is_Planet_AI_Usable() and object.Can_Land_On_Planet(poorly_defended_planet) then
            DebugMessage(
                "%s -- Object: %s, moving to undefended planet %s.",
                tostring(Script),
                tostring(object),
                tostring(poorly_defended_planet)
            )
            OriginTargetLocationCacheGround[my_planet] = priority_planet
            return poorly_defended_planet
        end
    end

    fallback_planet =
        FindTarget.Reachable_Target(PlayerObject, "Can_Park_Ground_Unit", "Friendly", "Friendly_Only", 1.0, object)
    if fallback_planet then
        fallback_planet = fallback_planet.Get_Game_Object()

        if fallback_planet.Get_Is_Planet_AI_Usable() and object.Can_Land_On_Planet(fallback_planet) then
            DebugMessage(
                "%s -- Object: %s, moving to fallback planet %s.",
                tostring(Script),
                tostring(object),
                tostring(fallback_planet)
            )
            OriginTargetLocationCacheGround[my_planet] = priority_planet
            return fallback_planet
        end
    else
        fallback_planet = FindTarget.Reachable_Target(PlayerObject, "One", "Friendly", "Friendly_Only", 1.0, object)
        if fallback_planet then
            DebugMessage(
                "%s -- Object: %s, moving to final friendly fallback planet %s.",
                tostring(Script),
                tostring(object),
                tostring(fallback_planet.Get_Game_Object())
            )
            OriginTargetLocationCacheGround[my_planet] = priority_planet
            return fallback_planet.Get_Game_Object()
        end
    end

    return nil
end

function Find_Space_Unit_Target(object)
    my_planet = object.Get_Planet_Location()

    if not my_planet then
        return nil
    end

    can_move = Evaluator:evaluate("Is_Connected_To_Me", PlayerObject, my_planet)

    if can_move == 0 then
        DebugMessage(
            "%s --  %s can't move from current planet %s",
            tostring(Script),
            tostring(object),
            tostring(my_planet)
        )
        return nil
    end
	
	if OriginTargetLocationCacheSpace then
		if OriginTargetLocationCacheSpace[my_planet] then
			return OriginTargetLocationCacheSpace[my_planet]
		end
	end

    max_force_target = 8000
    force_target = Evaluator:evaluate("Friendly_Global_Space_Unit_Raw_Total", PlayerObject)
    if not force_target then
        return nil
    end
    force_target = force_target / 4.0
    if force_target > max_force_target then
        force_target = max_force_target
    end

    priority_planet =
        FindTarget.Reachable_Target(
        PlayerObject,
        "Space_Priority_Defense_Score",
        "Friendly",
        "Friendly_Only",
        0.9,
        object
    )
    if priority_planet then
        priority_planet = priority_planet.Get_Game_Object()

        if priority_planet.Get_Is_Planet_AI_Usable() then
            if Evaluator:evaluate("Is_Connected_To_Enemy", PlayerObject, priority_planet) ~= nil then
                force_target = force_target * 1.5
            end

            if
                priority_planet == my_planet and
                    Evaluator:evaluate("Friendly_Space_Unit_Raw_Total", PlayerObject, priority_planet) < force_target
             then
                DebugMessage(
                    "%s --  %s already on priority planet %s",
                    tostring(Script),
                    tostring(object),
                    tostring(priority_planet)
                )

                OriginTargetLocationCacheSpace[my_planet] = priority_planet
                return priority_planet
            elseif
                Evaluator:evaluate("Friendly_Space_Unit_Raw_Total", PlayerObject, priority_planet) < force_target and
                    Evaluator:evaluate("Enemy_Present", PlayerObject, priority_planet) == 0.0
             then
                DebugMessage(
                    "%s --  %s moving to priority planet %s",
                    tostring(Script),
                    tostring(object),
                    tostring(priority_planet)
                )

                OriginTargetLocationCacheSpace[my_planet] = priority_planet
                return priority_planet
            end
        end
    end

    if my_planet and Evaluator:evaluate("Low_Space_Defense_Score", PlayerObject, my_planet) > 0.5 then
        DebugMessage("%s -- Object: %s, current planet undefended.", tostring(Script), tostring(object))
        return nil
    end

    poorly_defended_planet =
        FindTarget.Reachable_Target(PlayerObject, "Low_Space_Defense_Score", "Friendly", "Friendly_Only", 1.0, object)
    if poorly_defended_planet then
        poorly_defended_planet = poorly_defended_planet.Get_Game_Object()

        if
            poorly_defended_planet.Get_Is_Planet_AI_Usable() and
                Evaluator:evaluate("Friendly_Space_Unit_Raw_Total", PlayerObject, poorly_defended_planet) < force_target and
                Evaluator:evaluate("Enemy_Present", PlayerObject, poorly_defended_planet) == 0.0
         then
            DebugMessage(
                "%s -- Object: %s, moving to undefended planet %s.",
                tostring(Script),
                tostring(object),
                tostring(poorly_defended_planet)
            )

            OriginTargetLocationCacheSpace[my_planet] = poorly_defended_planet
            return poorly_defended_planet
        end
    end

    return nil
end
