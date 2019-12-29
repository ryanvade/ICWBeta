require("trlib-std/class")
require("GameMod")
ModContentLoader.get("GovernmentNewsSource")

---@class GameModDecorator
GameModDecorator = class()

function GameModDecorator:new()
    self.game_mod = GameMod()
    self.game_mod.galactic_news_feed:add_news_source(GovernmentNewsSource(self.game_mod.galactic_conquest.Governments))
end

---@public
function GameModDecorator:update()
    self.game_mod:update()
end

return GameModDecorator
