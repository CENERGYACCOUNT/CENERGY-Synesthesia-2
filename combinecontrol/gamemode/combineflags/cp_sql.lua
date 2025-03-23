FLAG.PrintName 		= "Squad Leader";
FLAG.Flag 			= "D";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_flashbang", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_glock17", "weapon_cc_m16", "weapon_cc_acr", "weapon_cc_p99", "weapon_cc_kriss", "weapon_cc_mossberg", "weapon_cc_knife", "weapon_cc_fnf2000", "weapon_cc_beanbag", "weapon_cc_doorbreach" };
FLAG.CharName		= "CCA-C45.LDR-$SQUAD.$CID";
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= false;
FLAG.CanEditCPs		= true;
FLAG.CanJW			= true;

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/metropolice/playermodels/pm_eliteshockcp_v2.mdl";
		
	end
	
	return "models/metropolice/playermodels/pm_eliteshockcp.mdl";
	
end
