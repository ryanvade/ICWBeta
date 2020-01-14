require("trlib-std/class")
require("trlib-mod-fotr/missions/Accumulate")
require("trlib-mod-fotr/missions/CISShipyards")
require("trlib-mod-fotr/missions/CISConquerPlanet")
require("trlib-mod-fotr/missions/CISDestroyShips")
require("trlib-mod-fotr/missions/RepShipyards")
require("trlib-mod-fotr/missions/RepConquerPlanet")

---@class MissionDistributor
MissionDistributor = class()

function MissionDistributor:new(player_agnostic_plot)

    self.cis = Find_Player("Rebel")
    self.republic = Find_Player("Empire")
 
    -- Universal Missions
    self.AccumulateMission = MissionAccumulate()
    
    -- CIS-Specific Missions
    self.CISConquerPlanet = MissionCISConquerPlanet()
    self.CISBuildShipyardsMission = MissionCISBuildShipyards()
    self.CISDestroyShipsMission = MissionCISDestroyShips()
    
    -- Republic-Specific Missions
    self.RepConquerPlanet = MissionRepConquerPlanet()
    self.RepBuildShipyardsMission = MissionRepBuildShipyards()

end

function MissionDistributor:Assign()
    
    if self.republic.Is_Human() then
        self.missionChoice = GameRandom(1,3)


            self.AccumulateMission:begin()
            self.RepBuildShipyardsMission:begin()
            self.RepConquerPlanet:begin()


        -- if self.missionChoice == 1 then
        --     self.AccumulateMission:begin()
        -- elseif self.missionChoice == 2 then
        --     self.RepBuildShipyardsMission:begin()
        -- elseif self.missionChoice == 3 then
        --     self.RepConquerPlanet:begin()
        -- end

    elseif self.cis.Is_Human() then
        self.missionChoice = GameRandom(1,4)


            self.AccumulateMission:begin()
            self.CISBuildShipyardsMission:begin()
            self.CISConquerPlanet:begin()
            self.CISDestroyShipsMission:begin()


        -- if self.missionChoice == 1 then
        --     self.AccumulateMission:begin()
        -- elseif self.missionChoice == 2 then
        --     self.CISBuildShipyardsMission:begin()
        -- elseif self.missionChoice == 3 then
        --     self.CISConquerPlanet:begin()
        -- elseif self.missionChoice == 4 then
        --     self.CISDestroyShipsMission:begin()
        -- end

    end
    
end

return MissionDistributor
