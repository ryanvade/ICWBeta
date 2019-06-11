function RaidFleet(chance)
    return {
        chance = chance,
        spawnLocation = Find_First_Object("Attacker Entry Position"),
        minShipNumber = 5,
        maxShipNumber = 15,
        raidingFaction = nil,
        raidPlayer = Find_Player("Hostile"),
        fleet = {},
        possibleRaidFactions = {
            "EMPIRE",
            "REBEL",
            "UNDERWORLD",
            "PENTASTAR",
            "YEVETHA",
            "TERADOC",
            "PIRATES",
            "HUTTS",
            "SARLACC"
        },
        possibleRaidUnits = {
            ["EMPIRE"] = {"Skirmish_Lancer_Frigate", "Skirmish_Carrack_Cruiser", "Skirmish_Star_Destroyer_Two", "Skirmish_Victory_Destroyer_Two"},
            ["REBEL"] = {"Skirmish_CR90", "Skirmish_MC80B", "Skirmish_MC40a", "Skirmish_Alliance_Assault_Frigate"},
            ["UNDERWORLD"] = {"Skirmish_Vigilance_Gunship", "Skirmish_Auriette_Carrier", "Skirmish_Warlord", "Skirmish_Chiss_Star_Destroyer"},
            ["PENTASTAR"] = {"Skirmish_Lancer_Frigate", "Skirmish_Neutron_Star", "Skirmish_Star_Destroyer_Two", "Skirmish_Victory_Destroyer_Two"},
            ["YEVETHA"] = {"Armadia", "Skirmish_Dreadnaught_Empire", "Skirmish_Victory_Destroyer_Two", "Skirmish_Star_Destroyer_Two"},
            ["TERADOC"] = {"Skirmish_IPV1_Teradoc", "Skirmish_Carrack_Cruiser", "Skirmish_Star_Destroyer_Two", "Skirmish_Crimson_Victory"},
            ["PIRATES"] = {"Skirmish_Lancer_Frigate", "Skirmish_Neutron_Star", "Skirmish_Star_Destroyer_Two", "Skirmish_Victory_Destroyer_Two"},
            ["HUTTS"] = {"Skirmish_Tartan_Patrol_Cruiser", "Skirmish_Carrack_Cruiser", "Skirmish_Tector", "Skirmish_Victory_Destroyer_Two"},
            ["SARLACC"] = {"Nova_Cruiser", "BattleDragon"}
        },
        execute = function(self)
            if GameRandom(0, 100) >= self.chance then
                return
            end
            Story_Event("NO_RETREAT")
            self.raidingFaction = self:chooseRaidFaction()
            DebugMessage("Raiding Faction is %s", tostring(self.raidingFaction))
            self:composeFleet()
            
            Register_Timer(Story_Event, 10, "START_SPEECH")
            Register_Timer(self.spawnFleet, 90, {self.fleet, self.spawnLocation, self.raidPlayer})
            Register_Timer(Story_Event, 140, "YES_RETREAT")
        end,

        chooseRaidFaction = function(self)
            local numFactions = table.getn(self.possibleRaidFactions)
            local raidFaction = nil

            repeat
                raidFaction = self.possibleRaidFactions[GameRandom(1, numFactions)]
            until Find_Player(raidFaction) and not self:isInBattle(Find_Player(raidFaction))

            return raidFaction
        end,

        isInBattle = function(self, faction)
            if not faction then return false end
            return TestValid(faction.Get_Space_Station()) or table.getn(Find_All_Objects_Of_Type(faction)) > 0
        end,

        composeFleet = function(self)
            local numShips = GameRandom(self.minShipNumber, self.maxShipNumber)
            local raiderTable = self.possibleRaidUnits[self.raidingFaction]
            local index = 0
            for _=0, numShips do
                index = GameRandom(1, table.getn(raiderTable))
                table.insert(self.fleet, raiderTable[index])
                DebugMessage("Inserting %s into Raid Fleet", tostring(raiderTable[index]))
            end
        end,

        spawnFleet = function(wrapper)
            DebugMessage("Spawning Raid Fleet for %s at %s", tostring(wrapper[3]), tostring(wrapper[2]))
            SpawnList(wrapper[1], wrapper[2], wrapper[3], true, true)
        end
    }
end