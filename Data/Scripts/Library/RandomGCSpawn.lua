-- Spawns units at all neutral or hostile owned planets in a list
-- In: planet array in the form { ["Planet Name"] = {Faction_Table_Name, Combat Power} }
function Spawn_At_Planets(planet_list)

	local hostile = Find_Player("Hostile")
	local neutral = Find_Player("Neutral")
	local planet = nil
	local planet_settings = {}
	
	-- Possible spawning units
	-- Arranged as Unit_Table = {["Faction_Table_Name"] = {Find_Object_Type("Unit_Name), weight}}
	Unit_Table = {
	["Empire_Unit_Table"] = {
					{Find_Object_Type("Generic_Venator"), 3}
					,{Find_Object_Type("Lancer_Frigate"), 5}
					,{Find_Object_Type("Escort_Carrier"), 5}
					,{Find_Object_Type("Carrack_Cruiser"), 5}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Katana_Dreadnaught_Empire"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Generic_Dominator"), 1}
					,{Find_Object_Type("MTC_Sensor"), 2}
					,{Find_Object_Type("Imperial_Stormtrooper_Squad"), 5}
					,{Find_Object_Type("Imperial_EWEB_Squad"), 4}
					,{Find_Object_Type("Imperial_Anti_Infantry_Brigade"), 3}
					,{Find_Object_Type("Imperial_Heavy_Scout_Squad"), 2}
					,{Find_Object_Type("Imperial_Heavy_Assault_Company"), 1}
					
				}
				
	,["NR_Unit_Table"] = {
					{Find_Object_Type("Corona"), 1}
					,{Find_Object_Type("Sacheen"), 1}
					,{Find_Object_Type("Quaser"), 1}
					,{Find_Object_Type("Alliance_Assault_Frigate"), 1}
					,{Find_Object_Type("Dreadnaught_Rebel"), 1}
					,{Find_Object_Type("Endurance"), 1}
					,{Find_Object_Type("Corellian_Corvette"), 1}
					,{Find_Object_Type("Nebula"), 1}
					,{Find_Object_Type("Majestic"), 1}
					,{Find_Object_Type("Viscount"), 1}
					,{Find_Object_Type("MC90"), 1}
					,{Find_Object_Type("MC80B"), 1}
					,{Find_Object_Type("MC40a"), 1}
					,{Find_Object_Type("Rebel_Infantry_Squad"), 1}
					,{Find_Object_Type("Rebel_Tank_Buster_Squad"), 1}
					,{Find_Object_Type("Rebel_Light_Tank_Brigade"), 1}
					,{Find_Object_Type("Tracker_Company"), 1}
					}

	,["EotH_Unit_Table"] = {
					{Find_Object_Type("Chaf_Destroyer"), 3}
					,{Find_Object_Type("Kariek_Shieldship"), 5}
					,{Find_Object_Type("Syndic_Destroyer"), 5}
					,{Find_Object_Type("Phalanx_Destroyer"), 2}
					,{Find_Object_Type("Intego_Destroyer"), 2}
					,{Find_Object_Type("Peltast"), 2}
					,{Find_Object_Type("Auriette_Carrier"), 4}
					,{Find_Object_Type("Asdoni"), 5}
					,{Find_Object_Type("Warlord"), 4}
					,{Find_Object_Type("Nuruodo"), 3}
					,{Find_Object_Type("Vigilance_Gunship"), 5}
					,{Find_Object_Type("Phalanx_Trooper_Squad"), 1}
					,{Find_Object_Type("EotH_Kirov_Brigade"), 1}
					,{Find_Object_Type("MMT_Brigade"), 1}
					,{Find_Object_Type("Flame_Tank_Company"), 1}
					,{Find_Object_Type("RFT_Brigade"), 1}
					,{Find_Object_Type("EotH_Scout_Brigade"), 1}
					,{Find_Object_Type("Gilzean_Brigade"), 1}
					}
					
	,["Eriadu_Unit_Table"] = {
					{Find_Object_Type("Tartan_Patrol_Cruiser"), 5}
					,{Find_Object_Type("Carrack_Cruiser"), 4}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3}
					,{Find_Object_Type("Storm_Command_Team"), 1}
					,{Find_Object_Type("Delvardus_A6_Juggernaut_Company"), 1}
					,{Find_Object_Type("Delvardus_Army_Trooper_Squad"), 1}
					,{Find_Object_Type("Fortress_Company_Delvardus"), 1}
					,{Find_Object_Type("Delvardus_IDT_Squad"), 1}
					}
					
	,["Pentastar_Unit_Table"] = {
					{Find_Object_Type("Raider_Pentastar"), 3}
					,{Find_Object_Type("Carrack_Cruiser"), 5}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3}
					,{Find_Object_Type("Shock_Soldier_Squad_Pentastar"), 1}
					,{Find_Object_Type("Pentastar_Army_Trooper_Squad"), 1}
					,{Find_Object_Type("Pentastar_Walker_Group"), 1}
					,{Find_Object_Type("Pentastar_Skiff_Group"), 1}
					,{Find_Object_Type("Pentastar_Speeder_Group"), 1}
					}
	}
	
	DebugMessage("%s -- Initializing spawning", tostring(Script))
	-- Find all planets
		
	-- Loop through planets once, spawning units
	for planet, planet_settings in pairs(planet_list) do
		-- Pirate unit spawns
		if FindPlanet(planet).Get_Owner() == (neutral or hostile) then
			--Spawns random units at the planet for the given faction and combat power per planet
			Spawn_Random_Units(Unit_Table[planet_settings[1]], FindPlanet(planet), hostile, planet_settings[2], true)
		end
	end
