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
--*   @Author:              [TR]Pox
--*   @Date:                2018-03-10T01:31:48+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GalacticEvents.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:30:51+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Class")
require("TRUtil")
require("Observable")

PlanetOwnerChangedEvent = Class {
    Extends = Observable;
    Constructor = function(self, planets)
        self.Planets = planets
    end;
    Check = function(self)
        local planetOwnerChangedData = GlobalValue.Get("PLANET_OWNER_CHANGED")
        if TRUtil.ValidGlobalValue(planetOwnerChangedData) then
            local planet = self.Planets[planetOwnerChangedData]
            self:Notify(planet)
            GlobalValue.Set("PLANET_OWNER_CHANGED", "")
        end
    end
}

ProductionFinishedEvent = Class {
    Extends = Observable;
    Constructor = function(self, planets)
        self.Planets = planets
    end;
    Check = function(self)
        local productionPlanet = GlobalValue.Get("PRODUCTION_FINISHED")
        if TRUtil.ValidGlobalValue(productionPlanet) then
            local planet = self.Planets[productionPlanet]
            self:Notify(planet)
            GlobalValue.Set("PRODUCTION_FINISHED", "")
        end
    end
}

SelectedPlanetChangedEvent = Class {
    Extends = Observable,
    Constructor = function(self, player, planets)
        self.Player = player
        self.Planets = planets
    end,

    Check = function(self)
        for _, planet in pairs(self.Planets) do
            if Check_Story_Flag(self.Player, "ZOOMED_INTO_"..planet:get_name(), nil, true) then
                GlobalValue.Set("SELECTED_PLANET", planet:get_name())
                self:Notify(planet)
                break
            end
        end
    end
}

GalacticWeekChangedEvent = Class {
    Extends = Observable,
    Constructor = function(self, player)
        self.Player = player
    end,

    Check = function(self)
        if Check_Story_Flag(self.Player, "GALACTIC_CYCLE_ELAPSED", nil, true) then
            self:Notify()
        end
    end
}
