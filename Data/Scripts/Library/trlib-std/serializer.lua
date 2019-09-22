function TRlib.serialize(tab, nested)
    local result = ""
    if nested then
        result = result.."{"
    else
        result = result.."return {"
    end

    local hasEntries = false
    for k, v in pairs(tab) do
        hasEntries = true
        result = result..TRlib.internal.serialize_key(k)..TRlib.internal.serialize_value(v)..","
    end

    if not hasEntries then
        result = result.."}"
        return result
    end

    result = string.sub(result, 1, -2)
    result = result.."}"
    return result
end

function TRlib.internal.serialize_key(value)
    local result = ""
    if type(value) == "table" then
      result = TRlib.serialize(value, true)
    elseif type(value) == "function" then
      result = string.format("loadstring(%q)", string.dump(value))
    elseif type(value) == "string" then
      result = value
    end

    if type(value) ~= "number" then
      result = result.."="
    end
    return result
  end

function TRlib.internal.serialize_value(value)
    local result = ""
    if type(value) == "table" then
        result = TRlib.serialize(value, true)
    elseif type(value) == "function" then
        result = string.format("loadstring(%q)", string.dump(value))
    elseif type(value) == "string" then
        result = "\""..value.."\""
    else
        result = tostring(value)
    end

    return result
end