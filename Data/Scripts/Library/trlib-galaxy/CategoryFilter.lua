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
--*   @Author:              [TR]Pox <Pox>
--*   @Date:                2018-01-13T11:47:17+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            CategoryFilter.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-27T03:41:19+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("PGSpawnUnits")
require("trlib-std/class")

CategoryFilter = class()

---@param galacticConquest GalacticConquest
---@param ai_dummy_handler AiDummyLifeCycleHandler
function CategoryFilter:new(plot, galacticConquest, ai_dummy_handler)
    self.EventNames = {
        "Filter_Non_Capital",
        "Filter_Capitals",
        "Filter_Structures",
        "Filter_Story"
    }

    self.CategoryFlags = {
        ["SELECT_NON_CAPITAL"] = "Non_Capital_Category_Dummy",
        ["SELECT_CAPITAL"] = "Capital_Category_Dummy",
        ["SELECT_STRUCTURE"] = "Structure_Category_Dummy",
        ["SELECT_STORY"] = "Story_Category_Dummy"
    }

    self.Placeholder = "Placeholder_Category_Dummy"

    self.ActiveFilter = "SELECT_NON_CAPITAL"

    self.SpawnedHumanDummies = {}

    self.GalacticConquest = galacticConquest
    self.GalacticConquest.Events.SelectedPlanetChanged:AttachListener(self.SpawnCategoryDummy, self)
    self.GalacticConquest.Events.PlanetOwnerChanged:AttachListener(self.OnPlanetOwnerChanged, self)

    for _, eventName in pairs(self.EventNames) do
        local event = plot.Get_Event(eventName)
        if event then
            event.Set_Reward_Parameter(1, galacticConquest.HumanPlayer.Get_Faction_Name())
        end
    end

    ai_dummy_handler:add_to_ai_dummy_set {
        Non_Capital_Category_Dummy = 1,
        Capital_Category_Dummy = 1,
        Structure_Category_Dummy = 1,
        Story_Category_Dummy = 1
    }

end

function CategoryFilter:Update()
    self:HandleFilterChange()
end

function CategoryFilter:HandleFilterChange()
    for categoryFlag, _ in pairs(self.CategoryFlags) do
        if Check_Story_Flag(self.GalacticConquest.HumanPlayer, categoryFlag, nil, true) then
            if self.ActiveFilter == categoryFlag then
                break
            end
            self.ActiveFilter = categoryFlag
            self:SpawnCategoryDummy(self.GalacticConquest:GetSelectedPlanet())
            break
        end
    end
end

function CategoryFilter:OnPlanetOwnerChanged(planet)
    if not planet then
        return
    end

    if planet:get_owner().Is_Human() then
        if planet == self.GalacticConquest:GetSelectedPlanet() then
            self:SpawnCategoryDummy(self.GalacticConquest:GetSelectedPlanet())
        end
    end
end

function CategoryFilter:SpawnCategoryDummy(selectedPlanet)
    self:ClearDummies()

    if not selectedPlanet then
        return
    end

    if not selectedPlanet:get_owner().Is_Human() then
        return
    end

    if not self.ActiveFilter then
        return
    end

    local typeList = {
        self.CategoryFlags[self.ActiveFilter],
        self.Placeholder,
        self.Placeholder,
        self.PlaceHolder
    }

    local dummies =
        SpawnList(typeList, selectedPlanet:get_game_object(), self.GalacticConquest.HumanPlayer, false, false)
end


function CategoryFilter:ClearDummies()
    local dummies = nil
    for _, dummyType in pairs(self.CategoryFlags) do
        dummies = Find_All_Objects_Of_Type(dummyType)
        for _, dummy in pairs(dummies) do
            if TestValid(dummy) and dummy.Get_Owner().Is_Human() then
                dummy.Despawn()
            end
        end
    end

    dummies = Find_All_Objects_Of_Type(self.Placeholder)
    for _, dummy in pairs(dummies) do
        if TestValid(dummy) and dummy.Get_Owner().Is_Human() then
            dummy.Despawn()
        end
    end
end


return CategoryFilter
