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
--*   @Date:                2017-12-18T14:01:25+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            TRGameModeTransactions.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:32:54+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("TableSerializer")

TransactionManager = {
  CreateSpawnTransaction = function(object_string, owner_string)
    return {
      object_string = object_string,
      owner_string = owner_string,
      execute = function(self)
        if not ownerTable then
          return
        end

        if not ownerTable[self.owner_string] then
          ownerTable[self.owner_string] = FindFriendlyPlanet(self.owner_string)
        end

        local objectType = Find_Object_Type(self.object_string)
        local location = ownerTable[self.owner_string]
        local player = Find_Player(self.owner_string)
        Spawn_Unit(objectType, location, player)

        if player.Is_Human() then
          ShowSURInfoMessage(ownerTable[self.owner_string])
        end

      end
    }
  end,

  RegisterTransaction = function(transactionFunction)
    local allTransactions = GlobalValue.Get("GameModeTransactions")
    if not allTransactions or allTransactions == "" then
      createTable = {
        execute = function(self)
          ownerTable = {}
        end
      }
      transactionString = Serialize({createTable})
      GlobalValue.Set("GameModeTransactions", transactionString)
    end

    allTransactions = GlobalValue.Get("GameModeTransactions")
    if not allTransactions or allTransactions == "" then
      return
    end

    funcList = loadstring(allTransactions)()

    table.insert(funcList, transactionFunction)

    transactionString = Serialize(funcList)

    GlobalValue.Set("GameModeTransactions", transactionString)
  end,

  ExecuteRegisteredTransactions = function()
    local allTransactions = GlobalValue.Get("GameModeTransactions")
    if allTransactions and allTransactions ~= "" then
      local funcList = loadstring(allTransactions)()
      for _, transaction in pairs(funcList) do
        transaction:execute()
      end
    end
    GlobalValue.Set("GameModeTransactions", "")
  end,

  PrepareBoardingTransaction = function(object_string, owner_string)
    local boardingTransactions = GlobalValue.Get("BoardingTransactions")

    if not boardingTransactions or boardingTransactions == "" then
      GlobalValue.Set("BoardingTransactions", Serialize({}))
    end

    local boardedTypeList = loadstring(GlobalValue.Get("BoardingTransactions"))()
    table.insert(boardedTypeList, {objectType = object_string, owner = owner_string})

    GlobalValue.Set("BoardingTransactions", Serialize(boardedTypeList))
  end,

  ExecuteBoardingTransactions = function()
    local boardingTransactions = GlobalValue.Get("BoardingTransactions")
    if boardingTransactions and boardingTransactions ~= "" then
      local transactionFunction = loadstring(boardingTransactions)
      return transactionFunction()
    end
    GlobalValue.Set("BoardingTransactions", "")
  end,

  ResetBoardingTransactions = function()
    GlobalValue.Set("BoardingTransactions", "")
  end
}

function FindFriendlyPlanet(playerString)
  local player = Find_Player(playerString)
  local allPlanets = FindPlanet.Get_All_Planets()
  local random = GameRandom(1, table.getn(allPlanets))
  local planet = allPlanets[random]
  while planet.Get_Owner() ~= Find_Player(playerString) do
    random = GameRandom(1, table.getn(allPlanets))
    planet = allPlanets[random]
  end
  return planet
end

function ShowSURInfoMessage(planet)
  GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(0, "TEXT_SINGLE_UNIT_RETREAT_PLANET")
  GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(1, 5)
  GLOBALS.SHOW_TEXT_EVENT.Set_Reward_Parameter(2, planet)
  Story_Event(GLOBALS.SHOW_TEXT_NOTIFICATION_NAME)
end

return TransactionManager
