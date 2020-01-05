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
        Determine_Faction_LUA = Find_Faction,
        Level_Check = Determine_Start_Era
    }
end

function Find_Faction(message)
    if message == OnEnter then


        spawn_location_table = {
            ["CORUSCANT"] = false
            ,["GEONOSIS"] = false
            ,["KAMINO"] = false
            ,["CARIDA"] = false
            ,["RENDILI"] = false
            ,["ERIADU"] = false
            ,["KUAT"] = false
            ,["MUUNILINST"] = false
            ,["CATO_NEIMOIDIA"] = false
            ,["CHRISTOPHSIS"] = false
            ,["QUELL"] = false
            }


        all_planets = FindPlanet.Get_All_Planets()

        Set_Existing_Planets(all_planets, spawn_location_table)


        local p_cis = Find_Player("Rebel")
        local p_republic = Find_Player("Empire")

        if p_republic.Is_Human() then
            Story_Event("ENABLE_BRANCH_GAR_FLAG")
        elseif p_cis.Is_Human() then
            Story_Event("ENABLE_BRANCH_CIS_FLAG")
        end


        techLevel = p_republic.Get_Tech_Level()

        if techLevel == 2 then
            Story_Event("START_LEVEL_02")
        elseif techLevel == 3 then
            Story_Event("START_LEVEL_03")
        elseif techLevel == 4 then
            Story_Event("START_LEVEL_04")
        elseif techLevel == 5 then
            Story_Event("START_LEVEL_05")
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


