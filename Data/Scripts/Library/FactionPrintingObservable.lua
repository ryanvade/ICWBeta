require("Class")
require("Observable")
require("PGCommands")

---@class FactionPrintingObservable : Observable
FactionPrintingObservable = class(Observable)

function FactionPrintingObservable:new(texts)
    self.__index = 1
    self.__texts = {
        "TEXT_FACTION_EMPIRE",
        "TEXT_FACTION_REBELS",
        "TEXT_FACTION_EOTH",
        "TEXT_FACTION_PENTASTAR",
        "TEXT_FACTION_TERADOC",
        "TEXT_FACTION_ZSINJ",
        "TEXT_FACTION_DELVARDUS",
        "TEXT_FACTION_WARLORDS",
        "TEXT_FACTION_CSA",
        "TEXT_FACTION_NEUTRAL",
        "TEXT_FACTION_HOSTILE",
        "TEXT_FACTION_HUTTS",
        "TEXT_FACTION_HAPES"
    }
    self.__last_update = 0
end

function FactionPrintingObservable:OnUpdate()
    if GetCurrentTime() - self.__last_update > 1 then
        DebugMessage("Index is %s, should print %s", tostring(self.__index), tostring(self.__texts[self.__index]))
        self.__last_update = GetCurrentTime()
        self:Notify {
            headline = self.__texts[self.__index],
            color = {r = 255, g = 0, b = 0}
        }

        self.__index = self.__index + 1
        if self.__index > table.getn(self.__texts) then
            self.__index = 1
        end
    end
end