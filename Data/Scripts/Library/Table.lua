Table = setmetatable( {}, {
    __call = function(t, tab)
        local self = {}
        self.__isTableInstance = true
        if type( tab ) == "table" then

            if tab.__isTableInstance then
                self.table = {}
                for k, v in pairs(tab.table) do
                    self.table[k] = v
                end
            else
                self.table = tab
            end

        elseif tab ~= nil then
            self.table = { tab }
        else
            self.table = {}
        end

        return setmetatable(self, {
            __index = function(t_, k)
                if Table[k] then
                    return Table[k]
                else
                    return rawget(t_, "table")[k]
                end
            end,
            __newindex = function(t_, k, v)
                if Table[k] then
                    error( "Not allowed to override function in class Table" )
                end
                local internal = rawget(t_, "table")
                rawset(internal, k, v)
            end
        })
    end
})

function Table.__add(t1, t2)
    local new
    if type(t1) == "table" and t1.__isTableInstance then
        new = Table(t1.table)
        new:insert(t2)
    elseif type(t2) == "table" and t2.__isTableInstance then
        new = Table(t2.table)
        new:insert(t1)
    end

    return new
end;

function Table.__concat(t1, t2)
    local new = Table(t1)
    if type(t1) == "table" and t1.__isTableInstance then
    end
end

function Table:all(func)
    for k, v in pairs(self.table) do
        if not func(k, v) then
            return false
        end
    end

    return true
end;

function Table:filter(func, inplace)
    local filtered = {}
    for k, v in pairs(self.table) do
        if func(k, v) then
            if type(k) ~= "number" then
                filtered[k] = v
            else
                table.insert(filtered, v)
            end
        end
    end

    if inplace then
        self.table = filtered
        return self
    end

    return Table(filtered)
end;

function Table:first(func)
    for k, v in pairs(self.table) do
        if func(k, v) then
            return k, v
        end
    end

    return nil
end;

function Table:foreach(func)
    for k, v in pairs(self.table) do
        func(k, v)
    end
end;

function Table:insert(value, index)
    if index then
        table.insert(self.table, index, value)
    else
        table.insert(self.table, value)
    end
end;

function Table:iter()
    return next, self.table
end

function Table:map(func, inplace)
    local new = self

    if not inplace then
        new = Table {}
    end

    for k, v in pairs(self.table) do
        new[k] = func(k, v)
    end

    return new
end;

function Table:remove_index(index)
    self.table[index] = nil
end;

function Table:remove_value(value)
    for k, v in pairs(self.table) do
        if v == value then
            self.table[k] = nil
            return
        end
    end
end;

function Table:remove_all(func)
    for k, v in pairs(self.table) do
        if func(k, v) then
            self.table[k] = nil
        end
    end
end
