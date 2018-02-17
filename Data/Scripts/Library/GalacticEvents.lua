require("Class")
require("Util")
require("Observable")

PlanetOwnerChangedEvent = Class {
    Extends = Observable,
    Check = function(self)
        local planetOwnerChangedData = GlobalValue.Get("PLANET_OWNER_CHANGED")
        if ValidGlobalValue(planetOwnerChangedData) then
            self:Notify(FindPlanet(planetOwnerChangedData))
            GlobalValue.Set("PLANET_OWNER_CHANGED", "")
        end
    end
}

ProductionFinishedEvent = Class {
    Extends = Observable,
    Check = function(self)
        local productionPlanet = GlobalValue.Get("PRODUCTION_FINISHED")
        if ValidGlobalValue(productionPlanet) then
            self:Notify(FindPlanet(productionPlanet))
            GlobalValue.Set("PRODUCTION_FINISHED", "")
        end
    end
}

SelectedPlanetChangedEvent = Class {
    Extends = Observable,
    Constructor = function(self, player)
        self.Player = player
    end,

    Check = function(self)
        local allPlanets = FindPlanet.Get_All_Planets()
        for i, planet in pairs(allPlanets) do
            if Check_Story_Flag(self.Player, "ZOOMED_INTO_"..planet.Get_Type().Get_Name(), nil, true) then
                GlobalValue.Set("SELECTED_PLANET", planet.Get_Type().Get_Name())
                self:Notify(planet)
                break
            end
        end
    end
}
