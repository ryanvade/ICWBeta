require("trlib-std/class")
require("trlib-mod-fotr/MissionsRepublic")
require("trlib-mod-fotr/MissionsCIS")

---@class MissionDistributor
MissionDistributor = class()

function MissionDistributor:new(player_agnostic_plot)

    self.cis = Find_Player("Rebel")
    self.republic = Find_Player("Empire")

    self.RepMissions = MissionsRep()
    self.CISMissions = MissionsCIS()

end

function MissionDistributor:MissionStart()

    if self.republic.Is_Human() then
        self.RepMissions:Assign()
    elseif self.cis.Is_Human() then
        self.CISMissions:Assign()
    end
    
end

return MissionDistributor
