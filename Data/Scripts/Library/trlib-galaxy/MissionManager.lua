require("trlib-std/class")
require("trlib-util/StoryUtil")
require("trlib-std/ModContentLoader").get("MissionDistributor")

---@class MissionManager
MissionManager = class()

function MissionManager:new(player_agnostic_plot)
    self.MissionDistributor = MissionDistributor()
    self.weeksSinceMission = 0 
        
end

function MissionManager:Update()

    local missionChance = GameRandom(1,100)
    if self.weeksSinceMission >= 3 then
        if missionChance <= 15 then
            self.MissionDistributor:MissionStart()
            self.weeksSinceMission = 0
        else 
            self.weeksSinceMission = self.weeksSinceMission + 1
        end
    elseif self.weeksSinceMission >= 10 then
        self.MissionDistributor:MissionStart()
        self.weeksSinceMission = 0
    end

end

return MissionManager
