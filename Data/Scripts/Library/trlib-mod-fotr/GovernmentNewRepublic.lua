require("trlib-std/class")

---@class GovernmentNewRepublic
GovernmentNewRepublic = class()

function GovernmentNewRepublic:new(player_agnostic_plot)
    self.Events = {}
    self.Events.ElectionHeld = Observable()
end

function GovernmentNewRepublic:Update()

end

function GovernmentNewRepublic:ElectionHeld()
    self.chief_of_state = "DUMMY_CHIEFOFSTATE_MOTHMA"
 
    self.Events.ElectionHeld:Notify {
        winner = self.chief_of_state,
        preferred_candidate = electionResult > 0
    }
end

return GovernmentNewRepublic
