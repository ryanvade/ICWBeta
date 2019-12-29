require("trlib-std/class")
require("trlib-mod-fotr/GovernmentRepublic")
require("trlib-mod-fotr/GovernmentCIS")
require("trlib-mod-fotr/GovernmentNewRepublic")

---@class GovernmentManager
GovernmentManager = class()

function GovernmentManager:new(player_agnostic_plot)

    self.REPGOV = GovernmentRepublic()
    self.CISGOV = GovernmentCIS()
    self.NRGOV = GovernmentNewRepublic()

end

function GovernmentManager:Update()
    self.REPGOV:Update()
    self.CISGOV:Update()
    self.NRGOV:Update()
end

return GovernmentManager
