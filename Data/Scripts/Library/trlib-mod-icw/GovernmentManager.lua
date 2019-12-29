require("trlib-std/class")
require("trlib-mod-icw/GovernmentNewRepublic")

---@class GovernmentManager
GovernmentManager = class()

function GovernmentManager:new(player_agnostic_plot)
    self.NRGOV = GovernmentNewRepublic()
end

function GovernmentManager:Update()
    self.NRGOV:Update()
end

return GovernmentManager
