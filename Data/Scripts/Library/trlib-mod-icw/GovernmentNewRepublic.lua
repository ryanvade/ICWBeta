require("trlib-std/class")

---@class GovernmentNewRepublic
GovernmentNewRepublic = class()

function GovernmentNewRepublic:new(player_agnostic_plot)
    self.RepublicPlayer = Find_Player("Rebel")

    GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_MOTHMA")
    GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_MOTHMA")
    self.LastElectionTime = 0

    self.Events = {}
    self.Events.ElectionHeld = Observable()
end

function GovernmentNewRepublic:Update()
    local current = GetCurrentTime()
    if current - self.LastElectionTime >= 600 then
        self:ElectionHeld()
        self.LastElectionTime = current
    end
end

function GovernmentNewRepublic:ElectionHeld()
    local lowInfluenceCount = 0
    local highInfluenceCount = 0

    -- These don't automatically follow your choice

    local influenceOneList = Find_All_Objects_Of_Type("INFLUENCE_ONE", self.RepublicPlayer)
    lowInfluenceCount = lowInfluenceCount + table.getn(influenceOneList)

    influenceTwoList = Find_All_Objects_Of_Type("INFLUENCE_TWO", self.RepublicPlayer)
    lowInfluenceCount = lowInfluenceCount + table.getn(influenceTwoList)

    local influenceThreeList = Find_All_Objects_Of_Type("INFLUENCE_THREE", self.RepublicPlayer)
    lowInfluenceCount = lowInfluenceCount + table.getn(influenceThreeList)

    local influenceFourList = Find_All_Objects_Of_Type("INFLUENCE_FOUR", self.RepublicPlayer)
    lowInfluenceCount = lowInfluenceCount + table.getn(influenceFourList)

    -- These automatically support player choices

    local influenceFiveList = Find_All_Objects_Of_Type("INFLUENCE_FIVE", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceFiveList)

    local influenceSixList = Find_All_Objects_Of_Type("INFLUENCE_SIX", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceSixList)

    local influenceSevenList = Find_All_Objects_Of_Type("INFLUENCE_SEVEN", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceSevenList)

    local influenceEightList = Find_All_Objects_Of_Type("INFLUENCE_EIGHT", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceEightList)

    local influenceNineList = Find_All_Objects_Of_Type("INFLUENCE_NINE", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceNineList)

    local influenceTenList = Find_All_Objects_Of_Type("INFLUENCE_TEN", self.RepublicPlayer)
    highInfluenceCount = highInfluenceCount + table.getn(influenceTenList)

    local electionResult = highInfluenceCount - lowInfluenceCount

    

    if electionResult > 0 then
        self.chief_of_state = GlobalValue.Get("ChiefOfStatePreference")
    else    
        self.chief_of_state = "DUMMY_CHIEFOFSTATE_MOTHMA"
    end

    GlobalValue.Set("ChiefOfState", self.chief_of_state)
    self.Events.ElectionHeld:Notify {
        winner = self.chief_of_state,
        preferred_candidate = electionResult > 0
    }
end

return GovernmentNewRepublic
