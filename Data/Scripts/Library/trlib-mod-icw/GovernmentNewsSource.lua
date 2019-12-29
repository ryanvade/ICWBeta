require("trlib-std/class")
require("trlib-std/Observable")

---@class GovernmentNewsSource : Observable
GovernmentNewsSource = class(Observable)

---@param government_manager GovernmentManager
function GovernmentNewsSource:new(government_manager)
    government_manager.NRGOV.Events.ElectionHeld:AttachListener(self.on_election_held, self)
end

function GovernmentNewsSource:on_election_held(election_result)
    self:Notify {
        headline = "TEXT_NEWS_NR_ELECTION_RESULT",
        var = election_result.winner,
        color = {r = 239, g = 139, b = 9}
    }
end