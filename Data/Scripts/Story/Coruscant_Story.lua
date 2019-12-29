--////////////////////////////////////////////////
-- Katana Mission (New Republic)
--////////////////////////////////////////////////

require("PGStoryMode")
require("PGSpawnUnits")
require("PGMoveUnits")



function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Battle_Start = Begin_Battle,
		Wave2_Spawn = More_Foes,
		Wave3_Spawn = Moar_Foes
	}
end


function Begin_Battle(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		entry_marker = Find_First_Object("Attacker Entry Position")
		--invading_fleet = {"Skirmish_Star_Destroyer_Two", "Skirmish_Star_Destroyer_Two", "Skirmish_Secutor", "Skirmish_Praetor", "Skirmish_Allegiance", "Skirmish_MTC_Sensor", "Skirmish_MTC_Sensor", "Skirmish_MTC_Sensor", "Skirmish_Dreadnaught_Empire", "Skirmish_Dreadnaught_Empire", "Skirmish_Dreadnaught_Empire", "Skirmish_Interdictor_Cruiser", "Skirmish_Victory_Destroyer", "Skirmish_Vindicator_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Lancer_Frigate", "Skirmish_Lancer_Frigate", "Skirmish_Raider_Pentastar", "Skirmish_Lancer_Frigate", "Skirmish_Tartan_Patrol_Cruiser", "Skirmish_Raider_Pentastar", "Skirmish_Procursator", "Skirmish_Victory_Destroyer_Two", "Skirmish_Procursator", "Skirmish_Victory_Destroyer_Two", "Skirmish_Star_Destroyer", "Skirmish_Star_Destroyer","Skirmish_Secutor", "Skirmish_Strike_Cruiser", "Skirmish_Strike_Cruiser", "Skirmish_Strike_Cruiser", "Skirmish_Victory_Destroyer", "Skirmish_Neutron_Star" }
		
		invading_fleet = {"Skirmish_Star_Destroyer_Two", "Skirmish_Allegiance", "Skirmish_MTC_Sensor", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer", "Skirmish_Vindicator_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Lancer_Frigate", "Skirmish_Tartan_Patrol_Cruiser", "Skirmish_Procursator",  "Skirmish_Procursator",  "Skirmish_Secutor", "Skirmish_Strike_Cruiser", "Skirmish_Gladiator", }
		--invading_fleet_2 = {"Skirmish_Star_Destroyer_Two", "Skirmish_Praetor", "Skirmish_MTC_Sensor", "Skirmish_MTC_Sensor", "Skirmish_Dreadnaught_Empire", "Skirmish_Lancer_Frigate", "Skirmish_Victory_Destroyer_Two", "Skirmish_Victory_Destroyer_Two", "Skirmish_Star_Destroyer", "Skirmish_Strike_Cruiser", "Skirmish_Strike_Cruiser", "Skirmish_Vigil", "Skirmish_Vigil", "Skirmish_IPV1_Teradoc", }
		--invading_fleet_3 = {"Skirmish_Secutor", "Skirmish_Interdictor_Cruiser", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer", "Skirmish_Carrack_Cruiser","Skirmish_Carrack_Cruiser", "Skirmish_Raider_Pentastar", "Skirmish_Lancer_Frigate", "Skirmish_Raider_Pentastar", "Skirmish_Star_Destroyer",  "Skirmish_Neutron_Star",  "Skirmish_Broadside_Cruiser", "Skirmish_Broadside_Cruiser", }
		
		local invaders = Find_Player("Hostile")
		
		local imps = SpawnList(invading_fleet, entry_marker, invaders, true, true)
		
		--Register_Timer(spawnFleet, 0, {self, invading_fleet, entry_marker, invaders})
		-- Register_Timer(spawnFleet, 10, {self, invading_fleet_2, entry_marker, invaders})
		-- Register_Timer(spawnFleet, 20, {self, invading_fleet_3, entry_marker, invaders})
		-- boarder_list = SpawnList(invading_fleet, entry_marker, invaders, false, true)
		-- boarder_list_2 = SpawnList(invading_fleet_2, entry_marker, invaders, false, true)
		-- boarder_list_3 = SpawnList(invading_fleet_3, entry_marker, invaders, false, true)
	end
end

function More_Foes(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		entry_marker = Find_First_Object("Attacker Entry Position")
		
		invading_fleet_2 = {"Skirmish_Star_Destroyer_Two", "Skirmish_Praetor", "Skirmish_MTC_Sensor", "Skirmish_MTC_Sensor", "Skirmish_Dreadnaught_Empire", "Skirmish_Lancer_Frigate", "Skirmish_Victory_Destroyer_Two", "Skirmish_Victory_Destroyer_Two", "Skirmish_Star_Destroyer", "Skirmish_Strike_Cruiser", "Skirmish_Strike_Cruiser", "Skirmish_Vigil", "Skirmish_Vigil", "Skirmish_IPV1_Teradoc", }
		
		local invaders = Find_Player("Hostile")
		
		local imps = SpawnList(invading_fleet_2, entry_marker, invaders, true, true)
	end
end

function Moar_Foes(message)
	if message == OnEnter then
		empire = Find_Player("Empire")
		rebels = Find_Player("Rebel")
		entry_marker = Find_First_Object("Attacker Entry Position")
		
		invading_fleet_3 = {"Skirmish_Secutor", "Skirmish_Interdictor_Cruiser", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer", "Skirmish_Carrack_Cruiser","Skirmish_Carrack_Cruiser", "Skirmish_Raider_Pentastar", "Skirmish_Lancer_Frigate", "Skirmish_Raider_Pentastar", "Skirmish_Star_Destroyer",  "Skirmish_Neutron_Star", "Skirmish_Broadside_Cruiser", "Skirmish_Broadside_Cruiser", }
		
		local invaders = Find_Player("Hostile")
		
		local imps = SpawnList(invading_fleet_3, entry_marker, invaders, true, true)
	end
end

function spawnFleet(param)
  local self = param[1]
  self.spawnList = SpawnList(param[2], param[3], param[4], true, true)
end
