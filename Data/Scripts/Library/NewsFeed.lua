require("Class")
require("OrderedTable")
require("TRUtil")

---@class NewsFeed
NewsFeed = class()

function NewsFeed:new()
    ---@private
    self.__display_duration = 10

    ---@private
    self.__max_headlines = 5

    ---@private
    self.__news_sources = {}

    ---@private
    self.__header = "TEXT_NEWS_FEED_HEADER"

    ---@private
    self.__headlines_on_screen = OrderedTable()

    ---@private
    self.__visible = false

    self:show()
end

function NewsFeed:update()
    if not self.__visible then
        return
    end

    local now = GetCurrentTime()
    local duration
    local headlines_to_remove = {}
    for headline, news_story in self.__headlines_on_screen:iter() do
        duration = news_story.duration or self.__display_duration
        if now >= news_story.start_time + duration then
            table.insert(headlines_to_remove, headline)
        end
    end

    for _, headline in pairs(headlines_to_remove) do
        self.__headlines_on_screen:remove(headline)
        TRUtil.RemoveScreenText(headline)
    end
end

---@param source Observable
function NewsFeed:add_news_source(source)
    self.__news_sources[source] = true
    source:AttachListener(self.on_news_source_update, self)
end

function NewsFeed:show()
    if self.__visible then
        return
    end

    TRUtil.ShowScreenText(self.__header, -1, nil, {r = 255, g = 0, b = 0})

    for headline, news_story in self.__headlines_on_screen:iter() do
        TRUtil.ShowScreenText(news_story.headline, -1, news_story.var, news_story.color, true)
    end

    self.__visible = true
end

function NewsFeed:hide()
    if not self.__visible then
        return
    end

    TRUtil.RemoveScreenText(self.__header)

    for headline, news_story in self.__headlines_on_screen:iter() do
        TRUtil.RemoveScreenText(headline)
    end

    self.__visible = false
end

---@private
function NewsFeed:on_news_source_update(news_story)
    if self.__headlines_on_screen.size >= self.__max_headlines then
        local headline = self.__headlines_on_screen:remove_index(1)
        TRUtil.RemoveScreenText(headline)
    end

    news_story.start_time = GetCurrentTime()

    if self.__headlines_on_screen:get(news_story.headline) then
        TRUtil.RemoveScreenText(news_story.headline)
        self.__headlines_on_screen:update(news_story.headline, news_story, true)
    else
        self.__headlines_on_screen:put(news_story.headline, news_story)
    end

    TRUtil.ShowScreenText(news_story.headline, -1, news_story.var, news_story.color)
end
