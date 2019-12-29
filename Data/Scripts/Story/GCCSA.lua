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
--*   @Author:              Jorritkarwehr
--*   @Date:                2017-12-18T14:01:09+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCCSA.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-05T07:31:34-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("trlib-util/ChangeOwnerUtilities")
StoryUtil = require("trlib-util/StoryUtil")


function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
  {
    Determine_Faction_LUA = Find_Faction,
	Era_Selection = Era_Setup,
	Empire_Dromund = Prophet_spawn
  }

end

function Find_Faction(message)
  if message == OnEnter then

	 p_newrep = Find_Player("Rebel")
	 p_empire = Find_Player("Empire")
	 p_eoth = Find_Player("Underworld")
	 p_eriadu = Find_Player("Hutts")
	 p_pentastar = Find_Player("Pentastar")
	 p_zsinj = Find_Player("Pirates")
	 p_maldrood = Find_Player("Teradoc")
	 p_csa = Find_Player("Corporate_Sector")

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
	elseif p_csa.Is_Human() then
      Story_Event("ENABLE_BRANCH_CSA_FLAG")
	end

  end
end

function Era_Setup(message)
  if message == OnEnter then 
	universal_forces()
	 
	techLevel = p_csa.Get_Tech_Level()
	if techLevel == 1 then
		Zsinj_South_forces()
		era1_forces()
		Story_Event("START_ERA_1")
	elseif techLevel == 2 then
		Story_Event("START_ERA_2")
		Zsinj_South_forces()
		Zsinj_North_forces()
		CSA_extra_forces()
		orron_forces()
	elseif techLevel == 3 then
		Story_Event("START_ERA_3")		
		era3_forces()
		CSA_extra_forces()
		mytus_forces()
	else
		Story_Event("START_ERA_4")
		CSA_extra_forces()
		orron_forces()
		mytus_forces()
		era4_forces()
	end
	
	placeholder_table = Find_All_Objects_Of_Type("Placement_Dummy")
	for i,unit in pairs(placeholder_table) do
		unit.Despawn()
	end
	
	end
end

