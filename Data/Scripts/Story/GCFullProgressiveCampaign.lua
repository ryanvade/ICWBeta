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

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction,
    Level_Check = Determine_Start_Era,
    Maldrood_Antem = Antem_Maldrood,
    Maldrood_Kashyyyk = Kashyyyk_Maldrood,
    Maldrood_Commenor = Commenor_Maldrood,
    Eriadu_Elrood = Elrood_Eriadu,
	Zsinj_Centares = Centares_Zsinj,
    Set_Subera_Isard = SubEra_Change,
	Zero_Command_Split = Spawn_Harrsk,
	E_Level_Two = ThrawnSpawns,
    E_Level_Three = DarkEmpireSpawns,
    E_Level_Four = DaalaSpawns,
    Set_Subera_Jax = Empire_Fractures,
	E_Level_Five = PellaeonSpawns,
	Trigger_Council_Thrawn_Death = Ciutric_Breakaway,
	Vassal_Release_Hapes = HapesVassalEmerge,
	NewRep_Evac_Trigger = Check_Coruscant_Owner,
	Empire_wins_Coruscant = Spawn_Empire_Reward
  }

end

function Find_Faction(message)
  if message == OnEnter then
  
			spawn_location_table = {
                        ["ANTEM"] = false
                        ,["BASTION"] = false
                        ,["BYSS"] = false
                        ,["CARIDA"] = false
                        ,["CENTARES"] = false
                        ,["CENTARES"] = false
                        ,["CIUTRIC"] = false
                        ,["COMMENOR"] = false
                        ,["CORUSCANT"] = false
                        ,["CORVIS"] = false
                        ,["DATHOMIR"] = false
                        ,["DA_SOOCHAV"] = false
                        ,["ELROOD"] = false
                        ,["ENTRALLA"] = false
                        ,["EOLSHA"] = false
                        ,["ERIADU"] = false
                        ,["GAROS_IV"] = false
                        ,["HAKASSI"] = false
                        ,["KALIST"] = false
                        ,["KAMPE"] = false
                        ,["KASHYYYK"] = false
                        ,["KESSEL"] = false
                        ,["MONCALIMARI"] = false
                        ,["MYRKR"] = false
                        ,["NIRAUAN"] = false
                        ,["THE_MAW"] = false
                        ,["VROS"] = false
                        ,["YAVIN"] = false
                        ,["ABREGADO_RAE"] = false
                        }


	all_planets = FindPlanet.Get_All_Planets()
	
	Set_Existing_Planets(all_planets, spawn_location_table)
	
      
	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Hutts")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Pirates")
	p_maldrood = Find_Player("Teradoc")
	p_corporate = Find_Player("Corporate_Sector")
	p_hapes = Find_Player("Hapes_Consortium")

	if p_newrep.Is_Human() then
		Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
	elseif p_empire.Is_Human() then
		Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
	elseif p_eoth.Is_Human() then
		Story_Event("ENABLE_BRANCH_EOTH_FLAG")
	elseif p_eriadu.Is_Human() then
		Story_Event("ENABLE_BRANCH_ERIADU_FLAG")
	elseif p_pentastar.Is_Human() then
		Story_Event("ENABLE_BRANCH_PENTASTAR_FLAG")
	elseif p_zsinj.Is_Human() then
		Story_Event("ENABLE_BRANCH_ZSINJ_FLAG")
	elseif p_maldrood.Is_Human() then
		Story_Event("ENABLE_BRANCH_TERADOC_FLAG")
	elseif p_corporate.Is_Human() then
		Story_Event("ENABLE_BRANCH_CORPORATE_SECTOR_FLAG")
	elseif p_hapes.Is_Human() then
		Story_Event("ENABLE_BRANCH_HAPES_FLAG")
	end

	techLevel = p_empire.Get_Tech_Level()

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

	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
	p_eriadu = Find_Player("Hutts")
	p_pentastar = Find_Player("Pentastar")
	p_zsinj = Find_Player("Pirates")
	p_maldrood = Find_Player("Teradoc")
	p_corporate = Find_Player("Corporate_Sector")
	
	techLevel = p_empire.Get_Tech_Level()
	
	if techLevel == 1 then
		-- Teradoc
		if spawn_location_table["CENTARES"] then
			start_planet = FindPlanet("Centares")
			if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if start_planet then
				spawn_list_teradoc = { "Neomen_Ion_Storm" , "13x_Teradoc", "Therbon_Allegiance" }
				SpawnList(spawn_list_teradoc, start_planet, p_maldrood, true, false)
			end	
		end 

		if spawn_location_table["HAKASSI"] then
			start_planet = FindPlanet("Hakassi")
			if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if start_planet then
				spawn_list_teradoc = { "Lancet_Kosh" }
				SpawnList(spawn_list_teradoc, start_planet, p_maldrood, true, false)
			end
		end
		
		-- Zsinj
		if spawn_location_table["DATHOMIR"] then
			start_planet = FindPlanet("Dathomir")
			if start_planet.Get_Owner() ~= Find_Player("Pirates") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_zsinj)
			end
			if start_planet then
				spawn_list_zsinj = { "Night_Caller", "Iron_Fist" , "Banjeer", "Netbers_Team", "Lanu_Team", "Gethzerion_Team", "Implacable_Star_Destroyer" }
				SpawnList(spawn_list_zsinj, start_planet, p_zsinj, true, false)
			end
		end
		
		if spawn_location_table["GAROS_IV"] then
			start_planet = FindPlanet("Garos_IV")
			if start_planet.Get_Owner() ~= Find_Player("Pirates") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_zsinj)
			end
			if start_planet then
				spawn_list_zsinj = { "Demolisher" }
				SpawnList(spawn_list_zsinj, start_planet, p_zsinj, true, false)
			end
		end
		
		-- Pentastar
		if spawn_location_table["ENTRALLA"] then
			start_planet = FindPlanet("Entralla")
			if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_pentastar)
			end
			if start_planet then
				spawn_list_zsinj = { "Grant_Oriflamme", "Sariss_Team" , "Jerec_Team" }
				SpawnList(spawn_list_zsinj, start_planet, p_pentastar, true, false)
			end
		end
		
		-- Eriadu
		if spawn_location_table["ERIADU"] then
			start_planet = FindPlanet("Eriadu")
			if start_planet.Get_Owner() ~= Find_Player("Hutts") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
			end
			if start_planet then
				spawn_list_delvardus = { "General_Veers_Team", "Thalassa" , "Kabalian_Star_Destroyer" }
				SpawnList(spawn_list_delvardus, start_planet, p_eriadu, true, false)
			end
		end

		-- CSA : Re-enable after planet checks
		-- start_planet = FindPlanet("Ession")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Krin_Invincible" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
		
		-- start_planet = FindPlanet("Etti_IV")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Grumby_Notropis", "Sloane_Enforce", "Fiolla_Team", "Odumin_Team", "Karrek_Flim_Team", "Fasser_Team", "Nieler_Team" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end

	elseif techLevel == 2 then
		-- Empire
		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Empire") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
			end
			if start_planet then
				spawn_list_thrawn = { "Chimera" , "Corellian_Gunboat_Ferrier" }
				SpawnList(spawn_list_thrawn, start_planet, p_empire, true, false)
			end
		end

		if spawn_location_table["CORUSCANT"] then		
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Empire") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
			end
			if start_planet then
				spawn_list_Thrawn = { "181st_TIE_Interceptor_Squadron", "General_Covell_Team", "Judicator_Star_Destroyer", "Relentless_Star_Destroyer", "Joruus_Cboath_Team" }
				SpawnList(spawn_list_Thrawn, start_planet, p_empire, true, false)
			end
		end
		
		-- New Republic
		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Iblis_Peregrine" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end
		
		if spawn_location_table["MYRKR"] then		
			start_planet = FindPlanet("Myrkr")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Errant_Venture", "Mara_Saber_Team", "Wild_karrde" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end
		
		-- Hand
		if spawn_location_table["NIRAUAN"] then		
			start_planet = FindPlanet("Nirauan")
			if start_planet.Get_Owner() ~= Find_Player("Underworld") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
			end
			if start_planet then
				spawn_list_Hand = { "Soontir_Fel_Squadron" }
				SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
			end
		end
		
		-- Teradoc
		if spawn_location_table["HAKASSI"] then		
			start_planet = FindPlanet("Hakassi")
			if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if start_planet then
				spawn_list_teradoc = { "Lancet_Kosh", "13x_Teradoc" }
				SpawnList(spawn_list_teradoc, start_planet, p_maldrood, true, false)
			end
		end
		
		-- Pentastar
		if spawn_location_table["ENTRALLA"] then		
			start_planet = FindPlanet("Entralla")
			if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_pentastar)
			end
			if start_planet then
				spawn_list_zsinj = { "Grant_Oriflamme", "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
				SpawnList(spawn_list_zsinj, start_planet, p_pentastar, true, false)
			end
		end
		
		-- Eriadu
		if spawn_location_table["KAMPE"] then		
			start_planet = FindPlanet("Kampe")
			if start_planet.Get_Owner() ~= Find_Player("Hutts") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
			end
			if start_planet then
				spawn_list_delvardus = { "Night_Hammer_Delvardus" }
				SpawnList(spawn_list_delvardus, start_planet, p_eriadu, true, false)
			end
		end

		-- CSA : Re-enable after planet checks
		-- start_planet = FindPlanet("Ession")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Krin_Invincible" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
		
		-- start_planet = FindPlanet("Etti_IV")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Grumby_Notropis", "Sloane_Enforce", "Fiolla_Team", "Odumin_Team", "Karrek_Flim_Team", "Fasser_Team", "Nieler_Team" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
	elseif techLevel == 3 then
		-- Empire
		if spawn_location_table["BYSS"] then
			start_planet = FindPlanet("Byss")
			spawn_list_Palpatine = { "Sedriss_Team", "Emperor_Palpatine_Team", "General_Veers_Team", "Chimera_Pellaeon_Vice", "Klev_Silencer7" }
			SpawnList(spawn_list_Palpatine, start_planet, p_empire,true,false)
		end
		-- New Republic
		if spawn_location_table["MONCALIMARI"] then		
			start_planet = FindPlanet("MonCalimari")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
		end	

		checkLeia = Find_First_Object("Princess_Leia")
		if TestValid(checkLeia) then
			checkLeia.Despawn()
			spawn_list_Leia = { "Princess_Leia_Team_Noghri" }
			SpawnList(spawn_list_Leia, start_planet, p_newrep, true, false)
		end

		checkAckbar = Find_First_Object("Home_One")
		if TestValid(checkAckbar) then
			checkAckbar.Despawn()
			spawn_list_Ackbar = { "Galactic_Voyager" }
			SpawnList(spawn_list_Ackbar, start_planet, p_newrep, true, false)
		end

		if spawn_location_table["CORUSCANT"] then		
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Iblis_Peregrine" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end
		
		if spawn_location_table["MYRKR"] then		
			start_planet = FindPlanet("Myrkr")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Errant_Venture", "Mara_Saber_Team", "Wild_karrde" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end
	
		-- Hand
		if spawn_location_table["NIRAUAN"] then
			start_planet = FindPlanet("Nirauan")
			if start_planet.Get_Owner() ~= Find_Player("Underworld") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
			end
			if start_planet then
				spawn_list_Hand = { "Soontir_Fel_Squadron", "Siath_Battlehammer" }
				SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
			end
		end
		
				-- Teradoc
		if spawn_location_table["HAKASSI"] then
			start_planet = FindPlanet("Hakassi")
			if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if start_planet then
				spawn_list_teradoc = { "Lancet_Kosh", "13x_Teradoc" }
				SpawnList(spawn_list_teradoc, start_planet, p_maldrood, true, false)
			end
		end
		
		-- Pentastar
		if spawn_location_table["ENTRALLA"] then
			start_planet = FindPlanet("Entralla")
			if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_pentastar)
			end
			if start_planet then
				spawn_list_zsinj = { "Grant_Oriflamme", "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
				SpawnList(spawn_list_zsinj, start_planet, p_pentastar, true, false)
			end
		end
		
		-- Eriadu
		if spawn_location_table["KAMPE"] then		
			start_planet = FindPlanet("Kampe")
			if start_planet.Get_Owner() ~= Find_Player("Hutts") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
			end
			if start_planet then
				spawn_list_delvardus = { "Night_Hammer_Delvardus" }
				SpawnList(spawn_list_delvardus, start_planet, p_eriadu, true, false)
			end
		end

		-- CSA : Re-enable after planet checks
		-- start_planet = FindPlanet("Ession")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Krin_Invincible" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
		
		-- start_planet = FindPlanet("Etti_IV")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Grumby_Notropis", "Sloane_Enforce", "Fiolla_Team", "Odumin_Team", "Karrek_Flim_Team", "Fasser_Team", "Nieler_Team" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
	elseif techLevel == 4 then
		if spawn_location_table["BYSS"] then
			Destroy_Planet("Byss")
		end
		if spawn_location_table["DA_SOOCHAV"] then
			Destroy_Planet("Da_SoochaV")
		end
		
		-- Empire
		if spawn_location_table["THE_MAW"] then
			start_planet = FindPlanet("The_Maw")
			spawn_list_Daala = { "Gorgon", "Odosk_Team", "Sivron_Team"  }
			SpawnList(spawn_list_Daala, start_planet, p_empire,true,false)
		end	

		if spawn_location_table["BYSS"] then		
			start_planet = FindPlanet("Byss")
			if start_planet.Get_Owner() ~= Find_Player("Empire") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
			end
			if start_planet then
				spawn_list_Brakiss = { "Brakiss_Team", "Ardax_Vendetta" }
				SpawnList(spawn_list_Brakiss, start_planet, p_empire,true,false)
			end
		end	
		
		-- New Republic
		if spawn_location_table["YAVIN"] then		
			start_planet = FindPlanet("Yavin")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Daala = { "Cilghal_Team" }
				SpawnList(spawn_list_Daala, start_planet, p_newrep, true, false)
			end
		end	
		
		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Daala = { "Bell_Endurance" }
				SpawnList(spawn_list_Daala, start_planet, p_newrep, true, false)
			end
		end
		
		checkAckbar = Find_First_Object("Home_One")
		if TestValid(checkAckbar) then
			checkAckbar.Despawn()
			spawn_list_Ackbar = { "Galactic_Voyager" }
			SpawnList(spawn_list_Ackbar, start_planet, p_newrep, true, false)
		end

		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Iblis_Peregrine" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end
		
		if spawn_location_table["MYRKR"] then		
			start_planet = FindPlanet("Myrkr")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Errant_Venture", "Mara_Saber_Team", "Wild_karrde" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end

		checkLeia = Find_First_Object("Princess_Leia")
		if TestValid(checkLeia) then
			checkLeia.Despawn()
			spawn_list_Leia = { "Princess_Leia_Team_Noghri" }
			SpawnList(spawn_list_Leia, start_planet, p_newrep, true, false)
		end

		
		-- Hand
		if spawn_location_table["NIRAUAN"] then
			start_planet = FindPlanet("Nirauan")
			if start_planet.Get_Owner() ~= Find_Player("Underworld") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
			end
			if start_planet then
				spawn_list_Hand = { "Soontir_Fel_Squadron", "Siath_Battlehammer", "Chak_Fel_Krsiss_Squadron_Association" , "Ashik_Team" }
				SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
			end
		end
		
			-- Teradoc
		if spawn_location_table["HAKASSI"] then
			start_planet = FindPlanet("Hakassi")
			if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
			end
			if start_planet then
				spawn_list_teradoc = { "Lancet_Kosh", "13x_Teradoc" }
				SpawnList(spawn_list_teradoc, start_planet, p_maldrood, true, false)
			end
		end
		
		-- Eriadu
		if spawn_location_table["KAMPE"] then
			start_planet = FindPlanet("Kampe")
			if start_planet.Get_Owner() ~= Find_Player("Hutts") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eriadu)
			end
			if start_planet then
				spawn_list_delvardus = { "Night_Hammer_Delvardus" }
				SpawnList(spawn_list_delvardus, start_planet, p_eriadu, true, false)
			end
		end
		
		-- Pentastar
		if spawn_location_table["ENTRALLA"] then
			start_planet = FindPlanet("Entralla")
			if start_planet.Get_Owner() ~= Find_Player("Pentastar") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_pentastar)
			end
			if start_planet then
				spawn_list_zsinj = { "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
				SpawnList(spawn_list_zsinj, start_planet, p_pentastar, true, false)
			end
		end

		-- CSA : Re-enable after planet checks
		-- start_planet = FindPlanet("Ession")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Krin_Invincible" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
		
		-- start_planet = FindPlanet("Etti_IV")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Grumby_Notropis", "Sloane_Enforce", "Fiolla_Team", "Odumin_Team", "Karrek_Flim_Team", "Fasser_Team", "Nieler_Team" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
	elseif techLevel == 5 then
		if spawn_location_table["BYSS"] then
			Destroy_Planet("Byss")
		end
		if spawn_location_table["DA_SOOCHAV"] then
			Destroy_Planet("Da_SoochaV")
		end
		if spawn_location_table["CARIDA"] then
			Destroy_Planet("Carida")
		end
		if spawn_location_table["EOLSHA"] then
			Destroy_Planet("EolSha")
		end
		
	
		-- Empire
		
		if spawn_location_table["BASTION"] then
			start_planet = FindPlanet("Bastion")
			if start_planet.Get_Owner() ~= Find_Player("Empire") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
			end
			if start_planet then
				spawn_list_Pellaeon = { "Chimera_Pellaeon_Grand", "Disra_Team", "Tierce_Team", "Ascian", "Rogriss_Dominion", "Navett_Team", "181st_Stele", "Hestiv_Team" }
				SpawnList(spawn_list_Pellaeon, start_planet, p_empire,true,false)
			end
		end
		
		-- New Republic
		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Palpatine = { "Gavrisom_Team" }
				SpawnList(spawn_list_Palpatine, start_planet, p_newrep, true, false)
			end
		end

		if spawn_location_table["YAVIN"] then
			start_planet = FindPlanet("Yavin")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Daala = { "Cilghal_Team" }
				SpawnList(spawn_list_Daala, start_planet, p_newrep, true, false)
			end
		end

		if spawn_location_table["CORUSCANT"] then			
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Daala = { "Bell_Endurance" }
				SpawnList(spawn_list_Daala, start_planet, p_newrep, true, false)
			end
		end	
		
		checkAckbar = Find_First_Object("Home_One")
		if TestValid(checkAckbar) then
			checkAckbar.Despawn()
			spawn_list_Ackbar = { "Galactic_Voyager" }
			SpawnList(spawn_list_Ackbar, start_planet, p_newrep, true, false)
		end

		if spawn_location_table["CORUSCANT"] then
			start_planet = FindPlanet("Coruscant")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Iblis_Peregrine" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end

		if spawn_location_table["MYRKR"] then		
			start_planet = FindPlanet("Myrkr")
			if start_planet.Get_Owner() ~= Find_Player("Rebel") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
			end
			if start_planet then
				spawn_list_Thrawn = { "Errant_Venture", "Mara_Saber_Team", "Wild_karrde" }
				SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
			end
		end

		checkLeia = Find_First_Object("Princess_Leia")
		if TestValid(checkLeia) then
			checkLeia.Despawn()
			spawn_list_Leia = { "Princess_Leia_Team_Noghri" }
			SpawnList(spawn_list_Leia, start_planet, p_newrep, true, false)
		end

		
		-- Hand
		if spawn_location_table["NIRAUAN"] then		
			start_planet = FindPlanet("Nirauan")
			if start_planet.Get_Owner() ~= Find_Player("Underworld") then
				start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
			end
			if start_planet then
				spawn_list_Hand = { "Soontir_Fel_Squadron", "Aurek_Seven_Team", "Siath_Battlehammer", "Chak_Fel_Krsiss_Squadron_Association", "Ashik_Team" }
				SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
			end
		end
		
		-- CSA : Re-enable after planet checks
		-- start_planet = FindPlanet("Ession")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Krin_Invincible" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
		
		-- start_planet = FindPlanet("Etti_IV")
		-- if start_planet.Get_Owner() ~= Find_Player("Corporate_Sector") then
			-- start_planet = TRUtil.FindFriendlyPlanet(p_corporate)
		-- end
		-- if start_planet then
			-- spawn_list_csa = { "Grumby_Notropis", "Sloane_Enforce", "Fiolla_Team", "Odumin_Team", "Karrek_Flim_Team", "Fasser_Team", "Nieler_Team" }
			-- SpawnList(spawn_list_csa, start_planet, p_corporate, true, false)
		-- end
	end
	
	placeholder_table = Find_All_Objects_Of_Type("Placement_Dummy")
	for i,unit in pairs(placeholder_table) do
		unit.Despawn()
	end
	

  end
end

function Commenor_Maldrood(message)
  if message == OnEnter then

	p_maldrood = Find_Player("Teradoc")
	
	if spawn_location_table["COMMENOR"] then
		start_planet = FindPlanet("Commenor")
		p_empire = Find_Player("Empire")
		techLevel = p_empire.Get_Tech_Level()
		if techLevel == 1 then
			if start_planet.Get_Owner() == Find_Player("Teradoc") then
				if p_maldrood.Is_Human() then
					Story_Event("GENDARR_JOINS_SPEECH")
				end
			 spawn_list_commenor = { "Lott_Team" , "Gendarr_Reliance" }
			 SpawnList(spawn_list_commenor, start_planet, p_maldrood,true,false)
			end
		end
	end	

  end
end

function Antem_Maldrood(message)
  if message == OnEnter then

   p_maldrood = Find_Player("Teradoc")
   start_planet = FindPlanet("Antem")

	p_empire = Find_Player("Empire")
	techLevel = p_empire.Get_Tech_Level()
	if techLevel == 1 then
		if start_planet.Get_Owner() == Find_Player("Teradoc") then
			if p_maldrood.Is_Human() then
				Story_Event("GETELLES_JOINS_SPEECH")
			end
			spawn_list_kosh = { "Getelles_Team" , "Larm_Carrack" }
			SpawnList(spawn_list_kosh, start_planet, p_maldrood,true,false)
		  --end
		end
	end

  end
end

function Kashyyyk_Maldrood(message)
  if message == OnEnter then

   p_maldrood = Find_Player("Teradoc")
   start_planet = FindPlanet("Kashyyyk")

	p_empire = Find_Player("Empire")
	techLevel = p_empire.Get_Tech_Level()
	if techLevel == 1 then
		if start_planet.Get_Owner() == Find_Player("Teradoc") then
			if p_maldrood.Is_Human() then
				Story_Event("SYN_JOINS_SPEECH")
			end
			spawn_list_syn = { "Syn_Silooth" }
			SpawnList(spawn_list_syn, start_planet, p_maldrood,true,false)
		  --end
		end
	end

  end
end

function Elrood_Eriadu(message)
  if message == OnEnter then

   p_eriadu = Find_Player("Hutts")
   start_planet = FindPlanet("Elrood")

   	p_empire = Find_Player("Empire")
	techLevel = p_empire.Get_Tech_Level()
	if techLevel == 1 then
		if start_planet.Get_Owner() == Find_Player("Hutts") then
			if p_eriadu.Is_Human() then
				Story_Event("ELROOD_JOINS_SPEECH")
			end
			spawn_list_elrood = { "Andal_Team" , "Zed_Stalker" , "Pryl_Thunderflare" }
			SpawnList(spawn_list_elrood, start_planet, p_eriadu,true,false)
		end
	end

  end

end

function Centares_Zsinj(message)
  if message == OnEnter then

   p_zsinj = Find_Player("Pirates")
   start_planet = FindPlanet("Centares")

	p_empire = Find_Player("Empire")
	techLevel = p_empire.Get_Tech_Level()
	if techLevel == 1 then
		if start_planet.Get_Owner() == Find_Player("Pirates") then
			if p_zsinj.Is_Human() then
				Story_Event("SELIT_JOINS_SPEECH")
			end
			spawn_list_selit = { "Selit_Team"}
			SpawnList(spawn_list_selit, start_planet, p_zsinj,true,false)
		  --end
		end
	end

  end
end

function SubEra_Change(message)
  if message == OnEnter then

	p_empire = Find_Player("Empire")

	if spawn_location_table["CORUSCANT"] then
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
	end
	
	if start_planet then
		spawn_list_isard = { "Lusankya" }
		IsardSpawn = SpawnList(spawn_list_isard, start_planet, p_empire,true,false)
		
		ProjectAmbition = Find_First_Object("Project_Ambition_Dummy")
		if TestValid(ProjectAmbition) then
			spawn_list_ambition = { "Makati_Steadfast" , "Takel_MagicDragon" , "Corrupter_Star_Destroyer" , "Elite_Squadron" }
			SpawnList(spawn_list_ambition, start_planet, p_empire,true,false)
			ProjectAmbition.Despawn()
		end
	end

	checkPestage = Find_First_Object("Sate_Pestage")
  if TestValid(checkPestage) then
    checkPestage.Despawn()
  end


  end
end

function Spawn_Harrsk(message)
  if message == OnEnter then

	p_empire = Find_Player("Empire")
    p_harrsk = Find_Player("Warlords")


  checkHarrsk = Find_First_Object("Whirlwind_Star_Destroyer")
  if TestValid(checkHarrsk) then
    checkHarrsk.Despawn()
  end



    --Harrsk spawns
	if spawn_location_table["KALIST"] then
		start_planet = FindPlanet("Kalist")
		if TestValid(start_planet) then
			if start_planet.Get_Owner() == p_empire then
				ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

				spawn_list = { "Whirlwind_Star_Destroyer" }
				SpawnList(spawn_list, start_planet, p_harrsk, true, false)
			end
		  end
	end
	
	if spawn_location_table["EOLSHA"] then
		start_planet = FindPlanet("ABREGADO_RAE")
		if TestValid(start_planet) then
		  if start_planet.Get_Owner() == p_empire then
			ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

		   spawn_list = { "Generic_Star_Destroyer" }
		   SpawnList(spawn_list, start_planet, p_harrsk, true, false)
		  end
		end
	end
	--CCoGM spawns
	
	if spawn_location_table["KESSEL"] then
		start_planet = FindPlanet("Kessel")
	  if TestValid(start_planet) then
		if start_planet.Get_Owner() == p_empire then
		  ChangePlanetOwnerAndRetreat(start_planet, p_harrsk)

		 spawn_list = { "Tigellinus_Avatar", "Hissa_Moffship" }
		 SpawnList(spawn_list, start_planet, p_harrsk, true, false)
		end
	  end
	end

  end
end

function ThrawnSpawns(message)
  if message == OnEnter then
  
	p_empire = Find_Player("Empire")
	p_newrep = Find_Player("Rebel")
	p_maldrood = Find_Player("Teradoc")
  	
	-- Maldrood
	if spawn_location_table["CENTARES"] then
		start_planet = FindPlanet("Centares")
		if start_planet.Get_Owner() ~= Find_Player("Teradoc") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_maldrood)
		end
		if start_planet then
			spawn_list_thrawn = { "Tavira_Invidious" }
			SpawnList(spawn_list_thrawn, start_planet, p_maldrood, true, false)
		end	
	end
	
	-- Hand
	if spawn_location_table["NIRAUAN"] then
		start_planet = FindPlanet("Nirauan")
		if start_planet.Get_Owner() ~= Find_Player("Underworld") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
		end
		if start_planet then
			spawn_list_Hand = { "Soontir_Fel_Squadron" }
			SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
		end
	end	
	
	-- Empire
	if spawn_location_table["CORUSCANT"] then
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
		if start_planet then
			spawn_list_thrawn = { "Chimera" , "Corellian_Gunboat_Ferrier" }
			SpawnList(spawn_list_thrawn, start_planet, p_empire, true, false)
		end
	end
	
	if spawn_location_table["CORUSCANT"] then	
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
		if start_planet then
			spawn_list_Thrawn = { "181st_TIE_Interceptor_Squadron", "General_Covell_Team", "Judicator_Star_Destroyer", "Relentless_Star_Destroyer", "Joruus_Cboath_Team" }
			SpawnList(spawn_list_Thrawn, start_planet, p_empire, true, false)
		end
	end
	
	-- New Republic
	if spawn_location_table["CORUSCANT"] then	
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
		if start_planet then
			spawn_list_Thrawn = { "Iblis_Peregrine" }
			SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
		end
	end
	
	if spawn_location_table["MYRKR"] then	
		start_planet = FindPlanet("Myrkr")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
		if start_planet then
			spawn_list_Thrawn = { "Errant_Venture", "Mara_Saber_Team", "Wild_karrde" }
			SpawnList(spawn_list_Thrawn, start_planet, p_newrep, true, false)
		end
	end
	
    RegicideObject = Find_First_Object("Dummy_Regicide_Thrawn")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end
	
	end
