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
--*    @Date:                Wed Jun 13 2018
--*    @Project:             Imperial Civil War
--*    @Filename:            FinalImperialPushEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Wed Jun 13 2018 02:49:10
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
require("Conquests/FinalImperialPush/FIPEmpireEvents")
require("Conquests/FinalImperialPush/FIPNewRepublicEvents")

function RegisterEvents()
    RegisterEmpireEvents()
    RegisterNewRepublicEvents()
end
