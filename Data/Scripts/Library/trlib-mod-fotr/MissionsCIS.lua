require("trlib-std/class")
require("trlib-mod-fotr/missions/CISAccumulate")

---@class GovernmentCIS
MissionsCIS = class()

function MissionsCIS:new(player_agnostic_plot)

    self.AccumulateMission = MissionCISAccumulate()

end

function MissionsCIS:Assign()
    
    self.missionChoice = GameRandom(1,1)
    
    if self.missionChoice == 1 then
        self.AccumulateMission:begin()
    end
    
end

return MissionsCIS
