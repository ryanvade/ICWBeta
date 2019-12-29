require("trlib-std/class")
require("GameMod")

---@class GameModDecorator
GameModDecorator = class()

function GameModDecorator:new()
    self.game_mod = GameMod()
end

function GameModDecorator:update()
    self.game_mod:update()
end

return GameModDecorator
