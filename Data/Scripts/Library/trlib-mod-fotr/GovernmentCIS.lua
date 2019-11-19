require("trlib-std/class")

---@class GovernmentCIS
GovernmentCIS = class()

function GovernmentCIS:new(player_agnostic_plot)
    self.RepublicPlayer = Find_Player("Rebel")

    GlobalValue.Set("IGBCApprovalRating", 50)
    GlobalValue.Set("CommerceApprovalRating", 50)
    GlobalValue.Set("TechnoApprovalRating", 50)
    GlobalValue.Set("TradeFedApprovalRating", 50)
    self.LastCycleTime = 0

end

function GovernmentCIS:Update()
    local current = GetCurrentTime()
    if current - self.LastCycleTime >= 40 then
        self.LastCycleTime = current
    end
end

return GovernmentCIS