end

function DarkEmpireSpawns(message)
  if message == OnEnter then

    p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")
    
	-- Empire
	if spawn_location_table["BYSS"] then	
		start_planet = FindPlanet("Byss")
		spawn_list_Palpatine = { "Sedriss_Team", "Emperor_Palpatine_Team", "General_Veers_Team", "Chimera_Pellaeon_Vice", "Klev_Silencer7"  }
		SpawnList(spawn_list_Palpatine, start_planet, p_empire,true,false)
	end
	-- New Republic
	if spawn_location_table["MONCALIMARI"] then		
		start_planet = FindPlanet("MonCalimari")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
	end	

	checkLeia = Find_First_Object("Princess_Leia")
	if TestValid(checkLeia) then
		checkLeia.Despawn()
		spawn_list_Leia = { "Princess_Leia_Team_Noghri" }
		SpawnList(spawn_list_Leia, start_planet, p_newrep, true, false)
	end

	checkAckbar = Find_First_Object("Home_One")
	if TestValid(checkAckbar) then
		checkAckbar.Despawn()
		spawn_list_Ackbar = { "Galactic_Voyager" }
		SpawnList(spawn_list_Ackbar, start_planet, p_newrep, true, false)
	end


    RegicideObject = Find_First_Object("Dummy_Regicide_Palpatine")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end
	
	-- Hand
	if spawn_location_table["NIRAUAN"] then	
		start_planet = FindPlanet("Nirauan")
		if start_planet.Get_Owner() ~= Find_Player("Underworld") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
		end
		if start_planet then
			spawn_list_Hand = { "Siath_Battlehammer" }
			SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
		end
	end

    RegicideObject = Find_First_Object("Dummy_Regicide_Palpatine")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end

  end
