require("trlib-std/class")
require("trlib-mod-fotr/GovernmentRepublic")

---@class GovernmentManager
GovernmentManager = class()

function GovernmentManager:new(player_agnostic_plot)

    self.REPGOV = GovernmentRepublic()

end

function GovernmentManager:Update()
    self.REPGOV:Update()
end

return GovernmentManager
