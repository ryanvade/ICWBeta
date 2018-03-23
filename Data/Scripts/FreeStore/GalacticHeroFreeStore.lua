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
		ASHIK_TEAM = {nil, false}
		,SOONTIR_FEL_SQUADRON = {nil, true}
		,JAG_FEL_SQUADRON_TEAM = {nil, true}
		,CHAK_FEL_KRSISS_SQUADRON_ASSOCIATION = {nil, true}
		,STENT_THRAWNS_HAND = {nil, true}
		,NIRIZ_ADMONITOR = {nil, true}
		,PARCK_STRIKEFAST = {nil, true}
		,SIATH_BATTLEHAMMER = {nil, true}
		,ARALANI_FRONTIER = {nil, true}
		
		,NIGHT_HAMMER_DELVARDUS = {"Is_Home_Planet", true}
		,THALASSA = {nil, true}
		,PRITTICK_TYRANT = {nil, true}
		,SWORD_SQUADRON = {nil, true}
		,KABALIAN_STAR_DESTROYER = {nil, true}
		,RETRIBUTION_STAR_DESTROYER = {nil, true}
		,PRYL_THUNDERFLARE = {nil, true}
		,NIGHT_HAMMER = {nil, true}
		,ANDAL_TEAM = {"Is_Production_Planet", false}
		,ZED_STALKER = {nil, true}
		,BOSSK_TEAM = {nil, false}
		,WEIR_TEAM = {nil, false}
		,VICTOR_STRANG_TEAM = {nil, false}
		
		,CARNOR_JAX_TEAM = {"Is_Home_Planet", false}
		,PESTAGE_TEAM = {"Is_Home_Planet", false}
		,MELVAR_TEAM = {nil, false}
		,BRAKISS_TEAM = {nil, false}
		,NAVETT_TEAM = {nil, false}
		,["181ST_STELE"] = {nil, true}
		,ELITE_SQUADRON = {nil, true}
		,SHOCKWAVE_STAR_DESTROYER = {nil, true}
		,RECKONING_STAR_DESTROYER = {nil, true}
		,CORRUPTER_STAR_DESTROYER = {nil, true}
		,SCYLLA = {nil, true}
		,KNIGHT_HAMMER = {"Is_Home_Planet", true}
		,GORGON = {nil, true}
		,CRIMSONSUNRISE_STAR_DESTROYER = {nil, true}
		,ASCIAN = {nil, true}
		,["13X"] = {nil, true}
		,SEDRISS_TEAM = {nil, false}
		,["181ST_TIE_INTERCEPTOR_SQUADRON"] = {nil, true}
		,["181ST_FEL"] = {nil, true}
		,JUDICATOR_STAR_DESTROYER = {nil, true}
		,RELENTLESS_STAR_DESTROYER = {nil, true}
		,GENERAL_COVELL_TEAM = {nil, false}
		,AGONIZER_STAR_DESTROYER = {nil, true}
		,EMPERORS_REVENGE_STAR_DESTROYER = {nil, true}
		,ROGRISS_AURORA = {nil, true}
		,ROGRISS_DOMINION = {nil, true}
		,LUSANKYA = {"Is_Home_Planet", true}
		,GENERAL_VEERS_TEAM = {nil, false}
		,CHIMERA_PELLAEON_VICE = {nil, true}
		,PELLAEON_REAPER = {"Is_Home_Planet", true}
		,CHIMERA_PELLAEON_GRAND = {nil, true}
		,EMPEROR_PALPATINE_TEAM = {"Is_Home_Planet", true}
		,CORELLIAN_GUNBOAT_FERRIER = {nil, true}
		,JORUUS_CBOATH_TEAM = {nil, false}
		,TIERCE_TEAM = {nil, false}
		,SINISTER_RELENTLESS = {nil, true}
		,GRUNGER_AGGRESSOR = {nil, true}
		,MAKATI_STEADFAST = {nil, true}
		,TAKEL_MAGICDRAGON = {nil, true}
		,PITTA_TORPEDO_SPHERE = {nil, true}
		,KLEV_SILENCER7 = {nil, true}
		,PRENTIOCH_PRENTIOCH = {nil, true}
		,KERMEN_BELLIGERENT = {nil, true}
		,LUKE_SKYWALKER_DARKSIDE_TEAM = {"Is_Home_Planet", false}
		,YONKA_AVARICE = {nil, true}
		,DARRON_DIREPTION = {nil, true}
		,PHULIK_BINDER = {nil, true}
		,BROTHIC_TEAM = {nil, false}
		,ISARD_CLONE_TEAM = {"Is_Home_Planet", false}
		
		,ABAHT_INTREPID = {nil, true}
		,IILLOR_CORUSCA = {nil, true}
		,WILD_KARRDE = {nil, true}
		,AIREN_CRACKEN_TEAM = {"Is_Production_Planet", false}
		,IBLIS_PEREGRINE = {nil, true}
		,IBLIS_SELONIAN_FIRE = {nil, true}
		,HOME_ONE = {"Is_Production_Planet", true}
		,GALACTIC_VOYAGER = {"Is_Production_Planet", true}
		,ACKBAR_GUARDIAN = {nil, true}
		,SOLO_REMONDA = {nil, true}
		,LANDO_CALRISSIAN_TEAM = {"Is_Home_Planet", false}
		,PRINCESS_LEIA_TEAM = {"Is_Production_Planet", false}
		,PRINCESS_LEIA_TEAM_NOGHRI = {"Is_Home_Planet", false}
		,KATARN_TEAM = {nil, false}
		,MON_MOTHMA_TEAM = {"Is_Home_Planet", false}
		,GAVRISOM_TEAM = {"Is_Home_Planet", false}
		,MARA_SABER_TEAM = {nil, false}
		,ERRANT_VENTURE_FULL = {nil, true}
		,ERRANT_VENTURE = {nil, true}
		,ERRANT_VENTURE_TWO = {nil, true}
		,WEDGE_LUSANKYA = {"Is_Home_Planet", true}
		,CILGHAL_TEAM = {nil, false}
		,NANTZ_INDEPENDENCE = {nil, true}
		,SOVV_DAUNTLESS = {nil, true}
		,BELL_ENDURANCE = {nil, true}
		,BELL_SWIFT_LIBERTY = {nil, true}
		,YONKA_FREEDOM = {nil, true}
		,VANTAI_MOONSHADOW = {nil, true}
		,MIRAX_TEAM = {"Is_Home_Planet", false}
		
		,REIKAS_TEAM = {nil, false}
		,SARISS_TEAM = {nil, false}
		,REAPER_KAINE = {"Is_Home_Planet", true}
		,DYNAMIC_BESK = {nil, true}
		,DEKEET_PRAETOR = {nil, true}
		,JEREC_TEAM = {nil, false}
		,GRANT_ORIFLAMME = {nil, true}
		,GREGOR_TEAM = {"Is_Production_Planet", false}
		,OTRO_ENFORCER = {nil, true}
		,TRELIX_INDENTURE = {nil, true}
		
		,["13X_TERADOC"] = {"Is_Home_Planet", true}
		,LANCET_KOSH = {nil, true}
		,SYN_SILOOTH = {nil, true}
		,GETELLES_TEAM = {"Is_Production_Planet", false}
		,LARM_CARRACK = {nil, true}
		,GENDARR_RELIANCE = {nil, true}
		,LOTT_TEAM = {"Is_Production_Planet", false}
		,["13X_PELLAEON"] = {nil, true}
		,TRIER_SECUTOR = {nil, true}
		,OKINS_ALLEGIANCE = {nil, true}
		,RAMIER_TEAM = {"Is_Production_Planet", false}
		,BOBA_FETT_TEAM = {nil, false}
		,TAVIRA_INVIDIOUS = {nil, true}
		
		,RAZORS_KISS = {"Is_Home_Planet", true}
		,LANU_TEAM = {nil, false}
		,BANJEER = {nil, true}
		,NIGHT_CALLER = {nil, true}
		,["181ST_COWALL"] = {nil, true}
		,IRON_FIST = {"Is_Home_Planet", true}
		,KRIN_LUCREHULK = {nil, true}
		,TEUBBO_TEAM = {"Is_Production_Planet", false}
		,IMPLACABLE_STAR_DESTROYER = {nil, true}
		,DEMOLISHER = {nil, true}
		,GETHZERION_TEAM = {nil, false}
		,NETBERS_TEAM = {nil, false}
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
	

