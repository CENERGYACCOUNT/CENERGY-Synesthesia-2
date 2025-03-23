FLAG.PrintName 		= "Division Leader";
FLAG.Flag 			= "E";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_flashbang", "smallmedkit", "weapon_cc_medkit", "weapon_cc_cityscanner", "weapon_cc_manhack", "combineturret", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_glock17", "weapon_cc_hk416", "weapon_cc_m16", "weapon_cc_acr", "weapon_cc_p99", "weapon_cc_kriss", "weapon_cc_spas12", "weapon_cc_knife", "weapon_cc_beanbag", "weapon_cc_doorbreach" };
FLAG.CharName		= "CCA-C45.DvL-$SQUAD.$CID";
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= true;
FLAG.CanEditCPs		= true;
FLAG.CanJW			= true;

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/metropolice/playermodels/pm_leet_police_v2.mdl";
		
	end
	
	return "models/metropolice/playermodels/pm_leet_police.mdl";
	
end