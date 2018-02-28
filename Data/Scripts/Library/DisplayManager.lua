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
--*   @Date:                2017-12-22T10:19:56+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            DisplayManager.lua
-- @Last modified by:   marcus
-- @Last modified time: 2018-02-27T20:15:35+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Class")
require("GameGlobals")
require("StoryEvents")
require("DisplayStructuresUtilities")

OrbitalStructureDisplay = Class {
    CurrentText = {},

    Constructor = function(self)
        GLOBALS.Events.SelectedPlanetChanged:AttachListener(self.Update, self)
        GLOBALS.Events.GalacticProductionFinished:AttachListener(self.Update, self)
    end,

    Update = function(self, planet)
        if planet ~= GLOBALS.GetSelectedPlanet() then
            return
        end

        local owner = planet.Get_Owner()
        local ownerName = owner.Get_Faction_Name()
        local color = GLOBALS.FACTION_COLORS[ownerName]

        self:Clear()

        GLOBALS.ShowScreenText("TEXT_SELECTED_PLANET", -1, planet, color)
        self.CurrentText = {"TEXT_SELECTED_PLANET"}

        -- if not planet.Get_Owner().Is_Human() then
        --   return
        -- end

        local structuresOnPlanet = FindFriendlyStructuresOnPlanet(planet)

        for structureText, amount in pairs(structuresOnPlanet) do
            table.insert(self.CurrentText, structureText)
            local number = GameObjectNumber(amount)
            if number then
                GLOBALS.ShowScreenText(structureText, -1, number, color)
            end
        end
    end,

    Clear = function(self)
        for _, text in pairs(self.CurrentText) do
            GLOBALS.RemoveScreenText(text)
        end
    end
}

return OrbitalStructureDisplay
