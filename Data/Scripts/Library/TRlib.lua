TRlib = {}
TRlib.galactic = {}
TRlib.internal = {}

TRlib.modules = {
    "class",
    "galactic",
    "spawn",
    "serializer"
}

function TRlib.init()
    for _, module in pairs(TRlib.modules) do
        require("TRlib/"..module)
    end
end

function TRlib.in_galactic_mode()
    return Get_Game_Mode() == "Galactic"
end

function TRlib.in_space_mode()
    return Get_Game_Mode() == "Space"
end

function TRlib.in_land_mode()
    return Get_Game_Mode() == "Land"
end
