function RegisterPentastarEvents()
    RegisterPentastarEvents_New()
    RegisterPentastarRewards()
end

function RegisterPentastarEvents_New()
    Event("Universal_Story_Start"):
    When(Always()):
    End()

    Event("Kaine_Deploy_Timer"):
    When(StoryElapsed(760)):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):
    End()
end

function RegisterPentastarRewards()
    Event("Universal_Story_Start"):
    Subscribe(function()
        local spawnPlanet = FindPlanet("Entralla")
        local pentastar = Find_Player("Pentastar")
        Spawn_Unit(Find_Object_Type("Grant_Oriflamme"), spawnPlanet, pentastar)
        Spawn_Unit(Find_Object_Type("Jerec_Team"), spawnPlanet, pentastar)
        Spawn_Unit(Find_Object_Type("Sariss_Team"), spawnPlanet, pentastar)
    end)

    Event("Kaine_Deploy_Timer"):
    Subscribe(Kaine_Deployed_Reward())
end

function Kaine_Deployed_Reward()
    return {
        execute = function(self)
            local p_pentastar = Find_Player("Pentastar")
            local start_planet = FindPlanet("Bastion")
            if start_planet.Get_Owner() == Find_Player("Pentastar") then
                if p_pentastar.Is_Human() then
                    Story_Event("KAINE_JOINS_SPEECH")
                end
                local spawn_list_Reaper = { "Reaper_Kaine", "Gregor_Team", "Dekeet_Praetor", "Dynamic_Besk", "Otro_Enforcer"  }
                SpawnList(spawn_list_Reaper, start_planet, p_pentastar, true, false)
            end
        end
    }
end
