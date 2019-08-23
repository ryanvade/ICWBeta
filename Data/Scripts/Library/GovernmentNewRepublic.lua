GovernmentNewRepublic = Class {
  Constructor = function(self, player_agnostic_plot)
    self.RepublicPlayer = Find_Player("Rebel")

    self.ChiefOfState = nil
    self.ChiefOfStatePreference  = "CANDIDATE_LEIA"
    self.LastElectionTime = 0

  end,

  Update = function(self)
    local current = GetCurrentTime()
    if current - self.LastElectionTime >= 10 then
      self:ElectionHeld()
      self.LastElectionTime = current
    end  
  end,

  ElectionHeld = function(self)

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

    local generic_event = TRUtil.GetGenericEvent()
    generic_event.Set_Reward_Type("MULTIMEDIA")
    generic_event.Set_Reward_Parameter(1, 5)
    
    if electionResult > 0 then  
      generic_event.Set_Reward_Parameter(0, "TEXT_GOVERNMENT_NEWREP_ELECTION_WON")
      self.ChiefOfState = self.ChiefOfStatePreference
    else
      generic_event.Set_Reward_Parameter(0, "TEXT_GOVERNMENT_NEWREP_ELECTION_LOST")
      self.ChiefOfState = "CANDIDATE_FEYLYA"
    end

    TRUtil.TriggerGenericEvent()
    TRUtil.ResetGenericEvent()

  end;

}

return GovernmentNewRepublic
