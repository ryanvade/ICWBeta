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
--*    @Filename:            OrindaEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Sat Jun 16 2018 00:00:12
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
require("Conquests/Orinda/OrindaEmpireEvents")
require("Conquests/Orinda/OrindaNewRepublicEvents")

function RegisterEvents()
    RegisterEmpireEvents()
    RegisterNewRepublicEvents()
end
