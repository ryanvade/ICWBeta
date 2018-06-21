-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/GalacticHeroFreeStore.lua#2 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/FreeStore/GalacticHeroFreeStore.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 56728 $
--
--          $DateTime: 2006/10/24 14:14:34 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgcommands")

function Definitions()
	DebugMessage("%s -- Defining custom freestore movement perceptions", tostring(Script))

	-- Table which maps heroes to perceptions for systems they like to hang out on when not in active use
	-- The boolean is for whether or not the hero prefers to stay in space, if he has a choice
	-- Generally, this is to find the system where their abilities provide the best defensive or infrastructure bonuses
	CustomUnitPlacement = {
		ARALANI_FRONTIER = {nil, true}
		,ASHIK_TEAM = {nil, false}
		,CHAK_FEL_KRSISS_SQUADRON_ASSOCIATION = {nil, true}
		,CHIMERA = {nil, true}
		,JAG_FEL_SQUADRON_TEAM = {nil, true}
		,NIRIZ_ADMONITOR = {nil, true}
		,PARCK_STRIKEFAST = {nil, true}
		,SIATH_BATTLEHAMMER = {nil, true}
		,SOONTIR_FEL_SQUADRON = {nil, true}
		,STENT_THRAWNS_HAND = {nil, true}
		
		
		,ANDAL_TEAM = {"Is_Production_Planet", false}
		,BOSSK_TEAM = {nil, false}
		,KABALIAN_STAR_DESTROYER = {nil, true}
		,NIGHT_HAMMER = {nil, true}
		,NIGHT_HAMMER_DELVARDUS = {"Is_Home_Planet", true}
		,PRITTICK_TYRANT = {nil, true}
		,PRYL_THUNDERFLARE = {nil, true}
		,RETRIBUTION_STAR_DESTROYER = {nil, true}
		,SWORD_SQUADRON = {nil, true}
		,THALASSA = {nil, true}
		,VICTOR_STRANG_TEAM = {nil, false}
		,WEIR_TEAM = {nil, false}
		,ZED_STALKER = {nil, true}
		
		,AGONIZER_STAR_DESTROYER = {nil, true}
		,ASCIAN = {nil, true}
		,BANJEER_NEUTRON = {nil, true}
		,BRAKISS_TEAM = {nil, false}
		,BROTHIC_TEAM = {nil, false}
		,CARNOR_JAX_TEAM = {"Is_Home_Planet", false}
		,CHIMERA_PELLAEON_GRAND = {nil, true}
		,CHIMERA_PELLAEON_VICE = {nil, true}
		,CORELLIAN_GUNBOAT_FERRIER = {nil, true}
		,CORRUPTER_STAR_DESTROYER = {nil, true}
		,CRIMSONSUNRISE_STAR_DESTROYER = {nil, true}
		,DARRON_DIREPTION = {nil, true}
		,ELITE_SQUADRON = {nil, true}
		,EMPERORS_REVENGE_STAR_DESTROYER = {nil, true}
		,EMPEROR_PALPATINE_TEAM = {"Is_Home_Planet", true}
		,GENERAL_COVELL_TEAM = {nil, false}
		,GENERAL_VEERS_TEAM = {nil, false}
		,GORGON = {nil, true}
		,GRUNGER_AGGRESSOR = {nil, true}
		,IMMODET_FORTRESS_COMPANY = {nil, false}
		,ISARD_CLONE_TEAM = {"Is_Home_Planet", false}
		,JORUUS_CBOATH_TEAM = {nil, false}
		,JUDICATOR_STAR_DESTROYER = {nil, true}
		,KERMEN_BELLIGERENT = {nil, true}
		,KLEV_SILENCER7 = {nil, true}
		,KNIGHT_HAMMER = {"Is_Home_Planet", true}
		,KOOLOOTA_TEAM = {"Is_Production_Planet", false}
		,LUKE_SKYWALKER_DARKSIDE_TEAM = {"Is_Home_Planet", false}
		,LUSANKYA = {"Is_Home_Planet", true}
		,MAKATI_STEADFAST = {nil, true}
		,MANOS_TEAM = {"Is_Production_Planet", false}
		,MELVAR_TEAM = {nil, false}
		,NAVETT_TEAM = {nil, false}
		,PELLAEON_REAPER = {"Is_Home_Planet", true}
		,PESTAGE_TEAM = {"Is_Home_Planet", false}
		,PHULIK_BINDER = {nil, true}
		,PITTA_TORPEDO_SPHERE = {nil, true}
		,PRENTIOCH_PRENTIOCH = {nil, true}
		,RECKONING_STAR_DESTROYER = {nil, true}
		,RELENTLESS_STAR_DESTROYER = {nil, true}
		,ROGRISS_AURORA = {nil, true}
		,ROGRISS_DOMINION = {nil, true}
		,SCYLLA = {nil, true}
		,SEDRISS_TEAM = {nil, false}
		,SHOCKWAVE_STAR_DESTROYER = {nil, true}
		,SINISTER_RELENTLESS = {nil, true}
		,TAKEL_MAGICDRAGON = {nil, true}
		,TIERCE_TEAM = {nil, false}
		,WINDCALLER_TEAM = {nil, false}
		,YONKA_AVARICE = {nil, true}
		,ZA_TEAM = {nil, false}
		,["13X"] = {nil, true}
		,["181ST_FEL_SQUADRON"] = {nil, true}
		,["181ST_STELE"] = {nil, true}
		,["181ST_TIE_INTERCEPTOR_SQUADRON"] = {nil, true}
		
		,ABAHT_INTREPID = {nil, true}
		,ACKBAR_GUARDIAN = {nil, true}
		,AIREN_CRACKEN_TEAM = {"Is_Production_Planet", false}
		,BELL_ENDURANCE = {nil, true}
		,BELL_SWIFT_LIBERTY = {nil, true}
		,CILGHAL_TEAM = {nil, false}
		,ERRANT_VENTURE = {nil, true}
		,ERRANT_VENTURE_FULL = {nil, true}
		,ERRANT_VENTURE_TWO = {nil, true}
		,GALACTIC_VOYAGER = {"Is_Production_Planet", true}
		,GAVRISOM_TEAM = {"Is_Home_Planet", false}
		,HOME_ONE = {"Is_Production_Planet", true}
		,IBLIS_PEREGRINE = {nil, true}
		,IBLIS_SELONIAN_FIRE = {nil, true}
		,IILLOR_CORUSCA = {nil, true}
		,KATARN_TEAM = {nil, false}
		,LANDO_CALRISSIAN_TEAM = {"Is_Home_Planet", false}
		,MARA_SABER_TEAM = {nil, false}
		,MILLENNIUM_FALCON = {nil, true}
		,MIRAX_TEAM = {"Is_Home_Planet", false}
		,MON_MOTHMA_TEAM = {"Is_Home_Planet", false}
		,NANTZ_INDEPENDENCE = {nil, true}
		,PRINCESS_LEIA_TEAM = {"Is_Production_Planet", false}
		,PRINCESS_LEIA_TEAM_NOGHRI = {"Is_Home_Planet", false}
		,ROGUE_SQUADRON_SPACE = {nil, true}
		,SOLO_REMONDA = {nil, true}
		,SOVV_DAUNTLESS = {nil, true}
		,VANTAI_MOONSHADOW = {nil, true}
		,WEDGE_LUSANKYA = {"Is_Home_Planet", true}
		,WILD_KARRDE = {nil, true}
		,YONKA_FREEDOM = {nil, true}
		
		,DEKEET_PRAETOR = {nil, true}
		,DYNAMIC_BESK = {nil, true}
		,GRANT_ORIFLAMME = {nil, true}
		,GREGOR_TEAM = {"Is_Production_Planet", false}
		,JEREC_TEAM = {nil, false}
		,OTRO_ENFORCER = {nil, true}
		,REAPER_KAINE = {"Is_Home_Planet", true}
		,REIKAS_TEAM = {nil, false}
		,SARISS_TEAM = {nil, false}
		,TRELIX_INDENTURE = {nil, true}
		
		,BOBA_FETT_TEAM = {nil, false}
		,GENDARR_RELIANCE = {nil, true}
		,GETELLES_TEAM = {"Is_Production_Planet", false}
		,LANCET_KOSH = {nil, true}
		,LARM_CARRACK = {nil, true}
		,LOTT_TEAM = {"Is_Production_Planet", false}
		,OKINS_ALLEGIANCE = {nil, true}
		,RAMIER_TEAM = {"Is_Production_Planet", false}
		,SYN_SILOOTH = {nil, true}
		,TAVIRA_INVIDIOUS = {nil, true}
		,TRIER_SECUTOR = {nil, true}
		,["13X_PELLAEON"] = {nil, true}
		,["13X_TERADOC"] = {"Is_Home_Planet", true}
		
		,BANJEER = {nil, true}
		,DEMOLISHER = {nil, true}
		,GETHZERION_TEAM = {nil, false}
		,IMPLACABLE_STAR_DESTROYER = {nil, true}
		,IRON_FIST = {"Is_Home_Planet", true}
		,KRIN_LUCREHULK = {nil, true}
		,LANU_TEAM = {nil, false}
		,NETBERS_TEAM = {nil, false}
		,NIGHT_CALLER = {nil, true}
		,RAZORS_KISS = {"Is_Home_Planet", true}
		,TEUBBO_TEAM = {"Is_Production_Planet", false}
		,["181ST_COWALL"] = {nil, true}
	}
	
end

function Find_Custom_Target(object)
	object_type = object.Get_Type()
	object_type_name = object_type.Get_Name()

	unit_entry = CustomUnitPlacement[object_type_name]

	if unit_entry then
		perception = unit_entry[1]
		prefers_space = unit_entry[2]
		if perception then
			target = FindTarget.Reachable_Target(PlayerObject, perception, "Friendly", "No_Threat", 1.0, object)
			if TestValid(target) then
				return target
			end
		end
		
		if prefers_space then
			return Find_Space_Unit_Target(object)
		else
			return Find_Ground_Unit_Target(object)
		end
	else
		DebugMessage("%s -- Error: Type %s not found in CustomUnitPlacement table.", tostring(Script), object_type_name)
	end
end
	