end

-- Spawns units at all neutral or hostile planets in a GC
function Spawn_At_All_Planets()

	local hostile = Find_Player("Hostile")
	local neutral = Find_Player("Neutral")
	local planet = nil
	local planet_settings = {}
	
	-- Possible spawning units
	-- Arranged as Unit_Table = {{Find_Object_Type("Unit_Name), weight}}
	Unit_Table = {{
					{Find_Object_Type("Generic_Venator"), 3}
					,{Find_Object_Type("Lancer_Frigate"), 5}
					,{Find_Object_Type("Escort_Carrier"), 5}
					,{Find_Object_Type("Carrack_Cruiser"), 5}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Katana_Dreadnaught_Empire"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Generic_Star_Destroyer"), 1}
					,{Find_Object_Type("Generic_Dominator"), 1}
					,{Find_Object_Type("MTC_Sensor"), 2}
					,{Find_Object_Type("Imperial_Stormtrooper_Squad"), 2}
					,{Find_Object_Type("Imperial_EWEB_Squad"), 1}
					,{Find_Object_Type("Imperial_Anti_Infantry_Brigade"), 1}
					,{Find_Object_Type("Imperial_Heavy_Scout_Squad"), 1}
					,{Find_Object_Type("Imperial_Heavy_Assault_Company"), 1}
					}
				
				,{
					{Find_Object_Type("Corona"), 5}
					,{Find_Object_Type("Sacheen"), 5}
					,{Find_Object_Type("Quaser"), 5}
					,{Find_Object_Type("Nebulon_B-2_Frigate"), 5}
					,{Find_Object_Type("Alliance_Assault_Frigate"), 4}
					,{Find_Object_Type("Dreadnaught_Rebel"), 4}
					,{Find_Object_Type("Endurance"), 1}
					,{Find_Object_Type("Corellian_Corvette"), 5}
					,{Find_Object_Type("Marauder_Missile_Cruiser"), 5}
					,{Find_Object_Type("Nebula"), 1}
					,{Find_Object_Type("Majestic"), 2}
					,{Find_Object_Type("Viscount"), 0.05}
					,{Find_Object_Type("MC90"), 1}
					,{Find_Object_Type("MC80B"), 1}
					,{Find_Object_Type("MC40a"), 3}
					,{Find_Object_Type("Rebel_Infantry_Squad"), 1}
					,{Find_Object_Type("Rebel_Tank_Buster_Squad"), 1}
					,{Find_Object_Type("Rebel_Light_Tank_Brigade"), 1}
					,{Find_Object_Type("Tracker_Company"), 1}
					}

				,{
					{Find_Object_Type("Chaf_Destroyer"), 3}
					,{Find_Object_Type("Kariek_Shieldship"), 5}
					,{Find_Object_Type("Syndic_Destroyer"), 5}
					,{Find_Object_Type("Phalanx_Destroyer"), 2}
					,{Find_Object_Type("Intego_Destroyer"), 2}
					,{Find_Object_Type("Peltast"), 2}
					,{Find_Object_Type("Auriette_Carrier"), 4}
					,{Find_Object_Type("Asdoni"), 5}
					,{Find_Object_Type("Warlord"), 4}
					,{Find_Object_Type("Nuruodo"), 3}
					,{Find_Object_Type("Vigilance_Gunship"), 5}
					,{Find_Object_Type("Phalanx_Trooper_Squad"), 1}
					,{Find_Object_Type("EotH_Kirov_Brigade"), 1}
					,{Find_Object_Type("MMT_Brigade"), 1}
					,{Find_Object_Type("Flame_Tank_Company"), 1}
					,{Find_Object_Type("RFT_Brigade"), 1}
					,{Find_Object_Type("EotH_Scout_Brigade"), 1}
					,{Find_Object_Type("Gilzean_Brigade"), 1}
					}
					
				,{
					{Find_Object_Type("Tartan_Patrol_Cruiser"), 5}
					,{Find_Object_Type("Carrack_Cruiser"), 4}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3}
					,{Find_Object_Type("Storm_Command_Team"), 1}
					,{Find_Object_Type("Delvardus_A6_Juggernaut_Company"), 1}
					,{Find_Object_Type("Delvardus_Army_Trooper_Squad"), 1}
					,{Find_Object_Type("Fortress_Company_Delvardus"), 1}
					,{Find_Object_Type("Delvardus_IDT_Squad"), 1}
					}
					
				,{
					{Find_Object_Type("Raider_Pentastar"), 3}
					,{Find_Object_Type("Carrack_Cruiser"), 5}
					,{Find_Object_Type("Strike_Cruiser"), 4}
					,{Find_Object_Type("Vindicator_Cruiser"), 4}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3}
					,{Find_Object_Type("Shock_Soldier_Squad_Pentastar"), 1}
					,{Find_Object_Type("Pentastar_Army_Trooper_Squad"), 1}
					,{Find_Object_Type("Pentastar_Walker_Group"), 1}
					,{Find_Object_Type("Pentastar_Skiff_Group"), 1}
					,{Find_Object_Type("Pentastar_Speeder_Group"), 1}
					}
	}
	
	DebugMessage("%s -- Initializing spawning", tostring(Script))
	if hostile.Get_Difficulty() == "Easy" then
		Difficulty_Modifier = 0.75
	elseif hostile.Get_Difficulty() == "Hard" then
		Difficulty_Modifier = 1.5
	else
		Difficulty_Modifier = 1.0
	end
		
	-- Loop through	all planets once, spawning units
	for _, planet in pairs(FindPlanet.Get_All_Planets()) do
		-- Hostile unit spawns
		if planet.Get_Owner() == (neutral or hostile) then	
		
			-- Scaled combat power based on planet value, reduced by if connected to a player, then increased or decreased by difficulty level
			scaled_combat_power = 20000 * EvaluatePerception("GenericPlanetValue", hostile, planet) * (1.5 - EvaluatePerception("Is_Connected_To_Player", hostile, planet)) * Difficulty_Modifier
			-- pick a random unit selection table
			random_table_index = GameRandom.Free_Random(1, 4)
			
			DebugMessage("%s -- Attempting to spawn units at %s, from table number %s, combat power %s, difficulty modifier %s", tostring(Script), tostring(planet), tostring(random_table_index), tostring(scaled_combat_power), tostring(Difficulty_Modifier))
			-- Spawns random units at the planet for the given faction and combat power per planet
			Spawn_Random_Units(Unit_Table[random_table_index], planet, hostile, scaled_combat_power, true)
		end
	end