function Determine_Start_Era(message)
    if message == OnEnter then
  
      p_cis = Find_Player("Rebel")
      p_republic = Find_Player("Empire")
      p_eoth = Find_Player("Underworld")
      p_technounion = Find_Player("Hutts")
      p_igbc = Find_Player("Pentastar")
      p_tradefederation = Find_Player("Pirates")
      p_corporate = Find_Player("Teradoc")
      
      techLevel = p_republic.Get_Tech_Level()
      
		if techLevel <= 2 then
           -- Republic
			if spawn_location_table["CORUSCANT"] then
				start_planet = FindPlanet("Coruscant")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Yoda_Team", "Mace_Windu_Team" , "Anakin_Team" , "Obi_Wan_Team", "Shaak_Ti_Team", "Aayla_Secura_Team", "Plo_Koon_Team", "Kit_Fisto_Team"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
			end

			if spawn_location_table["KAMINO"] then
				start_planet = FindPlanet("Kamino")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Delta_Squad"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
            end
       
            if spawn_location_table["CARIDA"] then
                  start_planet = FindPlanet("Carida")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Pellaeon_Leveler"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

            if spawn_location_table["RENDILI"] then
                 start_planet = FindPlanet("Rendili")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Dallin_Kebir"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

            -- CIS
            if spawn_location_table["GEONOSIS"] then
                start_planet = FindPlanet("Geonosis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Grievous_Team", "Sora_Bulq_Team", "Dooku_Team", "Ventress_Team", "SevRance_Team" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["QUELL"] then
                start_planet = FindPlanet("Quell")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "TF1726_Munificent" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["CHRISTOPHSIS"] then
                start_planet = FindPlanet("Christophsis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Whorm_Team", "Trench_Invincible" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end
    
            if spawn_location_table["CATO_NEIMOIDIA"] then
                start_planet = FindPlanet("Cato_Neimoidia")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Gunray_Team" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end  
      
        elseif techLevel == 3 then
          
            -- Republic
			if spawn_location_table["CORUSCANT"] then
				start_planet = FindPlanet("Coruscant")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Yoda_Team", "Mace_Windu_Team" , "Anakin_Team" , "Obi_Wan_Team", "Shaak_Ti_Team", "Aayla_Secura_Team", "Plo_Koon_Team", "Kit_Fisto_Team"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
			end

			if spawn_location_table["KAMINO"] then
				start_planet = FindPlanet("Kamino")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Delta_Squad"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
            end
       
            if spawn_location_table["CARIDA"] then
                  start_planet = FindPlanet("Carida")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Pellaeon_Leveler"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

            if spawn_location_table["RENDILI"] then
                 start_planet = FindPlanet("Rendili")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Dallin_Kebir"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end
      
            if spawn_location_table["ERIADU"] then
                start_planet = FindPlanet("Eriadu")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Tarkin_Venator"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end
      
            if spawn_location_table["KUAT"] then
                start_planet = FindPlanet("Kuat")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Yularen_Resolute", "Coburn_Triumphant" , "Wieler_Resilient" }
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

            -- CIS
            if spawn_location_table["GEONOSIS"] then
                start_planet = FindPlanet("Geonosis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                 end
                if start_planet then
                    spawn_list = { "Grievous_Team", "Sora_Bulq_Team", "Dooku_Team", "Ventress_Team", "SevRance_Team" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["QUELL"] then
                start_planet = FindPlanet("Quell")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "TF1726_Munificent" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["CHRISTOPHSIS"] then
                start_planet = FindPlanet("Christophsis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Whorm_Team", "Trench_Invincible" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["Muunilinst"] then
                start_planet = FindPlanet("Muunilinst")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Tonith_Corpulentus", "Canteval_Munificent" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end  

            if spawn_location_table["CATO_NEIMOIDIA"] then
                start_planet = FindPlanet("Cato_Neimoidia")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Gunray_Team", "Durd_Team", "Tuuk_Procurer" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end  
 
        elseif techLevel >= 4 then
           
             -- Republic
            if spawn_location_table["CORUSCANT"] then
				start_planet = FindPlanet("Coruscant")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Yoda_Team", "Mace_Windu_Team" , "Anakin_Team" , "Obi_Wan_Team", "Shaak_Ti_Team", "Aayla_Secura_Team", "Plo_Koon_Team", "Kit_Fisto_Team"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
			end

			if spawn_location_table["KAMINO"] then
				start_planet = FindPlanet("Kamino")
				if start_planet.Get_Owner() ~= Find_Player("Empire") then
					start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
				end
				if start_planet then
					spawn_list = { "Delta_Squad"}
					SpawnList(spawn_list, start_planet, p_republic, true, false)
				end
            end
       
            if spawn_location_table["CARIDA"] then
                  start_planet = FindPlanet("Carida")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Pellaeon_Leveler"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

            if spawn_location_table["RENDILI"] then
                 start_planet = FindPlanet("Rendili")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Dallin_Kebir"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end
      
            if spawn_location_table["ERIADU"] then
                start_planet = FindPlanet("Eriadu")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Tarkin_Venator"}
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end
      
            if spawn_location_table["KUAT"] then
                start_planet = FindPlanet("Kuat")
                if start_planet.Get_Owner() ~= Find_Player("Empire") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_republic)
                end
                if start_planet then
                    spawn_list = { "Yularen_Resolute", "Coburn_Triumphant" , "Wieler_Resilient" }
                    SpawnList(spawn_list, start_planet, p_republic, true, false)
                end
            end

           -- CIS
           if spawn_location_table["GEONOSIS"] then
                start_planet = FindPlanet("Geonosis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Grievous_Team", "Sora_Bulq_Team", "Dooku_Team", "Ventress_Team", "SevRance_Team" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
                end

            if spawn_location_table["QUELL"] then
                start_planet = FindPlanet("Quell")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "TF1726_Munificent" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["CHRISTOPHSIS"] then
                start_planet = FindPlanet("Christophsis")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Whorm_Team", "Trench_Invincible"  }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end

            if spawn_location_table["Muunilinst"] then
                start_planet = FindPlanet("Muunilinst")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Tonith_Corpulentus", "Canteval_Munificent" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end  

            if spawn_location_table["CATO_NEIMOIDIA"] then
                start_planet = FindPlanet("Cato_Neimoidia")
                if start_planet.Get_Owner() ~= Find_Player("Rebel") then
                    start_planet = StoryUtil.FindFriendlyPlanet(p_cis)
                end
                if start_planet then
                    spawn_list = { "Gunray_Team", "Durd_Team", "Tuuk_Procurer" }
                    SpawnList(spawn_list, start_planet, p_cis, true, false)
                end
            end  
        end

      placeholder_table = Find_All_Objects_Of_Type("Placement_Dummy")
      for i,unit in pairs(placeholder_table) do
          unit.Despawn()
      end
      
  
    end
end