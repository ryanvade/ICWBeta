require("trlib-std/class")
require("GameMod")

---@class GameModImpl : GameMod
GameModImpl = class(GameMod)

---@public
function GameModImpl:mod_specific_setup()
   ModContentLoader.get("GovernmentNewsSource")
   self.galactic_news_feed:add_news_source(
       GovernmentNewsSource(self.galactic_conquest.Governments)
   )
end
