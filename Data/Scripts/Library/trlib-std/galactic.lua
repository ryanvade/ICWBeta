TRlib.galactic = {}

function TRlib.galactic.find_friendly_planet(player)
    if type(player) == "string" then
        player = Find_Player(player)
    end

    local allPlanets = TRlib.internal.get_all_planets_without_dummies()

    local random = 0
    local planet = nil

    while table.getn(allPlanets) > 0 do
        random = GameRandom(1, table.getn(allPlanets))
        planet = allPlanets[random]
        table.remove(allPlanets, random)

        if planet.Get_Owner() == player then
            return planet
        end
    end

    return nil
end

function TRlib.internal.get_all_planets_without_dummies()
    local allPlanets = FindPlanet.Get_All_Planets()

    for i, p in pairs(allPlanets) do
        if p == FindPlanet("Dummy_Empire") or p == FindPlanet("Dummy_Rebel") or p == FindPlanet("Dummy_EotH") then
            table.remove(allPlanets, i)
        end
    end

    return allPlanets
end