end

-- Spawns random units at a given planet for a given player, up to a maximum combat power
-- In: unit table to spawn from, planet location, playerobject, combat power to spawn at planet, ignore the affiliation of units in the table
function Spawn_Random_Units(unit_spawn_table, planet, player, total_combat_power, ignore_affiliation)

	if not unit_spawn_table or not planet or not player or not total_combat_power then
		DebugMessage("%s -- Expected arguments: spawn table, planet, playerobject, combat power. Got %s, %s, %s, %s instead", tostring(Script), tostring(unit_spawn_table), tostring(planet), tostring(player), tostring(total_combat_power))
		return
	end

	DebugMessage("%s -- Attempting to spawn units at %s", tostring(Script), tostring(planet))
	-- empty spawn table
	local spawn_table = {}
	
	-- Create distribution to sample from
	local distribution = DiscreteDistribution.Create()
	
	-- Add units to distribution based on tech level
	for _, possible_spawn in pairs(unit_spawn_table) do
	
		if possible_spawn[1].Is_Affiliated_With(player) or ignore_affiliation then
			--Insert unit into distribution
			distribution.Insert(possible_spawn[1], possible_spawn[2])				
		end
	end
	
	-- initialize combat power iterator
	-- designed to produce 5 chunks of equally powerful unit spawns
	local combat_value_j = total_combat_power/5
	local combat_value = total_combat_power/5
	
	-- loop through possible units and add them to the spawn table
	while combat_value_j < total_combat_power do
		unit, count = Select_Spawn_Unit(player, combat_value, distribution)
		if not unit then
			DebugMessage("%s -- Error! unit not found!", tostring(Script))
		end
		-- add up to count of the same unit from the Select_Spawn_Unit function
		j = 0
		while j < count do
			table.insert(spawn_table, unit)
			j = j + 1
		end
		combat_value_j = combat_value_j + combat_value
	end
	
	-- spawn the units!
	SpawnListType(spawn_table, planet, player)
	return
end

-- choose spawn units from a distribution based on combat power
-- In: playerobject, combat power desired, discrete distribution of units
function Select_Spawn_Unit(player, combat_value, distribution)
	
	-- sample the distribution to pick a unit (hopefully random)
	local spawn_unit = distribution.Sample()
	
	-- none found?
	if not spawn_unit then 
		return nil
	end
	
	-- Get a number of the units based on their combat rating
	local spawn_count = combat_value / spawn_unit.Get_Combat_Rating()
	
	-- cap the spawn count at either 1 or 5
	if spawn_count < 1 then 
		spawn_count = 1
	elseif spawn_count > 5 then
		spawn_count = 5
	end
	
	DebugMessage("%s -- Chosen %d of %s to spawn", tostring(Script), spawn_count, tostring(spawn_unit.Get_Name()))
	
	-- return the spawn unit and count
	return spawn_unit, spawn_count

end

-- Simple spawn function that can use the found object list instead of the name list
-- In: List of gameobjects, location, playerobject
function SpawnListType(type_list, entry_marker, player)
		
	for k, unit_type in pairs(type_list) do
		new_units= Spawn_Unit(unit_type, entry_marker, player)
	end
	
	new_units = nil
	return
end