end

function Empire_Fractures(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_maldrood = Find_Player("Teradoc")
    p_eriadu = Find_Player("Hutts")
    p_harrsk = Find_Player("Warlords")
    p_pentastar = Find_Player("Pentastar")
	
	if spawn_location_table["BYSS"] then	
		start_planet = FindPlanet("Byss")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
		if start_planet then
			spawn_list_Jax = { "Emperors_Revenge_Star_Destroyer", "Jeratai_Allegiance", "Xexus_Shev_Team", "Kooloota_Team", "Carnor_Jax_Team", "Windcaller_Team", "Manos_Team", "Za_Team", "Immodet_Fortress_Company"  }
			SpawnList(spawn_list_Jax, start_planet, p_empire,true,false)
		end
	end

    RegicideObject = Find_First_Object("Dummy_Regicide_Jax")
    if RegicideObject then
        RegicideObject.Despawn()
   end
  end
end

function DaalaSpawns(message)
  if message == OnEnter then

  	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")

	-- Empire
	if spawn_location_table["EOLSHA"] then		
		start_planet = FindPlanet("The_Maw")

		spawn_list_Daala = { "Gorgon", "Odosk_Team", "Sivron_Team" }
		SpawnList(spawn_list_Daala, start_planet, p_empire,true,false)
	end
	
	if spawn_location_table["BYSS"] then		
		start_planet = FindPlanet("Byss")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
		if start_planet then
			spawn_list_Brakiss = { "Brakiss_Team", "Ardax_Vendetta" }
			SpawnList(spawn_list_Brakiss, start_planet, p_empire,true,false)
		end
	end
	
	-- New Republic
	if spawn_location_table["YAVIN"] then	
		start_planet = FindPlanet("Yavin")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
		if start_planet then
			spawn_list_Palpatine = { "Cilghal_Team" }
			SpawnList(spawn_list_Palpatine, start_planet, p_newrep, true, false)
		end
	end
	
	if spawn_location_table["CORUSCANT"] then	
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
		if start_planet then
			spawn_list_Thrawn = { "Bell_Endurance" }
			SpawnList(spawn_list_Palpatine, start_planet, p_newrep, true, false)
		end
	end	
	
	-- Hand
	if spawn_location_table["NIRAUAN"] then		
		start_planet = FindPlanet("Nirauan")
		if start_planet.Get_Owner() ~= Find_Player("Underworld") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
		end
		if start_planet then
			spawn_list_Hand = { "Chak_Fel_Krsiss_Squadron_Association" , "Ashik_Team" }
			SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
		end
	end	

    RegicideObject = Find_First_Object("Dummy_Regicide_Daala")
    if TestValid(RegicideObject) then
        RegicideObject.Despawn()
    end


  end
end



function PellaeonSpawns(message)
  if message == OnEnter then
  
  	p_newrep = Find_Player("Rebel")
	p_empire = Find_Player("Empire")
	p_eoth = Find_Player("Underworld")

	-- Empire
    local RegicideObject = Find_First_Object("Dummy_Regicide_Pellaeon")
    if RegicideObject then
        RegicideObject.Despawn()
    end
	
	if spawn_location_table["BASTION"] then		
		start_planet = FindPlanet("BASTION")
		if start_planet.Get_Owner() ~= Find_Player("Empire") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_empire)
		end
		if start_planet then
			spawn_list_Pellaeon = { "Chimera_Pellaeon_Grand", "Disra_Team", "Tierce_Team", "Ascian", "Rogriss_Dominion", "Navett_Team", "181st_Stele", "Hestiv_Team" }
			SpawnList(spawn_list_Pellaeon, start_planet, p_empire,true,false)
		end
	end
	
	-- New Republic
	if spawn_location_table["CORUSCANT"] then		
		start_planet = FindPlanet("Coruscant")
		if start_planet.Get_Owner() ~= Find_Player("Rebel") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_newrep)
		end
		if start_planet then
			spawn_list_Palpatine = { "Gavrisom_Team" }
			SpawnList(spawn_list_Palpatine, start_planet, p_newrep, true, false)
		end
	end	
	
	-- Hand
	if spawn_location_table["NIRAUAN"] then		
		start_planet = FindPlanet("Nirauan")
		if start_planet.Get_Owner() ~= Find_Player("Underworld") then
			start_planet = StoryUtil.FindFriendlyPlanet(p_eoth)
		end
		if start_planet then
			spawn_list_Hand = { "Aurek_Seven_Team" }
			SpawnList(spawn_list_Hand, start_planet, p_eoth,true,false)
		end
	end

  end
