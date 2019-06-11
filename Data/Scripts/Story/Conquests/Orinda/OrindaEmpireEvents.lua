function RegisterEmpireEvents()
    RegisterEmpireEvents_New()
    RegisterEmpireRewards()
end

function RegisterEmpireEvents_New()
    Event("Universal_Story_Start"):
    When(Always()):
    End()

    Event("Rogriss_Deploy_Timer"):
    When(StoryElapsed(400)):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):
    End()
end

function RegisterEmpireRewards()
    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Borosk")
        local empire = Find_Player("Empire")
        Spawn_Unit(Find_Object_Type("Pellaeon_Reaper"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("181st_TIE_Interceptor_Squadron"), spawnPlanet, empire)
    end)

    Event("Rogriss_Deploy_Timer"):
    Subscribe(Rogriss_Deployed_Reward())
end

function Rogriss_Deployed_Reward()
    return {
        execute = function(self)
            local p_empire = Find_Player("Empire")
            local start_planet = FindPlanet("Bastion")
            if start_planet.Get_Owner() == Find_Player("Empire") then
                if p_empire.Is_Human() then
                    Story_Event("ROGRISS_JOINS_SPEECH")
                end
                local spawn_list_Rogriss = {"Rogriss_Dominion"}
                SpawnList(spawn_list_Rogriss, start_planet, p_empire, true, false)
            end
        end
    }
end
