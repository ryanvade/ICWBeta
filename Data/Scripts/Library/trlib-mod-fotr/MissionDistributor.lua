require("trlib-std/class")
require("trlib-mod-fotr/missions/CISShipyards")
require("trlib-mod-fotr/missions/CISConquerPlanet")
require("trlib-mod-fotr/missions/RepShipyards")
require("trlib-mod-fotr/missions/RepConquerPlanet")

---@class MissionDistributor
MissionDistributor = class()

function MissionDistributor:new(player_agnostic_plot)

    self.cis = Find_Player("Rebel")
    self.republic = Find_Player("Empire")
 
   
    -- CIS-Specific Missions
    self.CISConquerPlanet = MissionCISConquerPlanet()
    self.CISBuildShipyardsMission = MissionCISBuildShipyards()
    
    -- Republic-Specific Missions
    self.RepConquerPlanet = MissionRepConquerPlanet()
    self.RepBuildShipyardsMission = MissionRepBuildShipyards()

end

function MissionDistributor:Assign()
    
    if self.republic.Is_Human() then
        self.missionChoice = GameRandom(1,3)

        if self.missionChoice == 1 then
        elseif self.missionChoice == 2 then
            self.RepBuildShipyardsMission:begin()
        elseif self.missionChoice == 3 then
            self.RepConquerPlanet:begin()
        end

    elseif self.cis.Is_Human() then
        self.missionChoice = GameRandom(1,3)
        
        if self.missionChoice == 1 then
        elseif self.missionChoice == 2 then
            self.CISBuildShipyardsMission:begin()
        elseif self.missionChoice == 3 then
            self.CISConquerPlanet:begin()
        end

    end
    
end

return MissionDistributor
