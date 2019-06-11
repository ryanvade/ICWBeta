function table.of(num, object)
    local tab = {}
    for _=1, num do
        table.insert(tab, object)
    end
    return tab
end

function table.flatten(tab, res)
    local result = res or {}
    for _, entry in pairs(tab) do
        if type(entry) == "table" then
            table.flatten(entry, result)
        else
            table.insert(result, entry)
        end
    end
    return result
end