require("trlib-std/class")

---@class Stack
---@field size number The number of elements on the Stack
Stack = class()

function Stack:new()
    self.__elements = {}
    self.size = 0
end

---Pushes an element onto the Stack
---@param element any
function Stack:push(element)
    table.insert(self.__elements, 1, element)
    size = table.getn(self.__elements)
end

---Pops the top element from the Stack and returns it
---@return any
function Stack:pop()
    if size == 0 then
        return nil
    end

    local element = table.remove(self.__elements)
    size = table.getn(self.__elements)

    return element
end

---Returns the top element on the Stack without removing it
---@return any
function Stack:peek()
    return self.__elements[table.getn(self.__elements)]
end

---Provides an iterator over the Stack that can be used in a for loop
function Stack:iter()
    return next, self.__elements, nil
end
