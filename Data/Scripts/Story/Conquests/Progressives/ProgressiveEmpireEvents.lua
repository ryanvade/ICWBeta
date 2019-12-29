--[[
--******************************************************************************
--*     _______ __
--*    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--*      |   | |     |   _|  _  |  |  |  |     |__ --|
--*      |___| |__|__|__| |___._|________|__|__|_____|
--*     ______
--*    |   __ \.-----.--.--.-----.-----.-----.-----.
--*    |      <|  -__|  |  |  -__|     |  _  |  -__|
--*    |___|__||_____|\___/|_____|__|__|___  |_____|
--*                                    |_____|
--*    @Author:              [TR]Pox
--*    @Date:                Wed Jun 13 2018
--*    @Project:             Imperial Civil War
--*    @Filename:            ProgressiveEmpireEvents.lua
--*    @Last modified by:    [TR]Pox
--*    @Last modified time:  Fri Jun 22 2018 06:59:11
--*    @License:             This source code may only be used with explicit permission from the developers
--*    @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************
--]]
function RegisterEmpireEvents()
    Pestage_Isard_Events()
    Pestage_Isard_Rewards()
    Isard_Thrawn_Events()
    Isard_Thrawn_Rewards()
    Thrawn_Palpatine_Events()
    Thrawn_Palpatine_Rewards()
    Palpatine_CarnorJax()
end


function Pestage_Isard_Events()
    Event("Universal_Story_Start"):
    When(Always()):
    End()

    Event("Unlock_Project_Ambition"):
    When(StoryElapsed(5)):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):End()
    
    Event("Trigger_Isard_Coruscant_Falls"):
    When(
        Planet("Coruscant"):
        OwnerChanged():
        End()
    ):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):End()
    
    Event("Trigger_Isard_Pestage_Death"):
    When(
        --weird thing: we have to spawn the team, but check if single unit is dead
        GameObject("Sate_Pestage"):
        FirstIsDead():
        End()
    ):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):
    End()
    
    Event("Trigger_Isard_Pestage_Timer"):
    When(StoryElapsed(3200)):
    After(
        Prereq("Universal_Story_Start"):
        End()
    ):End()
    
    Event("Ambition_Researched"):
    When(
        GameObject("Project_Ambition_Dummy"):
        FirstIsAlive():
        End()
    ):
    End()

    Event("Set_Subera_Isard"):
    When(Always()):
    After(
        Prereq("Ambition_Researched"):
        Or("Trigger_Isard_Coruscant_Falls"):
        Or("Trigger_Isard_Pestage_Timer"):
        Or("Trigger_Isard_Pestage_Death"):
        End()
    ):End()

    
end

function Pestage_Isard_Rewards()
    Event("Universal_Story_Start"):
    Subscribe(function()
        LockPlanet("Byss"):execute()
        local empire = Find_Player("Empire")
        local thyferra = FindPlanet("Thyferra")
        Spawn_Unit(Find_Object_Type("Pestage_Team"), FindPlanet("Coruscant"), empire)
        Spawn_Unit(Find_Object_Type("Whirlwind_Star_Destroyer"), thyferra, empire)
        Spawn_Unit(Find_Object_Type("Reckoning_Star_Destroyer"), thyferra, empire)
        Spawn_Unit(Find_Object_Type("Brashin_Team"), thyferra, empire)
        Spawn_Unit(Find_Object_Type("Loor_Team"), thyferra, empire)
        Spawn_Unit(Find_Object_Type("Derricote_Team"), thyferra, empire)
    end)
    
    Event("Set_Subera_Isard"):
    Subscribe(function()
        TriggerXmlEvent("LOCK_AMBITION")
        DespawnHero("Pestage_Team"):execute()

        SpawnUnits({"Lusankya"}):
        OnPlanet("Coruscant"):
        ForPlayer("Empire"):
        WithFallback():
        End():execute()

        DespawnHero("Whirlwind_Star_Destroyer"):execute()
        local kalist = FindPlanet("Kalist")
        local harrsk = Find_Player("Harrsk")
        ChangeOwnerAndRetreat(kalist, harrsk)
        SpawnList({"Whirlwind_Star_Destroyer", "Generic_Star_Destroyer"}, kalist, harrsk, true, false)
    end)

    Event("Ambition_Researched"):
    Subscribe(function()
            KillFirstObject("Project_Ambition_Dummy"):execute()
            
            SpawnUnits({"Elite_Squadron", "Makati_Steadfast", "Takel_MagicDragon", "Corrupter_Star_Destroyer"}):
            OnPlanet("Coruscant"):
            ForPlayer("Empire"):
            WithFallback():
            End():execute()
        end
    )
