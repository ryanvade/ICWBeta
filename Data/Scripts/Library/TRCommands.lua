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
--*   @Filename:            TRCommands.lua
--*   @Last modified by:    svenmarcus
--*   @Last modified time:  2018-03-01T15:22:09+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGBase")
require("PGCommands")

GameObjectLibrary = ModContentLoader.get("GameObjectLibrary")

function TR_Register_Prox(obj, func, range, player_filter, param)
    if not ProximityCallbacks then
        ProximityCallbacks = {}
    end

    if not ProximityCallbacks[obj] then
        ProximityCallbacks[obj] = {}
    end

    table.insert(ProximityCallbacks[obj], {callback = func, param = param})
    Register_Prox(obj, DefaultCallback, range, player_filter)
end

function DefaultCallback(prox_obj, trigger_obj)
    if not ProximityCallbacks[prox_obj] then
        return
    end
    for _, callbackWrapper in pairs(ProximityCallbacks[prox_obj]) do
        callbackWrapper.callback(prox_obj, trigger_obj, callbackWrapper.param)
    end
end

function TR_Cancel_Prox(obj, func)
    if not ProximityCallbacks[obj] then
        return
    end

    for i, callbackWrapper in pairs(ProximityCallbacks[obj]) do
        if callbackWrapper.callback == func then
            table.remove(ProximityCallbacks[obj], i)
        end
    end

    if table.getn(ProximityCallbacks[obj]) == 0 then
        ProximityCallbacks[obj] = nil
        obj.Cancel_Event_Object_In_Range(func)
    end
end

function HasScriptedAbility(object, abilityName)
    if not TestValid(object) then
        return false
    end

    local objectTypeName = object.Get_Type().Get_Name()

    local libraryEntry = GameObjectLibrary.Units[objectTypeName]

    if not libraryEntry or not libraryEntry.Scripts then
        return false
    end

    for i, script in pairs(libraryEntry.Scripts) do
        if script == abilityName then
            return true
        end
    end

    return false
end

function IsAllowedToUseTurbo(object)
    return not HasScriptedAbility(object, "SingleUnitRetreat")
end

function UseTurboIfAllowed(units)
    local unitList = units
    if Is_A_Taskforce(units) then
        unitList = MainForce.Get_Unit_Table()
    elseif type(units) == "userdata" then
        unitList = {units}
    end

    if not unitList then
        return
    end

    for i, unit in pairs(unitList) do
        local isValidUnit = TestValid(unit) and unit.Has_Ability("Turbo") and unit.Is_Ability_Ready("Turbo")
        if isValidUnit and IsAllowedToUseTurbo(unit) then
            unit.Activate_Ability("Turbo", true)
        end
    end
end

-- Creates a table of faction player objects where each entry is
-- a faction that owns at least one planet in the GC.
-- In: string list of faction names e.g. CONSTANTS.ALL_FACTIONS
-- Out: FactionTable
function CreateFactionTable(factionList)
    FactionTable = {}
    for _, faction in factionList do
        CreateFactionEntry(faction)
    end

    return FactionTable
end

-- Creates an entry in  the FactionTable for factions that are present
-- In: String name of a faction
-- Out: Inserts faction into FactionTable
function CreateFactionEntry(factionString)
    if factionString == "NEUTRAL" or factionString == "HOSTILE" then
        return
    end

    local factionObject = Find_Player(factionString)
	if factionObject then
		if FactionOwnsPlanets(factionObject) then
			table.insert(FactionTable, factionObject)
		end
	end
end

-- Returns true if a faction has some kind of AI control and
-- owns at least one planet
-- In: faction playerObject
-- Out: boolean
function FactionOwnsPlanets(faction)
	local result, planetsOwned = pcall(EvaluatePerception, "Planet_Ownership", faction)
	DebugMessage("%s -- result of perception pcall is %s, %s for %s", tostring(Script), tostring(result), tostring(planetsOwned), tostring(faction.Get_Faction_Name()))
	if result then
		if planetsOwned ~= nil then
			if planetsOwned > 0 then
				return true
			end
		end
	end

    return false
end
