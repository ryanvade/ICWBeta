require("trlib-std/class")
require("trlib-mod-fotr/GovernmentRepublic")
require("trlib-mod-fotr/GovernmentCIS")

---@class GovernmentManager
GovernmentManager = class()

function GovernmentManager:new(player_agnostic_plot)

    self.REPGOV = GovernmentRepublic()
    self.CISGOV = GovernmentCIS()

end

function GovernmentManager:Update()
    self.REPGOV:Update()
    self.CISGOV:Update()
end

return GovernmentManager