end

function Ciutric_Breakway(message)
  if message == OnEnter then

    p_empire = Find_Player("Empire")
    p_ciutric = Find_Player("Warlords")

	if spawn_location_table["CIUTRIC"] then		
		start_planet = FindPlanet("Ciutric")
		if TestValid(start_planet) then
		  if start_planet.Get_Owner() == p_empire then
			ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

			spawn_list = { "Generic_Star_Destroyer"  }
			SpawnList(spawn_list, start_planet, p_ciutric, true, false)
		  end
		end
	end
	
	if spawn_location_table["VROS"] then		
		start_planet = FindPlanet("Vros")
		if TestValid(start_planet) then
		  if start_planet.Get_Owner() == p_empire then
			ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

			spawn_list = { "Generic_Star_Destroyer"  }
			SpawnList(spawn_list, start_planet, p_ciutric, true, false)
		  end
		end
	end

	if spawn_location_table["CORVIS"] then		
		start_planet = FindPlanet("Corvis")
		if TestValid(start_planet) then
		  if start_planet.Get_Owner() == p_empire then
			ChangePlanetOwnerAndRetreat(start_planet, p_ciutric)

			spawn_list = { "Generic_Star_Destroyer"  }
			SpawnList(spawn_list, start_planet, p_ciutric, true, false)
		  end
		end
	end
	
  end
