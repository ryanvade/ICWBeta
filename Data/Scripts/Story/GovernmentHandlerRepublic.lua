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
--*   @Author:              Corey
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCWarlordsCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-03-13T22:28:32-04:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
require("PGStoryMode")
require("PGSpawnUnits")
require("trlib-util/ChangeOwnerUtilities")
StoryUtil = require("trlib-util/StoryUtil")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))

    StoryModeEvents = {
        Support_Palpatine = Palpatine_Support,
        Lira_Contract = Palpatine_Support,
        KDY_Deal_AI = Spawn_KDY_AI,
        Government_Start = IsPlayer,
        Rebels_Enter_Tech_03 = Increase_Support,
        Rebels_Enter_Tech_04 = Increase_Support,
        Buy_LoveMeRepublic = Increase_Support,
        Support_Mothma = Mothma_Support,
        Exit_Function = Safeguard,
        Support_Mothma = Mothma_Support,
        Republic_Enter_Tech_03 = Absorb_Sectors,
        Republic_Enter_Tech_04 = Absorb_Sectors,
        Republic_Enter_Tech_05 = Absorb_Sectors
    }
end

function Increase_Support(message)
    if message == OnEnter then
        currentSupport = GlobalValue.Get("RepublicApprovalRating")
        GlobalValue.Set("RepublicApprovalRating", currentSupport + 5)
    end
end

function Absorb_Sectors()

    republic_player = Find_Player("Empire")
    if republic_player.Is_Human() then
        Story_Event("SECTOR_FORCE_ABSORBED_SPEECH")
    end

    for _, planet in pairs(FindPlanet.Get_All_Planets()) do
        if planet.Get_Owner() == Find_Player("Corporate_Sector") then      
	    	ChangePlanetOwnerAndReplace(planet, republic_player)
		end
    end
end


function IsPlayer(message)
    if message == OnEnter then
        republic_player = Find_Player("Empire")
        if republic_player.Is_Human() then
            Story_Event("ACTIVE_PLAYER")
        end
    end
end

function Safeguard(message)
    if message == OnEnter then

    end
end

function Palpatine_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_EMPEROR_PALPATINE")
    end
end

function Mothma_Support(message)
    if message == OnEnter then
        GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_MOTHMA")
    end
end

function Spawn_KDY_AI(message)
    if message == OnEnter then

        spawn_location_table = {
            ["KUAT"] = false
        }

        all_planets = FindPlanet.Get_All_Planets()

        Set_Existing_Planets(all_planets, spawn_location_table)
        local KDY_OBJECT = {"DUMMY_KUAT_CONTRACT", "Generic_Star_Destroyer"}
        local p_republic = Find_Player("Empire")
        if spawn_location_table["KUAT"] then
            local start_planet = FindPlanet("Kuat")
            if start_planet.Get_Owner() == Find_Player("Empire") then
                local KDYspawn = SpawnList(KDY_OBJECT, start_planet, p_republic, true, false)
            end
        end    
    end
end

function Set_Existing_Planets(planet_list, planet_table)

    for _, planet in pairs(planet_list) do

        name = planet.Get_Type().Get_Name()
        
        if planet_table[name] ~= nil then
            planet_table[name] = true
        end
    end
end