-- CSA and NR base, Lianna
function universal_forces(message)
	p_newrep = Find_Player("Rebel")
	p_warlords = Find_Player("Warlords")
	p_csa = Find_Player("Corporate_Sector")
	
	start_planet = FindPlanet("Etti_IV") -- lack of Sloane is intentional. OTher factions are pretty short on heroes and he's probably in the exclave by Naboo anyway
	unit_list = { "Grumby_Notropis", "Krin_Invincible", "Karrek_Flim_Team", "Odumin_Team", "Fiolla_Team", "Fasser_Team", "Nieler_Team", "Citadel_Cruiser_Squadron", "Citadel_Cruiser_Squadron", "C_Ground_Barracks", "C_Ground_Light_Vehicle_Factory", "Espo_Walker_Squad", "SX20_Company", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_3"), start_planet, p_csa)
	
	start_planet = FindPlanet("Ulicia")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Gozanti_Cruiser_Squadron", "Gozanti_Cruiser_Squadron", "Gozanti_Cruiser_Squadron", "CSA_LocalOffice", "C_Ground_Light_Vehicle_Factory", "C_Ground_Heavy_Vehicle_Factory", "Strikebreaker_Group", "JX40_Group", "X10_Group", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_2"), start_planet, p_csa)
	
	start_planet = FindPlanet("Atchorb")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Invincible_Cruiser", "Recusant", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "Citadel_Cruiser_Squadron", "Citadel_Cruiser_Squadron", "CSA_LocalOffice", "C_Ground_Barracks", "Aratech_Battle_Platform_Company", "GX12_Company", "GX12_Company", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
	
	start_planet = FindPlanet("Bonadan")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Generic_Victory_Destroyer", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "CSA_LocalOffice", "C_Ground_Barracks", "Rebel_Ground_Mining_Facility", "Rebel_Ground_Mining_Facility", "Espo_Walker_Squad", "Espo_Squad", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
	
	start_planet = FindPlanet("MonCalimari")
	unit_list = { "MC40a", "MC40a", "MC40a", "Airen_Cracken_Team", "R_Ground_Light_Vehicle_Factory" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_4"), start_planet, p_newrep)
	units = Spawn_Unit(Find_Object_Type("Empress_Station"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Hast")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Calamari_Cruiser", "Calamari_Cruiser", "Nebulon_B_Frigate", "Corellian_Corvette", "Corellian_Corvette", "Corellian_Corvette", "NewRep_SenatorsOffice", "R_Ground_Light_Vehicle_Factory", "R_Ground_Heavy_Vehicle_Factory" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_3"), start_planet, p_newrep)
	units = Spawn_Unit(Find_Object_Type("Rebel_Golan_Three"), start_planet, p_newrep)
	
	start_planet = FindPlanet("NewAlderaan")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "NewRep_SenatorsOffice", "R_Ground_Barracks", "R_Ground_Barracks", "R_Ground_Light_Vehicle_Factory", "R_Ground_Light_Vehicle_Factory" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_1"), start_planet, p_newrep)
	
	if p_csa.Get_Tech_Level() > 1 then --keep the NR passive for a while in era 1
		start_planet = FindPlanet("MonCalimari")
		unit_list = { "Rebel_Heavy_Tank_Brigade", "Rebel_Heavy_Tank_Brigade", "Rebel_T3_Tank_Brigade", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
		SpawnList(unit_list, start_planet, p_newrep,true,false)
		
		start_planet = FindPlanet("Hast")
		unit_list = { "Rebel_T3_Tank_Brigade", "Rebel_T3_Tank_Brigade", "Rebel_RAF_Brigade", "Rebel_RAF_Brigade", "Rebel_RAF_Brigade", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
		SpawnList(unit_list, start_planet, p_newrep,true,false)
		
		start_planet = FindPlanet("NewAlderaan")
		unit_list = { "Rebel_Light_Missile_Brigade", "Rebel_Light_Missile_Brigade", "Rebel_AA5_Brigade", "Rebel_AA5_Brigade", "Rebel_Light_Tank_Brigade", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
		SpawnList(unit_list, start_planet, p_newrep,true,false)
	end
	
	start_planet = FindPlanet("MonCalimari")
	if p_csa.Get_Tech_Level() < 3 then
		unit_list = { "Home_One" }
	else
		unit_list = { "Galactic_Voyager" }
	end
	SpawnList(unit_list, start_planet, p_newrep,true,false)
  
	start_planet = FindPlanet("Lianna")
	start_planet.Change_Owner(p_warlords)
	unit_list = { "IPV1_Teradoc", "IPV1_Teradoc", "IPV1_Teradoc", "IPV1_Teradoc", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "Marauder_Missile_Cruiser", "Vindicator_Cruiser", "Vindicator_Cruiser", "Vindicator_Cruiser", "Avenger_Squadron_Buildable", "TIE_Defender_Squadron_Buildable", "Empire_MoffPalace", "Sienar_HQ", "Century_Brigade", "Imperial_Anti_Infantry_Brigade", "Imperial_Anti_Infantry_Brigade", "Imperial_Anti_Infantry_Brigade", "Lancet_Air_Wing", "Lancet_Air_Wing" }
	SpawnList(unit_list, start_planet, p_warlords,true,false)
end

-- era 1 Empire, Screed, Prophets
function era1_forces(message)
	p_empire = Find_Player("Empire")
	p_zsinj = Find_Player("Pirates")
	p_warlords = Find_Player("Warlords")
	
	empire_base()
	
	start_planet = FindPlanet("Saffalore")
	unit_list = { "Makati_Steadfast" }
	SpawnList(unit_list, start_planet, p_empire,true,false)

	
	
	start_planet = FindPlanet("Oslumpex")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Acclamator_Assault_Ship", "Generic_Acclamator_Assault_Ship", "Empire_MoffPalace", "E_Ground_Light_Vehicle_Factory", "E_Ground_Heavy_Vehicle_Factory", "Imperial_ATPT_Squad", "Imperial_ATPT_Squad", "Army_Trooper_Squad", "Army_Trooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_2"), start_planet, p_empire)
	
	start_planet = FindPlanet("Maryo")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Carrack_Cruiser", "Empire_MoffPalace", "E_Ground_Barracks", "Army_Trooper_Squad", "Imperial_Stormtrooper_Squad", "Army_Trooper_Squad", "Imperial_Stormtrooper_Squad", "Army_Trooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Desevro")
	unit_list = { "Demolisher" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
  
	start_planet = FindPlanet("Dromund")
	start_planet.Change_Owner(p_warlords)
	unit_list = { "Raider_Pentastar", "Raider_Pentastar", "Generic_Star_Destroyer", "Decimator_Squadron", "Generic_Imperial_II_Frigate", "Generic_Imperial_II_Frigate", "Empire_MoffPalace", "Penta_Heavy_Assault_Company", "Jedgar_Team", "Dark_Jedi_Squad", "Dark_Jedi_Squad", "Dark_Jedi_Squad", "Dark_Jedi_Squad", "Dark_Jedi_Squad" }
	SpawnList(unit_list, start_planet, p_warlords,true,false)
end

function empire_base(message)
	p_empire = Find_Player("Empire")
	
	start_planet = FindPlanet("Emmer")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "Empire_MoffPalace", "Remnant_Capital", "E_Ground_Light_Vehicle_Factory", "Century_Brigade", "Imperial_Artillery_Corp", "Imperial_Anti_Aircraft_Company" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	units = Spawn_Unit(Find_Object_Type("Empire_Golan_One"), start_planet, p_empire)
	units = Spawn_Unit(Find_Object_Type("Empire_Golan_One"), start_planet, p_empire)
	
	start_planet = FindPlanet("Orron")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Dreadnaught_Empire", "Carrack_Cruiser", "Empire_MoffPalace", "E_Ground_Barracks", "Army_Trooper_Squad", "Army_Trooper_Squad", "Imperial_Light_Scout_Squad", "Imperial_Light_Scout_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Saffalore")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer_Two", "Strike_Cruiser", "Strike_Cruiser", "Escort_Carrier", "Lancer_Frigate", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "Chariot_LAV_Company", "Imperial_Armor_Group", "Imperial_Armor_Group", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Kalla")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer", "Dreadnaught_Empire", "Dreadnaught_Empire", "Escort_Carrier", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "Imperial_Heavy_Scout_Squad", "Imperial_Anti_Infantry_Brigade", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Raxus")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer", "Dreadnaught_Empire", "Escort_Carrier", "Lancer_Frigate", "Empire_MoffPalace", "E_Ground_Light_Vehicle_Factory", "E_Ground_Heavy_Vehicle_Factory", "Century_Brigade", "Imperial_Armor_Group", "Imperial_Stormtrooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_2"), start_planet, p_empire)
	units = Spawn_Unit(Find_Object_Type("Empire_Golan_One"), start_planet, p_empire)
end

-- era 1 and 2 Zsinj basic roster
function Zsinj_South_forces(message)
	p_zsinj = Find_Player("Pirates")
	
	start_planet = FindPlanet("Desevro")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Generic_Star_Destroyer", "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Generic_Gladiator", "Generic_Gladiator", "Generic_Gladiator", "CR90_Zsinj", "CR90_Zsinj", "Teubbo_Team", "Zsinj_MoffPalace", "Rancor_Base", "Z_Ground_Heavy_Vehicle_Factory", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Barracks", "Zsinj_A5_Juggernaut_Company", "Zsinj_Century_Brigade", "Zsinj_Anti_Infantry_Brigade", "Zsinj_Anti_Infantry_Brigade", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_2"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Ession")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Night_Caller", "CR90_Zsinj", "Quasar_Zsinj", "Generic_Star_Destroyer_Two", "Zsinj_MoffPalace", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Light_Vehicle_Factory", "Zsinj_IDT_Squad", "Zsinj_IDT_Squad", "Hailfire_Zsinj", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_2"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Felucia")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Neutron_Star", "Nebulon_B_Zsinj", "Zsinj_MoffPalace", "Z_Ground_Barracks", "Z_Ground_Barracks", "Lanu_Team", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad", "Zsinj_Light_Scout_Squad", "Zsinj_Light_Scout_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Galidraan")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Dreadnaught_Empire", "Dreadnaught_Empire", "Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "Zsinj_MoffPalace", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Barracks", "Zsinj_Armor_Group", "Zsinj_Raptor_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Raxus_Second")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Banjeer", "Quasar_Zsinj", "Quasar_Zsinj", "Quasar_Zsinj", "Quasar_Zsinj", "Quasar_Zsinj", "Neutron_Star", "Neutron_Star", "Neutron_Star", "Neutron_Star", "Zsinj_MoffPalace", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Barracks", "Zsinj_Heavy_Scout_Squad", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
end

-- era 2 Zsinj extra roster and Solo Fleet
function Zsinj_North_forces(message)
	p_zsinj = Find_Player("Pirates")
	p_newrep = Find_Player("Rebel")

	start_planet = FindPlanet("Raxus")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Generic_Star_Destroyer", "Dreadnaught_Empire", "Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "CR90_Zsinj", "CR90_Zsinj", "Zsinj_MoffPalace", "Z_Ground_Heavy_Vehicle_Factory", "Z_Ground_Light_Vehicle_Factory", "Zsinj_Heavy_Assault_Company", "Hailfire_Zsinj", "Zsinj_Raptor_Squad" , "Zsinj_Raptor_Squad"  }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_2"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Emmer")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Implacable_Star_Destroyer", "Generic_Star_Destroyer_Two", "Generic_Victory_Destroyer_Two", "Generic_Victory_Destroyer", "Quasar_Zsinj", "Quasar_Zsinj", "Zsinj_MoffPalace", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Light_Vehicle_Factory", "Zsinj_Artillery_Corp", "Zsinj_Century_Brigade", "Zsinj_Raptor_Squad", "Zsinj_Light_Scout_Squad", "Zsinj_Light_Scout_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
		
	start_planet = FindPlanet("Kalla")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Generic_Victory_Destroyer", "Generic_Victory_Destroyer", "Dreadnaught_Empire", "Dreadnaught_Empire", "CR90_Zsinj", "CR90_Zsinj", "CR90_Zsinj", "Zsinj_MoffPalace", "Z_Ground_Light_Vehicle_Factory", "Z_Ground_Barracks", "Zsinj_Heavy_Scout_Squad" , "Zsinj_Raptor_Squad" , "Zsinj_Raptor_Squad" , "Zsinj_Raptor_Squad"  }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
	
	start_planet = FindPlanet("Saffalore")
	start_planet.Change_Owner(p_zsinj)
	unit_list = { "Generic_Star_Destroyer", "Generic_Victory_Destroyer_Two", "Generic_Gladiator", "Generic_Gladiator", "Zsinj_MoffPalace", "Z_Ground_Heavy_Vehicle_Factory", "Z_Ground_Light_Vehicle_Factory", "Zsinj_Armor_Group", "Zsinj_IDT_Squad", "Zsinj_Anti_Infantry_Brigade", "Zsinj_Raptor_Squad", "Zsinj_Raptor_Squad", "Zsinj_Light_Scout_Squad" }
	SpawnList(unit_list, start_planet, p_zsinj,true,false)
	units = Spawn_Unit(Find_Object_Type("Zsinj_Star_Base_1"), start_planet, p_zsinj)
	
	--Failing miserably to Hunt Zsinj, but hey, a reference!
	start_planet = FindPlanet("NespisVIII")
	unit_list = { "Solo_Remonda", "Rogue_Squadron_Space", "Wraith_Squadron_Space", "Generic_Star_Destroyer_Two", "ISD_1_NR", "ISD_1_NR", "Calamari_Cruiser", "Calamari_Cruiser", "Generic_Interdictor_Cruiser", "Quaser", "Nebulon_B_Frigate", "Nebulon_B_Frigate", "Nebulon_B_Frigate", "Marauder_Missile_Cruiser", "Corellian_Corvette", }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
