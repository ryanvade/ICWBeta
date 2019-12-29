function RegisterEmpireEvents()
    RegisterEmpireEvents_New()
    RegisterEmpireRewards()
end

function RegisterEmpireEvents_New()
    Event("Universal_Story_Start"):
    When(Always()):
    End()
end

function RegisterEmpireRewards()
    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Trasi")
        local empire = Find_Player("Empire")
        Spawn_Unit(Find_Object_Type("Elite_Squadron"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("Implacable_Star_Destroyer"), spawnPlanet, empire)
		
		local spawnPlanet = FindPlanet("Orinda")
        Spawn_Unit(Find_Object_Type("Corrupter_Star_Destroyer"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("Reckoning_Star_Destroyer"), spawnPlanet, empire)
    end)
   
end