end

function Isard_Thrawn_Events()
    Event("Unlock_Thrawn_Regicide"):
    When(Always()):
    After(
        Prereq("Set_Subera_Isard"):
        End()
    ):
    End()

    Event("Trigger_Thrawn_Regicide_Construct"):
    When(
        GameObject("Dummy_Regicide_Thrawn"):
        FirstIsAlive():
        End()
    ):
    After(
        Prereq("Unlock_Thrawn_Regicide"):
        End()
    ):
    End()

    Event("Trigger_Thrawn_Isard_Death"):
    When(
        GameObject("Lusankya"):
        FirstIsDead():
        End()
    ):
    After(
        Prereq("Set_Subera_Isard"):
        End()
    ):
    End()

    Event("Trigger_Thrawn_Isard_Timer"):
    When(StoryElapsed(3200)):
    After(
        Prereq("Set_Subera_Isard"):
        End()
    ):
    End()

    Event("Set_Subera_Thrawn"):
    When(Always()):
    After(
        Prereq("Trigger_Thrawn_Isard_Death"):
        Or("Trigger_Thrawn_Isard_Timer"):
        Or("Trigger_Thrawn_Regicide_Construct"):
        End()
    ):
    End()
end

function Isard_Thrawn_Rewards()
    Event("Set_Subera_Isard"):
    Subscribe(TriggerXmlEvent("UNLOCK_THRAWN_REGICIDE"))

    Event("Trigger_Thrawn_Regicide_Construct"):
    Subscribe(KillFirstObject("LOCK_THRAWN_REGICIDE"))

    Event("Set_Subera_Thrawn"):
    Subscribe(function()
        TriggerXmlEvent("")

        TRUtil.SetTechLevel("Empire", 2)
        TRUtil.SetTechLevel("Pentastar", 2)
        TRUtil.SetTechLevel("Underworld", 2)
        TRUtil.SetTechLevel("Teradoc", 2)
        TRUtil.SetTechLevel("Pirates", 2)
        TRUtil.SetTechLevel("Rebel", 2)
        TRUtil.SetTechLevel("Hapes_Consortium", 2)
        TRUtil.SetTechLevel("Corporate_Sector", 2)
        TRUtil.SetTechLevel("Hutts", 2)

        DespawnHero("Elite_Squadron"):execute()
        DespawnHero("Shockwave_Star_Destroyer"):execute()
        DespawnHero("Reckoning_Star_Destroyer"):execute()
        DespawnHero("Corrupter_Star_Destroyer"):execute()
        DespawnHero("Brashin_Team"):execute()
        DespawnHero("Loor_Team"):execute()
        DespawnHero("Derricote_Team"):execute()

        local fallbackPlanet = TRUtil.FindFriendlyPlanet("Empire")
        local empire = Find_Player("Empire")
        local spawnPlanet = FindPlanet("ObroaSkai")
        if spawnPlanet.Get_Owner() ~= empire then
            spawnPlanet = fallbackPlanet
        end

        Spawn_Unit(Find_Object_Type("Chimera"), spawnPlanet, empire)

        spawnPlanet = FindPlanet("Bastion")
        if spawnPlanet.Get_Owner() ~= empire then
            spawnPlanet = fallbackPlanet
        end

        Spawn_Unit(Find_Object_Type("181st_TIE_Interceptor_Squadron"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("General_Covell_Team"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("Judicator_Star_Destroyer"), spawnPlanet, empire)
        Spawn_Unit(Find_Object_Type("Relentless_Star_Destroyer"), spawnPlanet, empire)

        spawnPlanet = FindPlanet("Jomark")
        if spawnPlanet.Get_Owner() ~= empire then
            spawnPlanet = fallbackPlanet
        end

        Spawn_Unit(Find_Object_Type("Joruus_Cboath_Team"), spawnPlanet, empire)

        spawnPlanet = FindPlanet("NewCov")
        if spawnPlanet.Get_Owner() ~= empire then
            spawnPlanet = fallbackPlanet
        end

        Spawn_Unit(Find_Object_Type("Corellian_Gunboat_Ferrier"), spawnPlanet, empire)
    end)
end

function Thrawn_Palpatine_Events()
    Event("Trigger_Council_Thrawn_Death"):
    When(
        GameObject("Chimera"):
        FirstIsDead():
        End()
    ):
    After(
        Prereq("Set_Subera_Thrawn"):
        End()
    ):
    End()

    Event("Trigger_Palpatine_Thrawn_Voluntary"):
    When(
        GameObject("Dummy_Regicide_Palpatine"):
        FirstIsAlive():
        End()
    ):
    After(
        Prereq("Unlock_Palpatine_Regicide"):
        End()
    ):
    End()

    Event("Trigger_Palpatine_Thrawn_Death_Timer"):
    When(StoryElapsed(600)):
    After(
        Prereq("Trigger_Council_Thrawn_Death"):
        End()
    ):
    End()

    Event("Trigger_Palpatine_Thrawn_Timer"):
    When(StoryElapsed(3200)):
    After(
        Prereq("Set_Subera_Thrawn"):
        End()
    ):
    End()

    Event("Set_Subera_Palpatine"):
    When(Always()):
    After(
        Prereq("Trigger_Palpatine_Thrawn_Voluntary"):
        Or("Trigger_Palpatine_Thrawn_Death_Timer"):
        Or("Trigger_Palpatine_Thrawn_Timer"):
        End()
    )
end

function Thrawn_Palpatine_Rewards()
    Event("Set_Subera_Thrawn"):
    Subscribe(TriggerXmlEvent("UNLOCK_PALPATINE_REGICIDE"))

    Event("Set_Subera_Palpatine"):
    Subscribe(function()
        TriggerXmlEvent("LOCK_PALPATINE_REGICIDE"):execute()
        
        UnlockPlanet("Byss"):execute()
        ChangePlanetOwner("Byss"):
        ToPlayer("Empire"):
        End():execute()

        TRUtil.SetTechLevel("Empire", 3)
        TRUtil.SetTechLevel("Pentastar", 3)
        TRUtil.SetTechLevel("Underworld", 3)
        TRUtil.SetTechLevel("Teradoc", 3)
        TRUtil.SetTechLevel("Pirates", 3)
        TRUtil.SetTechLevel("Rebel", 3)
        TRUtil.SetTechLevel("Hapes_Consortium", 3)
        TRUtil.SetTechLevel("Corporate_Sector", 3)
        TRUtil.SetTechLevel("Hutts", 3)

        SpawnUnits(
            table.flatten({
                table.of(4, "MTC_Sensor"),
                "Sedriss_Team",
                "Emperor_Palpatine_Team",
                "General_Veers_Team",
                "Chimera_Pellaeon_Vice",
                "Kanos_Team"
            })
        ):
        OnPlanet("Byss"):
        ForPlayer("Empire"):
        WithFallback():
        End():execute()
    end)

    Event("Trigger_Palpatine_Thrawn_Voluntary"):
    Subscribe(KillFirstObject("Dummy_Regicide_Palpatine"))
end

function Palpatine_CarnorJax()
    StoryEventManager:RegisterEvent(
        Event("Unlock_Jax_Regicide"):
        When(Always()):
        Do(TriggerXmlEvent("UNLOCK_JAX_REGICIDE")):
        WithPrereqs(
            Prereq("Set_Subera_Palpatine"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Lock_Jax_Regicide"):
        When(Always()):
        Do(TriggerXmlEvent("LOCK_JAX_REGICIDE")):
        WithPrereqs(
            Prereq("Trigger_Palpatine_Jax_Timer"):
            Or("Trigger_Jax_Palpatine_Death"):
            Or("Carnor_Researched"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Carnor_Researched"):
        When(
            GameObject("Dummy_Regicide_Jax"):
            FirstIsAlive():
            End()
        ):
        Do(KillFirstObject("Dummy_Regicide_Jax")):
        WithPrereqs(
            Prereq("Unlock_Jax_Regicide"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Trigger_Palpatine_Jax_Timer"):
        When(StoryElapsed(3200)):
        WithPrereqs(
            Prereq("Set_Subera_Palpatine"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Trigger_Jax_Palpatine_Death"):
        When(
            GameObject("Emperor_Palpatine_Team"):
            FirstIsDead():
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Palpatine"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Destroy_Palpatine_Era_Heroes"):
        When(Always()):
        Do(
            CompositeReward(DespawnHero("Chimera")):
            And(DespawnHero("181st_TIE_Interceptor_Squadron")):
            And(DespawnHero("General_Covell_Team")):
            And(DespawnHero("Judicator_Star_Destroyer")):
            And(DespawnHero("Relentless_Star_Destroyer")):
            And(DespawnHero("Joruus_Cboath_Team")):
            And(DespawnHero("Corellian_Gunboat_Ferrier")):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Palpatine"):
            End()
        ):
        End())

    -- just have this for consistency
    StoryEventManager:RegisterEvent(
        Event("Set_Subera_Jax"):
        When(Always()):
        WithPrereqs(
            Prereq("Trigger_Palpatine_Jax_Timer"):
            Or("Trigger_Jax_Palpatine_Death"):
            Or("Carnor_Researched"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Remove_Palpatine"):
        When(Always()):
        Do(DespawnHero("Emperor_Palpatine_Team")):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Spawn_Carnor_Heroes"):
        When(Always()):
        Do(
            CompositeReward(
                SpawnUnits({"Spawn_Carnor", "Kanos_Team"}):
                ForPlayer("Empire"):
                OnPlanet("Byss"):
                WithFallback():
                End()
            ):
            And(
                SpawnUnits({"Emperors_Revenge_Star_Destroyer"}):
                ForPlayer("Empire"):
                OnPlanet("Brentaal"):
                WithFallback():
                End()
            ):
            And(
                SpawnUnits(
                    {
                        "Jeratai_Allegiance",
                        "Xexus_Shev_Team",
                        "Kooloota_Team",
                        "Windcaller_Team",
                        "Manos_Team",
                        "Za_Team",
                        "Immodet_Fortress_Company"
                    }):
                ForPlayer("Empire"):
                OnPlanet("Cantrell"):
                WithFallback():
                End()
            )
        )
    )

    StoryEventManager:RegisterEvent(
        Event("Teradoc_Union_Centares"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Centares"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Centares"):
                    ToPlayer("Teradoc"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Crimson_Victory",
                            "Crimson_Victory",
                            "Crimson_Victory",
                            "Crimson_Victory",
                            "Crimson_Victory",
                            "Crimson_Victory"
                        }):
                    ForPlayer("Teradoc"):
                    OnPlanet("Centares"):
                    OnlyWhenFriendly():
                    End()
                ):End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Teradoc_Union_Hakassi"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Hakassi"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Hakassi"):
                    ToPlayer("Teradoc"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Strike_Cruiser",
                            "Strike_Cruiser",
                            "Strike_Cruiser"
                        }):
                    ForPlayer("Teradoc"):
                    OnPlanet("Hakassi"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())


    StoryEventManager:RegisterEvent(
        Event("Zero_Command_Kalist"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Kalist"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Kalist"):
                    ToPlayer("Harrsk"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Strike_Cruiser",
                            "Strike_Cruiser"
                        }):
                    ForPlayer("Harrsk"):
                    OnPlanet("Kalist"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Pentastar_Entralla"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Entralla"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Entralla"):
                    ToPlayer("Pentastar"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Generic_Bellator",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Strike_Cruiser",
                            "Strike_Cruiser"}):
                    ForPlayer("Pentastar"):
                    OnPlanet("Entralla"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

    StoryEventManager:RegisterEvent(
        Event("Pentastar_Bastion"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Bastion"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Bastion"):
                    ToPlayer("Pentastar"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Generic_Bellator",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two"
                        }):
                    ForPlayer("Pentastar"):
                    OnPlanet("Bastion"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())


    StoryEventManager:RegisterEvent(
        Event("Delvardus_Eriadu"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Eriadu"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Eriadu"):
                    ToPlayer("Hutts"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Torpedo_Sphere",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Escort_Carrier",
                            "Escort_Carrier",
                            "Torpedo_Sphere",
                            "Torpedo_Sphere",
                            "P_Ground_Barracks",
                            "P_Ground_Light_Vehicle_Factory"
                        }):
                    ForPlayer("Hutts"):
                    OnPlanet("Eriadu"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())


    StoryEventManager:RegisterEvent(
        Event("Delvardus_Kampe"):
        When(Always()):
        Do(
            If(
                Faction("Empire"):
                Owns("Kampe"):
                End()
            ):
            Then(
                CompositeReward(
                    ChangePlanetOwner("Kampe"):
                    ToPlayer("Hutts"):
                    WithRetreat():
                    End()
                ):
                And(
                    SpawnUnits(
                        {
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Assault_Company",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Heavy_Scout_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Imperial_Stormtrooper_Squad",
                            "Torpedo_Sphere",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Generic_Star_Destroyer_Two",
                            "Escort_Carrier",
                            "Escort_Carrier",
                            "Escort_Carrier"
                        }):
                    ForPlayer("Hutts"):
                    OnPlanet("Eriadu"):
                    OnlyWhenFriendly():
                    End()
                ):
                End()
            ):
            End()
        ):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

end

function CarnorJax_Daala()
    StoryEventManager:RegisterEvent(
        Event("Unlock_Daala_Regicide"):
        When(Always()):
        Do(TriggerXmlEvent("UNLOCK_DAALA_REGICIDE")):
        WithPrereqs(
            Prereq("Set_Subera_Jax"):
            End()
        ):
        End())

    
end