end

-- Dark Empire, Era 3 NR specific
function era3_forces(message)
	p_empire = Find_Player("Empire")
	p_newrep = Find_Player("Rebel")
	
	empire_base()
	
	start_planet = FindPlanet("Orron")
	unit_list = { "Klev_Silencer7", "Banjeer_Neutron", "World_Devastator", "Generic_Victory_Destroyer_Two", "MTC_Sensor", "MTC_Sensor", "MTC_Sensor", "Lancer_Frigate", "Imperial_Heavy_Assault_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	
	
	start_planet = FindPlanet("Ession")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer", "Strike_Cruiser", "Strike_Cruiser", "MTC_Sensor", "MTC_Sensor", "Lancer_Frigate", "Lancer_Frigate", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "Imperial_XR85_Tankdroid", "Century_Brigade", "Imperial_ATPT_Squad", "Imperial_Stormtrooper_Squad", "Imperial_EWEB_Squad", "Imperial_EWEB_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_2"), start_planet, p_empire)
	
	start_planet = FindPlanet("Desevro")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Star_Destroyer", "Generic_Victory_Destroyer_Two", "MTC_Sensor", "MTC_Sensor", "Empire_MoffPalace", "E_Ground_Light_Vehicle_Factory", "E_Ground_Light_Vehicle_Factory", "Imperial_XR85_Tankdroid", "Imperial_XR85_Tankdroid", "Army_Trooper_Squad", "Army_Trooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_2"), start_planet, p_empire)
	
	start_planet = FindPlanet("Felucia")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Dreadnaught_Empire", "Dreadnaught_Empire", "Dreadnaught_Empire", "Escort_Carrier", "Escort_Carrier", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Barracks", "Imperial_Anti_Infantry_Brigade", "Imperial_Stormtrooper_Squad", "Imperial_Stormtrooper_Squad", "Imperial_Light_Scout_Squad", "Imperial_Light_Scout_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Galidraan")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Dreadnaught_Empire", "Carrack_Cruiser", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "Army_Trooper_Squad", "Army_Trooper_Squad", "Army_Trooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Raxus_Second")
	start_planet.Change_Owner(p_empire)
	unit_list = { "Generic_Victory_Destroyer", "Vindicator_Cruiser", "Vindicator_Cruiser", "MTC_Sensor", "MTC_Sensor", "Lancer_Frigate", "Lancer_Frigate", "Lancer_Frigate", "Empire_MoffPalace", "E_Ground_Barracks", "E_Ground_Light_Vehicle_Factory", "Imperial_Stormtrooper_Squad", "Army_Trooper_Squad" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	units = Spawn_Unit(Find_Object_Type("Remnant_Star_Base_1"), start_planet, p_empire)
	
	start_planet = FindPlanet("Dromund") --Pilgrimage to a Sith historic sight or something. This planet is really just here for Jedgar and Kadann
	start_planet.Change_Owner(p_empire)
	unit_list = { "Sedriss_Team" }
	SpawnList(unit_list, start_planet, p_empire,true,false)
	
	
	start_planet = FindPlanet("MonCalimari")
	unit_list = { "MC80B", "ISD_1_NR", "MC90" } --Mon Remonda, Emancipator, and some random extra Mon Cal strength
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	
	start_planet = FindPlanet("NespisVIII")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Lando_Calrissian_Team", "Wedge_Rogue_Squadron_Space", "Princess_Leia_Team_Noghri", "Mon_Mothma_Team", "Luke_Skywalker_Jedi_Teams", "Han_Solo_Team", "NewRep_SenatorsOffice", "Rebel_Speeder_Wing", "Rebel_Speeder_Wing", "Rebel_Speeder_Wing", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
end

-- CSA era 2 and 3
function CSA_extra_forces(message)	
	p_csa = Find_Player("Corporate_Sector")
	
	start_planet = FindPlanet("Oslumpex")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Bulwark_I", "Dauntless", "Gozanti_Cruiser_Squadron", "Gozanti_Cruiser_Squadron", "CSA_LocalOffice", "C_Ground_Light_Vehicle_Factory", "C_Ground_Heavy_Vehicle_Factory", "Strikebreaker_Group", "JX40_Group", "GX12_Company", "Espo_Squad", "Espo_Squad"}
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
	
	start_planet = FindPlanet("Maryo")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Generic_Victory_Destroyer", "Generic_Gladiator", "Generic_Gladiator", "CSA_LocalOffice", "C_Ground_Barracks", "X10_Group", "X10_Group", "SX20_Company", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
end

-- CSA era 2 and 4
function orron_forces(message)
	p_csa = Find_Player("Corporate_Sector")
	
	start_planet = FindPlanet("Orron")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Lucrehulk_CSA", "CSA_LocalOffice", "C_Ground_Barracks", "C_Ground_Barracks", "Espo_Walker_Squad", "Espo_Walker_Squad", "X10_Group", "GX12_Company", "Espo_Squad", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
end

-- CSA era 3 and 4
function mytus_forces(message)
	p_csa = Find_Player("Corporate_Sector")
	
	start_planet = FindPlanet("Mytus")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Nebulon_B_Zsinj", "Nebulon_B_Zsinj", "CSA_LocalOffice" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
end

--Extra NR and CSA
function era4_forces(message)
	p_csa = Find_Player("Corporate_Sector")
	p_newrep = Find_Player("Rebel")
	
	start_planet = FindPlanet("Kalla")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Bulwark_I", "Neutron_Star", "Neutron_Star", "CSA_LocalOffice", "C_Ground_Barracks", "C_Ground_Light_Vehicle_Factory", "Persuader_Company", "Persuader_Company", "C_Hailfire_Company", "B1_Droid_Squad", "B1_Droid_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
	
	start_planet = FindPlanet("Saffalore")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Dreadnaught_Empire", "Quasar_Zsinj", "Quasar_Zsinj", "CSA_LocalOffice", "C_Ground_Barracks", "C_Ground_Light_Vehicle_Factory", "GX12_Company", "GX12_Company", "X10_Group", "SX20_Company", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_1"), start_planet, p_csa)
	
	start_planet = FindPlanet("Ession")
	start_planet.Change_Owner(p_csa)
	unit_list = { "Generic_Victory_Destroyer_Two", "MTC_CSA", "MTC_CSA", "MTC_CSA", "MTC_CSA", "CSA_LocalOffice", "C_Ground_Light_Vehicle_Factory", "C_Ground_Light_Vehicle_Factory", "Aratech_Battle_Platform_Company", "K222_Wing", "K222_Wing", "Espo_Squad", "Espo_Squad", "Espo_Squad" }
	SpawnList(unit_list, start_planet, p_csa,true,false)
	units = Spawn_Unit(Find_Object_Type("CSA_Star_Base_2"), start_planet, p_csa)
	
	
	start_planet = FindPlanet("MonCalimari")
	unit_list = { "Cilghal_Team" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	
	
	start_planet = FindPlanet("Desevro")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Majestic", "Majestic", "Sacheen", "Sacheen", "NewRep_SenatorsOffice", "R_Ground_Barracks", "R_Ground_Light_Vehicle_Factory", "Rebel_Heavy_Tank_Brigade", "Rebel_Light_Tank_Brigade", "Rebel_Light_Tank_Brigade", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_2"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Felucia")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Alliance_Assault_Frigate", "MC40a", "NewRep_SenatorsOffice", "R_Ground_Barracks", "R_Ground_Barracks", "Rebel_Light_Tank_Brigade_T1", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_1"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Galidraan")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Alliance_Assault_Frigate", "Corellian_Gunboat", "Corellian_Gunboat", "NewRep_SenatorsOffice", "R_Ground_Light_Vehicle_Factory", "Rebel_Infiltrator_Team", "Rebel_Infiltrator_Team", "Rebel_Infiltrator_Team", "Gallofree_HTT_Company" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_1"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Raxus")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "MC80B", "ISD_1_NR", "Corellian_Gunboat", "Corellian_Gunboat", "NewRep_SenatorsOffice", "R_Ground_Light_Vehicle_Factory", "R_Ground_Heavy_Vehicle_Factory", "Tracker_Company", "Rebel_Artillery_Brigade", "Rebel_Speeder_Wing", "Rebel_Speeder_Wing", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_2"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Raxus_Second")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "MC90", "Dauntless", "Corellian_Corvette", "Corellian_Corvette", "NewRep_SenatorsOffice", "R_Ground_Light_Vehicle_Factory", "Rebel_Light_Missile_Brigade", "Rebel_Light_Missile_Brigade", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_1"), start_planet, p_newrep)
	
	start_planet = FindPlanet("Emmer")
	start_planet.Change_Owner(p_newrep)
	unit_list = { "Nebula", "Endurance", "Corona", "Corona", "Sacheen", "Sacheen", "NewRep_SenatorsOffice", "R_Ground_Light_Vehicle_Factory", "R_Ground_Light_Vehicle_Factory", "Rebel_RAF_Brigade", "Rebel_RAF_Brigade", "Rebel_RAF_Brigade", "Rebel_Speeder_Wing", "Rebel_Infantry_Squad", "Rebel_Infantry_Squad" }
	SpawnList(unit_list, start_planet, p_newrep,true,false)
	units = Spawn_Unit(Find_Object_Type("NR_Star_Base_1"), start_planet, p_newrep)
end

function Prophet_spawn(message)
	if message == OnEnter then
		p_empire = Find_Player("Empire")
  
		start_planet = FindPlanet("Dromund")
		if start_planet.Get_Owner() == Find_Player("Empire") then
			if p_empire.Is_Human() then
				Story_Event("PROPHET_SPEECH")
			end
			spawn_list_duo = { "Kadann_Team", "Jedgar_Team" }
			SpawnList(spawn_list_duo, start_planet, p_empire, true, false)
		end
	end
end