TextComponent = class()

function TextComponent:new()
    self.__visible = false
    self.__data_sources = {}
end

function TextComponent:toggle()
    if not self.__visible then
        self:show()
    else
        self:hide()
    end
end

function TextComponent:show()
    local text_data = self:get_text_data()
    for _, text in pairs(text_data.text) do
        table.insert(self.__shown_text_entries, text)
        TRUtil.ShowScreenText(text, text_data.duration, text_data.var, text_data.color)
    end
    self.__visible = true
end

function TextComponent:hide()
    for i, text in ipairs(self.__shown_text_entries) do
        TRUtil.RemoveScreenText(text)
    end

    self.__shown_text_entries = {}
    self.__visible = false
end

function TextComponent:get_text_data()
    error("TextComponent:get_text_data() not implemented")
end