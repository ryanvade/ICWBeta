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
--*   @Author:              [TR]Pox
--*   @Date:                2017-12-18T14:01:25+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            TRGameModeTransactions.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-03-19T23:23:14+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("Class")
require("TableSerializer")
TRUtil = require("TRUtil")

TransactionManager = Class {
    RegisterTransaction = function(self, transactionRegistry, transactionFunction)
        local allTransactions = GlobalValue.Get(transactionRegistry)

        if not allTransactions or allTransactions == "" then
            allTransactions = Serialize({})
        end

        funcList = loadstring(allTransactions)()

        table.insert(funcList, transactionFunction)

        transactionString = Serialize(funcList)

        GlobalValue.Set(transactionRegistry, transactionString)
    end,

    RegisterGameModeTransaction = function(self, transactionFunction)
        local allTransactions = GlobalValue.Get("GameModeTransactions")
        if not TRUtil.ValidGlobalValue(allTransactions) then
            local transaction = {
                execute = function(self)
                    ownerTable = {}
                end
            }
            self:RegisterTransaction("GameModeTransactions", transaction)
        end

        self:RegisterTransaction("GameModeTransactions", transactionFunction)
    end,

    RegisterBoardingTransaction = function(self, transactionFunction)
        self:RegisterTransaction("BoardingTransactions", transactionFunction)
    end,

    ExecuteGameModeTransactions = function(self)
        self:ExecuteTransactions("GameModeTransactions")
    end,

    ExecuteBoardingTransactions = function(self)
        self:ExecuteTransactions("BoardingTransactions")
    end,

    ExecuteTransactions = function(self, transactionRegistry)
        local allTransactions = GlobalValue.Get(transactionRegistry)
        if allTransactions and allTransactions ~= "" then
            local funcList = loadstring(allTransactions)()
            for _, transaction in pairs(funcList) do
                transaction:execute()
            end
        end
        GlobalValue.Set(transactionRegistry, "")
    end,

    ResetBoardingTransactions = function(self)
        GlobalValue.Set("BoardingTransactions", "")
    end
}

return TransactionManager
