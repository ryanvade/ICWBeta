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
--*   @Filename:            TransactionManager.lua
--*   @Last modified by:    [TR]Pox
--*   @Last modified time:  2018-04-07T04:27:13+02:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************

require("trlib-std/class")
require("trlib-transactions/TableSerializer")

TransactionManager = class()

function TransactionManager:RegisterTransaction(transactionRegistry, transactionFunction)
    local allTransactions = GlobalValue.Get(transactionRegistry)

    if not allTransactions or allTransactions == "" then
        allTransactions = Serialize({})
    end

    funcList = loadstring(allTransactions)()

    table.insert(funcList, transactionFunction)

    transactionString = Serialize(funcList)

    GlobalValue.Set(transactionRegistry, transactionString)
end

function TransactionManager:RegisterGameModeTransaction(transactionFunction)
    local allTransactions = GlobalValue.Get("GameModeTransactions")
    if not self:ValidGlobalValue(allTransactions) then
        local transaction = {
            execute = function(self)
                ownerTable = {}
            end
        }
        self:RegisterTransaction("GameModeTransactions", transaction)
    end

    self:RegisterTransaction("GameModeTransactions", transactionFunction)
end

function TransactionManager:RegisterBoardingTransaction(transactionFunction)
    self:RegisterTransaction("BoardingTransactions", transactionFunction)
end

function TransactionManager:ExecuteGameModeTransactions()
    self:ExecuteTransactions("GameModeTransactions")
end

function TransactionManager:ExecuteBoardingTransactions()
    self:ExecuteTransactions("BoardingTransactions")
end

function TransactionManager:ExecuteTransactions(transactionRegistry)
    local allTransactions = GlobalValue.Get(transactionRegistry)
    if not self:ValidGlobalValue(allTransactions) then
        return
    end

    local funcList = loadstring(allTransactions)()
    for _, transaction in pairs(funcList) do
        transaction:execute()
    end

    GlobalValue.Set(transactionRegistry, "")
end

function TransactionManager:ResetBoardingTransactions()
    GlobalValue.Set("BoardingTransactions", "")
end

function TransactionManager:ValidGlobalValue(val)
    return val and val ~= ""
end

return TransactionManager
