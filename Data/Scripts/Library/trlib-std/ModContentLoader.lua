ModContentLoader = {}
ModContentLoader.mods = {
    "fotr",
    "icw"
}

ModContentLoader.mod_id = nil

function ModContentLoader.get_mod_id()
    if ModContentLoader.mod_id then
        return ModContentLoader.mod_id
    end

    local mod_id_dummy
    for _, mod_id in ipairs(ModContentLoader.mods) do
        mod_id_dummy = Find_Object_Type(mod_id)
        if mod_id_dummy then
            ModContentLoader.mod_id = mod_id
            break
        end
    end

    return ModContentLoader.mod_id
end

function ModContentLoader.get(script)
    return require(ModContentLoader.get_mod_specific_path() .. "/" .. script)
end

function ModContentLoader.get_mod_specific_path()
    if not ModContentLoader.mod_id then
        ModContentLoader.mod_id = GlobalValue.Get("MOD_ID")
    end

    local lower_mod_id = string.lower(ModContentLoader.mod_id)
    return "trlib-mod-" .. lower_mod_id
end

return ModContentLoader
