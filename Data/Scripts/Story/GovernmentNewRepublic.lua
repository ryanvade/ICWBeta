--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              Jorritkarwehr
--*   @Date:                2017-10-01T19:08:32+02:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCDeltaSource.lua
--*   @Last modified by:    Jorritkarwehr
--*   @Last modified time:  2017-12-21T12:39:33+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



-- require("PGBase")
-- require("PGStateMachine")
-- require("PGStoryMode")
-- require("PGSpawnUnits")

-- function Definitions()

-- 	DebugMessage("%s -- In Definitions", tostring(Script))
	
-- 	StoryModeEvents =
-- 	{
-- 		Government_Start = BeginCycle
-- 	}

-- end

-- function BeginCycle(message)
--   if message == OnEnter then

--   LastCycleTime = 0
  
--   elseif message == OnUpdate then
  
--     local current = GetCurrentTime()
--     if current - LastCycleTime >= 10 then
--         Story_Event("ELECTION_START")
--         ElectionHeld()
--         LastCycleTime = current
--     end 
  
--   end
-- end

function ElectionHeld()

    local p_newrep = Find_Player("Rebel")

    local lowInfluenceCount = 0
    local highInfluenceCount = 0

    --lowInfluenceLevelList = {}
    
    -- These don't automatically follow your choice

    local influenceOneList = Find_All_Objects_Of_Type("INFLUENCE_ONE", p_newrep)
    for _, structure in pairs(influenceOneList) do
      local lowInfluenceCount = lowInfluenceCount +1
    end

    influenceTwoList = Find_All_Objects_Of_Type("INFLUENCE_TWO", p_newrep)
    for _, structure in pairs(influenceTwoList) do
      local lowInfluenceCount = lowInfluenceCount +1
    end

    local influenceThreeList = Find_All_Objects_Of_Type("INFLUENCE_THREE", p_newrep)
    for _, structure in pairs(influenceThreeList) do
      local lowInfluenceCount = lowInfluenceCount +1
    end

    local influenceFourList = Find_All_Objects_Of_Type("INFLUENCE_FOUR", p_newrep)
    for _, structure in pairs(influenceFourList) do
      local lowInfluenceCount = lowInfluenceCount +1
    end

    -- These automatically support player choices

    local influenceFiveList = Find_All_Objects_Of_Type("INFLUENCE_FIVE", p_newrep)
    for _, structure in pairs(influenceFiveList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local influenceSixList = Find_All_Objects_Of_Type("INFLUENCE_SIX", p_newrep)
    for _, structure in pairs(influenceSixList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local influenceSevenList = Find_All_Objects_Of_Type("INFLUENCE_SEVEN", p_newrep)
    for _, structure in pairs(influenceSevenList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local influenceEightList = Find_All_Objects_Of_Type("INFLUENCE_EIGHT", p_newrep)
    for _, structure in pairs(influenceEightList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local influenceNineList = Find_All_Objects_Of_Type("INFLUENCE_NINE", p_newrep)
    for _, structure in pairs(influenceSevenList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local influenceNineList = Find_All_Objects_Of_Type("INFLUENCE_NINE", p_newrep)
    for _, structure in pairs(influenceNineList) do
      local highInfluenceCount = highInfluenceCount +1
    end

    local electionResult = highInfluenceCount - lowInfluenceCount


    if electionResult > 0 then
      Story_Event("ELECTION_WON")
    else
      Story_Event("ELECTION_LOST")
    end

    return

end

