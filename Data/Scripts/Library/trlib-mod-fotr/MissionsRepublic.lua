require("trlib-std/class")
require("trlib-mod-fotr/missions/RepAccumulate")
require("trlib-mod-fotr/missions/RepShipyards")

---@class GovernmentCIS
MissionsRep = class()

function MissionsRep:new(player_agnostic_plot)

    self.AccumulateMission = MissionRepAccumulate()
    self.BuildShipyardsMission = MissionRepBuildShipyards()

end

function MissionsRep:Assign()
    
    self.missionChoice = GameRandom(1,2)
    
    if self.missionChoice == 1 then
        self.AccumulateMission:begin()
    elseif self.missionChoice == 2 then
        self.BuildShipyardsMission:begin()
    end
    
end

return MissionsRep
