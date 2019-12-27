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

    self.weeksSinceMission = self.weeksSinceMission + 1

    self.MissionDistributor:Assign()

    -- if self.weeksSinceMission >= 1 then
    --    self.missionChance = GameRandom(1,100)
    --    if self.missionChance <= 15 then
    --         self.MissionDistributor:MissionStart()
    --         self.weeksSinceMission = 0
    --     else
    --         if self.weeksSinceMission >= 3 then
    --             self.MissionDistributor:MissionStart()
    --             self.weeksSinceMission = 0
    --         end
    --     end
    -- end    
end

return MissionManager
