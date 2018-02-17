require("GameObjectLibrary")


function Serialize(tab, nested)
  local result = ""
  if nested then
    result = result.."{\n"
  else
    result = result.."return {"
  end

  local hasEntries = false
  for k, v in pairs(tab) do
    hasEntries = true
    if k ~= "TechLevel" then
      result = result.."\t"..SerializeKey(k)..SerializeValue(v)..",\n"
    end
  end

  if not hasEntries then
    result = result.."}"
    return result
  end

  result = string.sub(result, 1, -3)
  result = result.."\n}"
  return result
end

function SerializeKey(value)
  local result = ""
  if type(value) == "table" then
    result = Serialize(value, true)
  elseif type(value) == "string" then
    if not NeedsSimpleString(value) then
      result = "[\""..value.."\"]"
    else
      result = value
    end
  end

  if type(value) ~= "number" then
    result = result.."="
  end
  return result
end

function SerializeValue(value)
  local result = ""
  if type(value) == "table" then
    if value.Initial then
      if value.Faction then
        result = result.."{\n[\""..value.Faction.."\"] = "
      else
        result = result.."{\n[\"DEFAULT\"] = "
      end
      value.Faction = nil
    end

    result = result..Serialize(value, true)

    if value.Initial then
      result = result.."\n}"
    end
  elseif type(value) == "string" then
    result = "\""..value.."\""
  else
    result = tostring(value)
  end

  return result
end

function NeedsSimpleString(val)
  local simples = {"Scripts", "Fighters", "Text", "Interdictors", "Numbers", "Structures", "Units"}
  for k, v in pairs(simples) do
    if val == v then
      return true
    end
  end
  return false
end


local cvt = [[
require("Comparators")

GameObjectLibrary = ]]..Serialize(GameObjectLibrary, true)..[[

return GameObjectLibraray
]]


--print(Serialize({ ["SQUAD"] = {Initial = 3, Reserve = 2, Faction="FACTION"}}, true))
file = assert(io.open("GameObjectLibraryConverted.lua", "w"), "FAILED")
file:write(cvt)