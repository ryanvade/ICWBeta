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
--*   @Date:                2018-03-10T03:05:37+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GalacticConquest.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-10T19:27:15+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGSpawnUnits")
require("trlib-util/StoryUtil")
require("trlib-std/class")
require("trlib-std/ModContentLoader").get("GovernmentManager")
require("trlib-galaxy/GalacticEvents")
require("trlib-galaxy/Planet")

GalacticConquest = class()
function GalacticConquest:new(player_agnostic_plot, playableFactions)
    self.HumanPlayer = self:FindHumanPlayerInTable(playableFactions)

    self.Governments = GovernmentManager()

    self.Planets = self:GetPlanets()
    self:InitializeEvents(player_agnostic_plot)
    self.LastCycleTime = 0

    self.Events = {
        SelectedPlanetChanged = SelectedPlanetChangedEvent(self.HumanPlayer, self.Planets),
        PlanetOwnerChanged = PlanetOwnerChangedEvent(self.Planets),
        GalacticProductionStarted = ProductionStartedEvent(self.Planets),
        GalacticProductionFinished = ProductionFinishedEvent(self.Planets),
        GalacticProductionCanceled = ProductionCanceledEvent(self.Planets),
        GalacticWeekChanged = GalacticWeekChangedEvent(self.Player),
        GalacticHeroKilled = GalacticHeroKilledEvent(),
        TacticalBattleStarting = TacticalBattleStartingEvent(),
        TacticalBattleEnding = TacticalBattleEndingEvent(),
        IncomingFleet = IncomingFleetEvent(self.Planets)
    }
end

function GalacticConquest:Update()
    self.Events.SelectedPlanetChanged:Check()
    self.Events.PlanetOwnerChanged:Check()
    self.Events.GalacticProductionStarted:Check()
    self.Events.GalacticProductionFinished:Check()
    self.Events.GalacticProductionCanceled:Check()
    self.Events.GalacticHeroKilled:Check()
    self.Events.TacticalBattleStarting:Check()
    self.Events.TacticalBattleEnding:Check()
    self.Events.IncomingFleet:Check()
    self.Governments:Update()
    local current = GetCurrentTime()
    if current - self.LastCycleTime >= 40 then
        for _, planet in pairs(self.Planets) do
            planet:update_influence_information()
        end
        self.LastCycleTime = current
    end
end

function GalacticConquest:GetSelectedPlanet()
    local selectedPlanetName = GlobalValue.Get("SELECTED_PLANET")
    if not StoryUtil.ValidGlobalValue(selectedPlanetName) then
        return nil
    end

    return self.Planets[selectedPlanetName]
end

function GalacticConquest:FindHumanPlayerInTable(factions)
    for _, faction in pairs(factions) do
        local player = Find_Player(faction)
        if player.Is_Human() then
            return player
        end
    end
end

function GalacticConquest:InitializeEvents(plot)
    for _, planet in pairs(self.Planets) do
        local planetName = planet:get_name()
        local event = plot.Get_Event("Zoom_Into_" .. planetName)
        if event then
            event.Set_Reward_Parameter(1, self.HumanPlayer.Get_Faction_Name())
        end
    end
end

function GalacticConquest:GetPlanets()
    local all_planets = FindPlanet.Get_All_Planets()

    local planets = {}
    for _, planet in pairs(all_planets) do
        local planet_name = planet.Get_Type().Get_Name()
        planets[planet_name] = Planet(planet_name)
    end

    return planets
end

return GalacticConquest