end

function HapesVassalEmerge(message)
	if message == OnEnter then
  
		p_hapes = Find_Player("Hapes_Consortium")
	
		--Returning occupied Hapan planets
	
		hapanCorePlanets = { "Hapes", "Charubah", "Terephon", "MistOne", "MistTwo", "MistThree" }  
		hapanOwnedPlanets = {}

		for _, planet in pairs(hapanCorePlanets) do
			planetObject =  FindPlanet(planet)
			if planetObject.Get_Owner() == Find_Player("Rebel") then
				table.insert(hapanOwnedPlanets, planetObject)
			end
		end	

		ChangePlanetOwnerAndRetreat(hapanOwnedPlanets, Find_Player("Hapes_Consortium"))

		for _, planet in pairs(hapanOwnedPlanets) do 
			spawn_list_Hapans = { "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "BattleDragon", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser", "Nova_Cruiser"}
			SpawnList(spawn_list_Hapans, planet, p_hapes,true,false)
		end
  
	end
  end
  
function Check_Coruscant_Owner(message)
  if message == OnEnter then
		p_newrep = Find_Player("Rebel")
		
		if FindPlanet("Coruscant").Get_Owner() == p_newrep then
			Story_Event("ENABLE_BATTLE_OF_CORUSCANT")
		end
	end
  end
  
function Spawn_Empire_Reward(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local start_planet = FindPlanet("Coruscant")


	spawn_list_coruscant = {"Generic_Star_Destroyer_Two", "Generic_Secutor", "Generic_Allegiance", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Generic_Interdictor_Cruiser", "Generic_Victory_Destroyer", "Vindicator_Cruiser", "Carrack_Cruiser", "Carrack_Cruiser", "Lancer_Frigate", "Lancer_Frigate", "Lancer_Frigate", "Raider_Pentastar", "Generic_Procursator", "Generic_Victory_Destroyer_Two", "Generic_Star_Destroyer", "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "Generic_Victory_Destroyer" }
    CoruscantSpawn = SpawnList(spawn_list_coruscant, start_planet, p_empire,false,false)

  end
end