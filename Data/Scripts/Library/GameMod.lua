require("trlib-std/class")

GameObjectLibrary = ModContentLoader.get("GameObjectLibrary")

require("trlib-transactions/init")
require("trlib-galaxy/init")
require("trlib-galaxy/ObjectivesDisplayComponentContainer")

---@class GameMod
GameMod = class()

function GameMod:new()
    local plot = StoryUtil.GetPlayerAgnosticPlot()
    self.galactic_conquest = GalacticConquest(plot, CONSTANTS.PLAYABLE_FACTIONS)

    self.galactic_conquest.HumanPlayer.Enable_Advisor_Hints("Galactic", false)
    self.galactic_conquest.HumanPlayer.Enable_Advisor_Hints("Space", false)
    self.galactic_conquest.HumanPlayer.Enable_Advisor_Hints("Land", false)

    local gc_event_news_source =
        GalacticEventsNewsSource(
        self.galactic_conquest.Events.PlanetOwnerChanged,
        self.galactic_conquest.Events.GalacticHeroKilled,
        self.galactic_conquest.Events.IncomingFleet
    )

    self.galactic_news_feed = NewsFeedDisplayComponent()
    self.galactic_news_feed:add_news_source(gc_event_news_source)

    local structure_display =
        PlanetInformationDisplayComponent(
        self.galactic_conquest.Events.SelectedPlanetChanged,
        self.galactic_conquest.Events.GalacticProductionFinished
    )

    self.ai_dummy_handler =
        AiDummyLifeCycleHandler(self.galactic_conquest.Planets, self.galactic_conquest.Events.PlanetOwnerChanged)
    self.resource_manager = DummyBasedResourceManager(self.galactic_conquest, self.ai_dummy_handler)

    self.galactic_display = DisplayComponentContainer()
    self.galactic_display:add_display_component(ShipCrewDisplayComponent(self.resource_manager))
    self.galactic_display:add_display_component(structure_display)
    self.galactic_display:add_display_component(self.galactic_news_feed)

    self.category_filter = CategoryFilter(plot, self.galactic_conquest, self.ai_dummy_handler)

    Create_Thread("TransactionManagerThread")
end

function GameMod:update()
    self.galactic_conquest:Update()
    self.category_filter:Update()
    self.ai_dummy_handler:update()
    self.galactic_display:update_components()
end

function TransactionManagerThread()
    local transaction_manager = TransactionManager()

    while true do
        transaction_manager:ExecuteGameModeTransactions()
        Sleep(1)
    end
end

return GameMod
