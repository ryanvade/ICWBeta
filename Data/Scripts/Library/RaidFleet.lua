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
--*   @Date:                2017-12-18T22:57:21+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            RaidFleet.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2017-12-21T12:32:03+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



function MakeRaidFleet(chance)
  local RaidFleet = {}
  RaidFleet.chance = chance
  RaidFleet.spawnList = {}
  RaidFleet.completedListener = nil

  RaidFleet.factions = {"Rebel", "Empire", "Underworld", "Pirates", "Pentastar", "Yevetha", "Teradoc", "Hutts", "Sarlacc"}
  RaidFleet.unit_types = {{"Skirmish_CR90", "Skirmish_MC80B", "Skirmish_MC40a", "Skirmish_Alliance_Assault_Frigate"},
    {"Skirmish_Lancer_Frigate", "Skirmish_Carrack_Cruiser", "Skirmish_Star_Destroyer_Two", "Skirmish_Victory_Destroyer_Two"},
    {"Skirmish_Vigilance_Gunship", "Skirmish_Auriette_Carrier", "Skirmish_Warlord", "Skirmish_Chiss_Star_Destroyer"},
     {"Skirmish_Lancer_Frigate", "Skirmish_Neutron_Star", "Skirmish_Star_Destroyer_Two", "Skirmish_Victory_Destroyer_Two"},
    {"Skirmish_Enforcer", "Skirmish_Raider_Pentastar", "Skirmish_Procursator", "Skirmish_Star_Destroyer_Two"},
    {"Armadia", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer_Two", "Skirmish_Star_Destroyer_Two"},
    {"Skirmish_IPV1_Teradoc", "Skirmish_Carrack_Cruiser", "Skirmish_Star_Destroyer_Two", "Skirmish_Crimson_Victory"},
    {"Skirmish_Tartan_Patrol_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Tector", "Skirmish_Victory_Destroyer_Two"},
    {"Nova_Cruiser", "BattleDragon"}
  }
  RaidFleet.starbases = {{"NR_Star_Base_1", "NR_Star_Base_2", "NR_Star_Base_3"},
    {"Remnant_Star_Base_1", "Remnant_Star_Base_2", "Remnant_Star_Base_3"},
    {"EotH_Star_Base_1", "EotH_Star_Base_2", "EotH_Star_Base_3"},
    {"Zsinj_Star_Base_1", "Zsinj_Star_Base_2", "Zsinj_Star_Base_3"},
    {"Pentastar_Star_Base_1", "Pentastar_Star_Base_2", "Pentastar_Star_Base_3"},
    {"Y_Star_Base_1", "Y_Star_Base_2", "Y_Star_Base_3"},
    {"Teradoc_Star_Base_1", "Teradoc_Star_Base_2", "Teradoc_Star_Base_3"},
    {"Delvardus_Star_Base_1", "Delvardus_Star_Base_2", "Delvardus_Star_Base_3"},
    {"Hapan_Star_Base_1", "Hapan_Star_Base_2"}
  }


  function RaidFleet:setCompletedListener(listener)
    self.completedListener = listener
  end

  function RaidFleet:initialize()
    self:determineDefender()
    self:determineAttacker()
    local raider = GameRandom(1, table.getn(self.unit_types))
    local entry = Find_First_Object("Attacker Entry Position")
    local moveto = Find_First_Object("Space Station Position")
    self:randomSpawn(self.unit_types[raider], entry, moveto, self.chance, 10)
  end

  function RaidFleet:determineDefender()
    local found_base = false
    for i, sub in pairs(self.starbases) do
      for k, base in pairs(sub) do
        if Find_First_Object(base) then
          table.remove(self.factions, i)
          table.remove(self.unit_types, i)
          found_base = true
          break
        end
      end
      if found_base then
        break
      end
    end
    if not found_base then
      --Game_Message("TEXT_STRANGE_SIGNAL")
      --ScriptExit()
    end
  end

  function RaidFleet:determineAttacker()
    for j, faction in pairs(self.factions) do
      if table.getn(Find_All_Objects_Of_Type(Find_Player(faction))) > 0 then
        table.remove(self.factions, j)
        table.remove(self.unit_types, j)
        break
      end
    end
  end

  function RaidFleet:randomSpawn(unit_list, spawnpoint, target, chance, max_ship_number)
    if type(unit_list) == "table" then

      local attack_chance = GameRandom(1, 100)
      local anzahl = GameRandom(3, max_ship_number)
      local spawnliste = {}
      local count = 0
      local invaders = Find_Player("Hostile")

      if attack_chance <= chance then
        repeat
          local einheit = GameRandom(1, table.getn(unit_list))
          table.insert(spawnliste, unit_list[einheit])
          count = count + 1
        until count == anzahl
        Story_Event("NO_RETREAT")

        Register_Timer(startSpeach, 10, nil)
        Register_Timer(spawnFleet, 90, {self, spawnliste, spawnpoint, invaders})
        Register_Timer(enableRetreat, 140, nil)

      else
        --ScriptExit()
      end
    end
  end

  function RaidFleet:cleanUp()
    Story_Event("RESET_AI")
    for j, unit in pairs(self.spawnList) do
      if TestValid(unit) then
        unit.Despawn()
      end
    end
  end

  return RaidFleet

end

function startSpeach()
  Story_Event("START_SPEECH")
end

function spawnFleet(param)
  local self = param[1]
  self.spawnList = SpawnList(param[2], param[3], param[4], true, true)
end

function enableRetreat()
  Story_Event("YES_RETREAT")
end
