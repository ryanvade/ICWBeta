--[[
--******************************************************************************
--*     _______ __
--*    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--*      |   | |     |   _|  _  |  |  |  |     |__ --|
--*      |___| |__|__|__| |___._|________|__|__|_____|
--*     ______
--*    |   __ \.-----.--.--.-----.-----.-----.-----.
--*    |      <|  -__|  |  |  -__|     |  _  |  -__|
--*    |___|__||_____|\___/|_____|__|__|___  |_____|
--*                                    |_____|
--*    @Author:              [TR]Pox
--*    @Date:                Tue Jun 12 2018
--*    @Project:             Imperial Civil War
--*    @Filename:            GlobalEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Thu Jun 21 2018 01:57:40
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
function RegisterGlobalEvents()
    local notification = ""

    if Find_Player("Rebel").Is_Human() then
        notification = "ENABLE_BRANCH_NEWREP_FLAG"
    elseif Find_Player("Empire").Is_Human() then
        notification = "ENABLE_BRANCH_EMPIRE_FLAG"  
    elseif Find_Player("Underworld").Is_Human() then
        notification = "ENABLE_BRANCH_EOTH_FLAG"  
	elseif Find_Player("Pentastar").Is_Human() then
        notification = "ENABLE_BRANCH_PENTASTAR_FLAG"
	elseif Find_Player("Teradoc").Is_Human() then
        notification = "ENABLE_BRANCH_TERADOC_FLAG"	
	elseif Find_Player("Hutts").Is_Human() then
        notification = "ENABLE_BRANCH_ERIADU_FLAG"
	elseif Find_Player("Pirates").Is_Human() then
        notification = "ENABLE_BRANCH_ZSINJ_FLAG"	
	elseif Find_Player("Corporate_Sector").Is_Human() then
        notification = "ENABLE_BRANCH_CORPORATE_SECTOR_FLAG"
    end

    Story_Event(notification)
end
