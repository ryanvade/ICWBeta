PlanetModifiers = {}

function PlanetModifiers.shipyard_production_boost(source_planet)
    local neighbors = source_planet:get_connected_planets()
    local num_mines = 0
    local ground_structure_information = planet:get_ground_structure_information()

    local owner_name = source_planet:get_owner().Get_Faction_Name()

    -- TODO: GameObjectLibrary.CommonFactionStructures
    -- should become a table where we can link faction names to buildings used by every faction like mines or barracks
    local mine_name = GameObjectLibrary.CommonFactionStructures[owner_name].MiningStation

    num_mines = num_mines + ground_structure_information[mine_name]
    for _, neighbor in pairs(neighbors) do
        if neighbor:get_owner() == source_planet:get_owner() then
            ground_structure_information = neighbor:get_ground_structure_information()
            local mines_on_planet = ground_structure_information[mine_name]
            if mines_on_planet then
                num_mines = num_mines + ground_structure_information[mine_name]
            end
        end
    end

    if num_mines < 3 then
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_1", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_2", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_3", false)
        source_planet:set_bonus_text("Shipyard_Production_Boost", nil)
    elseif num_mines >= 9 then
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_1", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_2", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_3", true)
        source_planet:set_bonus_text("Shipyard_Production_Boost", "TEXT_SHIPYARD_PRODUCTION_BOOST_TIER_3")
    elseif num_mines >= 6 then
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_1", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_2", true)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_3", false)
        source_planet:set_bonus_text("Shipyard_Production_Boost", "TEXT_SHIPYARD_PRODUCTION_BOOST_TIER_2")
    elseif num_mines >= 3 then
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_1", true)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_2", false)
        source_planet:enable_ability("Shipyard_Production_Boost_Tier_3", false)
        source_planet:set_bonus_text("Shipyard_Production_Boost", "TEXT_SHIPYARD_PRODUCTION_BOOST_TIER_1")
    end
end

function PlanetModifiers.trade_port_credit_boost(source_planet)
    local neighbors = source_planet:get_connected_planets()
    local num_trade_ports = 0

    local owner_name = source_planet:get_owner().Get_Faction_Name()

    local trade_port_name = GameObjectLibrary.CommonFactionStructures[owner_name].TradePort
    local orbital_structure_info = source_planet:get_orbital_structure_information()
    if not orbital_structure_info[trade_port_name] then
        return
    end

    for _, neighbor in pairs(neighbors) do
        if neighbor:get_owner() == source_planet:get_owner() then
            orbital_structure_info = neighbor:get_orbital_structure_information()

            if orbital_structure_info[trade_port_name] then
                num_trade_ports = num_trade_ports + 1
            end
        end
    end

    if num_trade_ports < 3 then
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Trade_Port_Credit_Boost", nil)
    elseif num_trade_ports >= 9 then
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_1", true)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Trade_Port_Credit_Boost", "TRADE_PORT_CREDIT_BOOST_TIER_1")
    elseif num_trade_ports >= 6 then
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_2", true)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Trade_Port_Credit_Boost", "TRADE_PORT_CREDIT_BOOST_TIER_2")
    elseif num_trade_ports >= 3 then
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Trade_Port_Credit_Boost_Tier_3", true)
        source_planet:set_bonus_text("Trade_Port_Credit_Boost", "TRADE_PORT_CREDIT_BOOST_TIER_3")
    end
end

function PlanetModifiers.influence_credit_boost(source_planet)

    local owner_name = source_planet:get_owner().Get_Faction_Name()

    local influence_level = source_planet:get_influence_information()

    if influence_level < 3 then
        source_planet:enable_ability("Influence_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Influence_Credit_Boost", nil)
    elseif influence_level >= 8 then
        source_planet:enable_ability("Influence_Credit_Boost_Tier_1", true)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Influence_Credit_Boost", "INFLUENCE_CREDIT_BOOST_TIER_1")
    elseif influence_level >= 6 then
        source_planet:enable_ability("Influence_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_2", true)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_3", false)
        source_planet:set_bonus_text("Trade_Port_Credit_Boost", "INFLUENCE_CREDIT_BOOST_TIER_1")
    elseif influence_level >= 3 then
        source_planet:enable_ability("Influence_Credit_Boost_Tier_1", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_2", false)
        source_planet:enable_ability("Influence_Credit_Boost_Tier_3", true)
        source_planet:set_bonus_text("Influence_Credit_Boost", "INFLUENCE_CREDIT_BOOST_TIER_3")
    end
end
