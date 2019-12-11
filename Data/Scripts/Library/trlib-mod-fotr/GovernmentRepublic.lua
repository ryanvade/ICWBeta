require("trlib-std/class")
StoryUtil = require("trlib-util/StoryUtil")

---@class GovernmentRepublic
GovernmentRepublic = class()

function GovernmentRepublic:new(player_agnostic_plot)
    self.RepublicPlayer = Find_Player("Empire")

    GlobalValue.Set("ChiefOfState", "DUMMY_CHIEFOFSTATE_PALPATINE")
    GlobalValue.Set("ChiefOfStatePreference", "DUMMY_CHIEFOFSTATE_PALPATINE")
    GlobalValue.Set("RepublicApprovalRating", 10)
    self.LastCycleTime = 0
    self.ApprovalRatingInfluence = 0
    self.ChoiceMade = false

    Get_Story_Plot("Conquests\\Story_Sandbox_Government_Rep.XML")
    if Find_Player("Empire").Is_Human() then
        Story_Event("ACTIVE_PLAYER")
    end

    --self.Events = {}
    --self.Events.ElectionHeld = Observable()
end

function GovernmentRepublic:Update()
    local current = GetCurrentTime()
    if current - self.LastCycleTime >= 40 then
        self:ApprovalRating()
        self:KDYContracts()
        self.LastCycleTime = current
    end
end

function GovernmentRepublic:ApprovalRating()
    local lowInfluenceCount = 0
    local highInfluenceCount = 0

    local oldValue = self.ApprovalRatingInfluence

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

    local planetCount = table.getn(influenceOneList) + table.getn(influenceTwoList) + table.getn(influenceThreeList) + table.getn(influenceFourList) + table.getn(influenceFiveList) + table.getn(influenceSixList) + table.getn(influenceSevenList) + table.getn(influenceEightList) + table.getn(influenceNineList) + table.getn(influenceTenList)
    local approvalNumberCount = (10 * table.getn(influenceOneList)) + (20 * table.getn(influenceTwoList)) + (30 * table.getn(influenceThreeList)) + (40 * table.getn(influenceFourList)) + (50 * table.getn(influenceFiveList)) + (60 * table.getn(influenceSixList)) + (70 * table.getn(influenceSevenList)) + (80 * table.getn(influenceEightList)) + (90 * table.getn(influenceNineList)) + (100 * table.getn(influenceTenList))

    self.ApprovalRatingInfluence = (approvalNumberCount / planetCount)

    local oldApprovalRating = GlobalValue.Get("RepublicApprovalRating")
    local overallApprovalRating = oldApprovalRating - oldValue + self.ApprovalRatingInfluence 

    if overallApprovalRating >= 65 and self.ChoiceMade == false then
        self:MakeLeaderChoice()
    end    

    GlobalValue.Set("RepublicApprovalRating", overallApprovalRating)

end

function GovernmentRepublic:MakeLeaderChoice()

    self.ChoiceMade = true
    Get_Story_Plot("Conquests\\Story_Sandbox_Government_Rep.XML")
    if Find_Player("Empire").Is_Human() then
        Story_Event("LEADER_APPEAL")
    else
        Story_Event("LEADER_APPEAL_AI")
    end

end

function GovernmentRepublic:KDYContracts()

    local shipList =  {
        "Generic_Star_Destroyer",
        "Generic_Tector",
        "Generic_Secutor"
    }
   
    local contractObject = Find_First_Object("DUMMY_KUAT_CONTRACT")
    if contractObject then
        local planet = contractObject.Get_Planet_Location()
        if planet.Get_Owner() == self.RepublicPlayer then
            local spawnChance = GameRandom(1,100)
            if spawnChance <= 15 then
                table.remove(shipList, GameRandom(1,3))
                table.remove(shipList, GameRandom(1,2))
                local KDYspawn = SpawnList(shipList, planet, self.RepublicPlayer, true, false)
            end
        end
    end

end

return GovernmentRepublic
