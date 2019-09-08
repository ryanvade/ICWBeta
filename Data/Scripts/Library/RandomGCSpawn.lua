-- Spawns units at all neutral or hostile planets in a GC
function Spawn_At_All_Planets()

	local hostile = Find_Player("Hostile")
	local neutral = Find_Player("Neutral")
	local planet = nil
	local planet_settings = {}
	
	-- Possible spawning units
	-- Arranged as Unit_Table = {{Find_Object_Type("Unit_Name), weight}}
	Unit_Table = {{
					{Find_Object_Type("Generic_Venator"), 3, "Space"}
					,{Find_Object_Type("Lancer_Frigate"), 5, "Space"}
					,{Find_Object_Type("Escort_Carrier"), 5, "Space"}
					,{Find_Object_Type("Carrack_Cruiser"), 5, "Space"}
					,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Vindicator_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Katana_Dreadnaught_Empire"), 4, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer_Two"), 3, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
					,{Find_Object_Type("Generic_Dominator"), 1, "Space"}
					,{Find_Object_Type("MTC_Sensor"), 2, "Space"}
					,{Find_Object_Type("Imperial_Stormtrooper_Squad"), 5, "Land"}
					,{Find_Object_Type("Imperial_EWEB_Squad"), 4, "Land"}
					,{Find_Object_Type("Imperial_Anti_Infantry_Brigade"), 3, "Land"}
					,{Find_Object_Type("Imperial_Heavy_Scout_Squad"), 2, "Land"}
					,{Find_Object_Type("Imperial_Heavy_Assault_Company"), 1, "Land"}
				}
				
				,{
					{Find_Object_Type("Corona"), 5, "Space"}
					,{Find_Object_Type("Sacheen"), 5, "Space"}
					,{Find_Object_Type("Quaser"), 5, "Space"}
					,{Find_Object_Type("Nebulon_B-2_Frigate"), 5, "Space"}
					,{Find_Object_Type("Alliance_Assault_Frigate"), 4, "Space"}
					,{Find_Object_Type("Dreadnaught_Rebel"), 4, "Space"}
					,{Find_Object_Type("Endurance"), 1, "Space"}
					,{Find_Object_Type("Corellian_Corvette"), 5, "Space"}
					,{Find_Object_Type("Marauder_Missile_Cruiser"), 5, "Space"}
					,{Find_Object_Type("Nebula"), 1, "Space"}
					,{Find_Object_Type("Majestic"), 2, "Space"}
					,{Find_Object_Type("Viscount"), 0.05, "Space"}
					,{Find_Object_Type("MC90"), 1, "Space"}
					,{Find_Object_Type("MC80B"), 1, "Space"}
					,{Find_Object_Type("MC40a"), 3, "Space"}
					,{Find_Object_Type("Rebel_Infantry_Squad"), 3, "Land"}
					,{Find_Object_Type("Rebel_Tank_Buster_Squad"), 2, "Land"}
					,{Find_Object_Type("Rebel_Light_Tank_Brigade"), 1, "Land"}
					,{Find_Object_Type("Tracker_Company"), 1, "Land"}
					}

				,{
					{Find_Object_Type("Chaf_Destroyer"), 3, "Space"}
					,{Find_Object_Type("Kariek_Shieldship"), 5, "Space"}
					,{Find_Object_Type("Syndic_Destroyer"), 5, "Space"}
					,{Find_Object_Type("Phalanx_Destroyer"), 2, "Space"}
					,{Find_Object_Type("Peltast"), 2, "Space"}
					,{Find_Object_Type("Auriette_Carrier"), 4, "Space"}
					,{Find_Object_Type("Asdoni"), 5, "Space"}
					,{Find_Object_Type("Warlord"), 4, "Space"}
					,{Find_Object_Type("Nuruodo"), 3, "Space"}
					,{Find_Object_Type("Vigilance_Gunship"), 5, "Space"}
					,{Find_Object_Type("Phalanx_Trooper_Squad"), 5, "Land"}
					,{Find_Object_Type("EotH_Kirov_Brigade"), 2, "Land"}
					,{Find_Object_Type("MMT_Brigade"), 3, "Land"}
					,{Find_Object_Type("Flame_Tank_Company"), 1, "Land"}
					,{Find_Object_Type("RFT_Brigade"), 2, "Land"}
					,{Find_Object_Type("EotH_Scout_Brigade"), 3, "Land"}
					,{Find_Object_Type("Gilzean_Brigade"), 1, "Land"}
					}
					
				,{
					{Find_Object_Type("Tartan_Patrol_Cruiser"), 5, "Space"}
					,{Find_Object_Type("Carrack_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Vindicator_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Generic_Imperial_II_Frigate"), 4, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3, "Space"}
					,{Find_Object_Type("Storm_Command_Team"), 5, "Land"}
					,{Find_Object_Type("Delvardus_A6_Juggernaut_Company"), 2, "Land"}
					,{Find_Object_Type("Delvardus_Army_Trooper_Squad"), 5, "Land"}
					,{Find_Object_Type("Fortress_Company_Delvardus"), 3, "Land"}
					,{Find_Object_Type("Delvardus_IDT_Squad"), 2, "Land"}
					}
					
				,{
					{Find_Object_Type("Raider_Pentastar"), 3, "Space"}
					,{Find_Object_Type("Carrack_Cruiser"), 5, "Space"}
					,{Find_Object_Type("Strike_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Vindicator_Cruiser"), 4, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer_TWO"), 3, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer_Two"), 1, "Space"}
					,{Find_Object_Type("Generic_Star_Destroyer"), 1, "Space"}
					,{Find_Object_Type("Combat_Escort_Carrier"), 3, "Space"}
					,{Find_Object_Type("Shock_Soldier_Squad_Pentastar"), 4, "Land"}
					,{Find_Object_Type("Pentastar_Army_Trooper_Squad"), 5, "Land"}
					,{Find_Object_Type("Pentastar_Walker_Group"), 2, "Land"}
					,{Find_Object_Type("Pentastar_Repulsor_Scout_Group"), 4, "Land"}
					,{Find_Object_Type("Pentastar_Speeder_Group"), 1, "Land"}
					}
				,{
					{Find_Object_Type("Citadel_Cruiser_Squadron"), 4, "Space"}
					,{Find_Object_Type("Gozanti_Cruiser_Squadron"), 5, "Space"}
					,{Find_Object_Type("Recusant"), 4, "Space"}
					,{Find_Object_Type("Generic_Victory_Destroyer"), 3, "Space"}
					,{Find_Object_Type("Bulwark_I"), 3, "Space"}
					,{Find_Object_Type("Invincible_Cruiser"), 1, "Space"}
					,{Find_Object_Type("Espo_Squad"), 4, "Land"}
					,{Find_Object_Type("Strikebreaker_Group"), 5, "Land"}
					,{Find_Object_Type("JX40_Group"), 2, "Land"}
					,{Find_Object_Type("SX20_Company"), 4, "Land"}
					,{Find_Object_Type("X10_Group"), 1, "Land"}
					}
	}
	
	Groundbase_Table = {{
					Find_Object_Type("E_Ground_Barracks"),
					Find_Object_Type("E_Ground_Light_Vehicle_Factory"),					
					Find_Object_Type("E_Ground_Heavy_Vehicle_Factory"),					
				}
				
				,{
					Find_Object_Type("R_Ground_Barracks"),
					Find_Object_Type("R_Ground_Light_Vehicle_Factory"),
					Find_Object_Type("R_Ground_Heavy_Vehicle_Factory"),
					}

				,{
					Find_Object_Type("U_Ground_Barracks"),
					Find_Object_Type("U_Ground_Droid_Works"),
					Find_Object_Type("U_Ground_Vehicle_Factory"),
					}
					
				,{
					Find_Object_Type("A_Ground_Barracks"),
					Find_Object_Type("A_Ground_Light_Vehicle_Factory"),
					Find_Object_Type("A_Ground_Heavy_Vehicle_Factory"),
					}
				
				,{
					Find_Object_Type("P_Ground_Barracks"),
					Find_Object_Type("P_Ground_Light_Vehicle_Factory"),
					Find_Object_Type("P_Ground_Heavy_Vehicle_Factory"),
					}
					
				,{
					Find_Object_Type("C_Ground_Barracks"),
					Find_Object_Type("C_Ground_Light_Vehicle_Factory"),
					Find_Object_Type("C_Ground_Heavy_Vehicle_Factory"),
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
			random_table_index = GameRandom.Free_Random(1, 6)
			
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
	
	planet.Change_Owner(player)

	DebugMessage("%s -- Attempting to spawn units at %s", tostring(Script), tostring(planet))
	-- empty spawn table
	local spawn_table = {}
	
	-- Create distribution to sample from
	local distribution_space = DiscreteDistribution.Create()
	local distribution_land = DiscreteDistribution.Create()
	
	-- Add units to distributions
	for _, possible_spawn in pairs(unit_spawn_table) do
	
		if (possible_spawn[1].Is_Affiliated_With(player) or ignore_affiliation) and possible_spawn[3] == "Space" then
			--Insert unit into distribution
			distribution_space.Insert(possible_spawn[1], possible_spawn[2])				
		end
		
		if (possible_spawn[1].Is_Affiliated_With(player) or ignore_affiliation) and possible_spawn[3] == "Land" then
			--Insert unit into distribution
			distribution_land.Insert(possible_spawn[1], possible_spawn[2])				
		end
	end
	
	--Add units to the spawn table
	SpawnTableInsert(total_combat_power, 5, distribution_space, spawn_table, false)
	SpawnTableInsert(total_combat_power/10, 3, distribution_land, spawn_table, true)
	
	-- spawn the units!
	SpawnGroundBase(player, planet, random_table_index)
	SpawnListType(spawn_table, planet, player)
	return
end

-- Insert units into the spawn table
-- In: combat value for the units, number of units, distribution of units, 
-- the spawn_table to fill, and boolean for land/space
function SpawnTableInsert(combat_value, count, distribution, spawn_table, land)
	
	local total_count = 0
	
	local combat_value_to_spawn = combat_value/count
	
	local combat_value_j = 0
	
	while combat_value_j <= combat_value do	
	
		if land and total_count > 5 then
			break
		end
		
		unit, unitcount = Select_Spawn_Unit(player, combat_value_to_spawn, distribution)
			
		if not unit then
			DebugMessage("%s -- Error! unit not found!", tostring(Script))
		end
		-- add up to count of the same unit from the Select_Spawn_Unit function
		local j = 0
		while j < unitcount do
			table.insert(spawn_table, unit)
			j = j + 1
		end
		combat_value_j = combat_value_j + combat_value_to_spawn
		total_count = total_count + unitcount

	end
	
	return
end

-- choose spawn units from a distribution based on combat power
-- In: playerobject, combat power desired, discrete distribution of units
function Select_Spawn_Unit(player, combat_value, distribution, space)
	local space = false
	local cap = GameRandom.Free_Random(1, 3)
	-- sample the distribution to pick a unit (hopefully random)
	local spawn_unit = distribution.Sample()
	
	-- none found?
	if not spawn_unit then 
		return nil
	end
	
	-- Get a number of the units based on their combat rating
	local spawn_count = combat_value / spawn_unit.Get_Combat_Rating()
	
	-- cap the spawn count at either 1 or 5 if space, or 3 (default) if land
	if space then
		cap = 5
	end
	
	if spawn_count < 1 then 
		spawn_count = 1
	elseif spawn_count > cap then
		spawn_count = cap
	end
	
	DebugMessage("%s -- Chosen %d of %s to spawn", tostring(Script), spawn_count, tostring(spawn_unit.Get_Name()))
	
	-- return the spawn unit and count
	return spawn_unit, spawn_count

end

-- Simple spawn function that can use the found object list instead of the name list
-- In: List of gameobjects, location, playerobject
function SpawnListType(type_list, entry_marker, player)
		
	for _, unit_type in pairs(type_list) do
		new_units = Spawn_Unit(unit_type, entry_marker, player)
		for _, unit in pairs(new_units) do
			unit.Prevent_AI_Usage(false)
		end
	end
	
	new_units = nil
	return
end

-- Spawns groundbase for player
-- In: playerobject, planet to spawn at, table index to get ground bases from
function SpawnGroundBase(player, planet, index)

	local base_table = Groundbase_Table[index]

	local base_level = EvaluatePerception("MaxGroundbaseLevel", player, planet)
	
	if base_level == nil then
		return
	end
	
	if base_level < 1 then
		return
	else
		local m = 0
		while m < base_level/2 do
		    building = base_table[GameRandom.Free_Random(1,3)]
			Spawn_Unit(building, planet, player)
			m = m + 1
		end
	end
	
	return
end