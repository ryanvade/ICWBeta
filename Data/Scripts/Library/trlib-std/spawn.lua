function GalacticUtil.spawn(data)
    if not data.location or not data.objects or not data.owner then
        error("Incomplete data for spawn function", 2)
    end

    local location
    if type(data.location) == "userdata" then
        location = data.location
    elseif TRlib.in_galactic_mode() then
        location = FindPlanet(data.location)
    else
        location = Find_First_Object(data.location)
    end

    if type(data.objects) == "string" then
        local object_type = data.objects
        data.objects = {}
        data.objects[object_type] = 1
    end

    local faction = Find_Player(data.owner)
    if data.fallback and TRlib.in_galactic_mode() then
        if location.Get_Owner() ~= faction then
            location = TRlib.galactic.find_friendly_planet(faction)
        end
    end

    if not location then
        error("Location "..tostring(data.location).." is not valid", 2)
    end

    local units = {}
    for object_type_name, amount in pairs(data.objects) do 
        local object_type = Find_Object_Type(object_type_name)
        for _=1, amount do
            table.insert(units, Spawn_Unit(object_type, location, faction)[1])
        end
    end

    return units
end