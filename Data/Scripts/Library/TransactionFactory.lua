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
--*   @Date:                2018-03-13T15:48:34+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            TransactionFactory.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-19T23:23:12+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************




function CreateSpawnTransaction(object_string, owner_string)
    return {
        object_string = object_string,
        owner_string = owner_string,
        execute = function(self)
            if not ownerTable then
                return
            end

            if not ownerTable[self.owner_string] then
                ownerTable[self.owner_string] = self:findFriendlyPlanet(self.owner_string)
            end

            local objectType = Find_Object_Type(self.object_string)
            local location = ownerTable[self.owner_string]
            local player = Find_Player(self.owner_string)
            Spawn_Unit(objectType, location, player)

            if player.Is_Human() then
                require("TRUtil")
                TRUtil.ShowScreenText("TEXT_SINGLE_UNIT_RETREAT_PLANET", 5, ownerTable[self.owner_string], {r=255, g=255, b=255})
            end

        end,

        findFriendlyPlanet = function(self, playerString)
            local player = Find_Player(playerString)
            local allPlanets = FindPlanet.Get_All_Planets()
            local random = GameRandom(1, table.getn(allPlanets))
            local planet = allPlanets[random]
            while planet.Get_Owner() ~= player do
                random = GameRandom(1, table.getn(allPlanets))
                planet = allPlanets[random]
				while planet == FindPlanet("Dummy_Empire") or planet == FindPlanet("Dummy_Rebel") or planet == FindPlanet("Dummy_EotH") do
					planet = allPlanets[random]
				end
            end
            return planet
        end
    }
end

function CreateBoardingTransaction(object_string, owner_string)
    return {
        object_string = object_string,
        owner_string = owner_string,
        execute = function(self)
            local firstEntry = self:findFirstFriendlyUnit(self.object_string)
            if not TestValid(firstEntry) then
                return
            end

            firstEntry.Despawn()
            require("TransactionFactory")
            local transaction = CreateSpawnTransaction(self.object_string, self.owner_string)

            if not TM then
                TransactionManager = require("TransactionManager")
                TM = TransactionManager:New()
            end

            TM:RegisterGameModeTransaction(transaction)
        end,

        findFirstFriendlyUnit = function(self, type)
          local typeUnits = Find_All_Objects_Of_Type(self.object_string)

          if table.getn(typeUnits) == 0 then
              return nil
          end

          for _, object in pairs(typeUnits) do
            if object.Get_Owner() == Find_Player(self.owner_string) then
              return object
            end
          end

          return nil
        end
    }
end
