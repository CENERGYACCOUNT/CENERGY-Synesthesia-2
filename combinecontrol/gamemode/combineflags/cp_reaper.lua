FLAG.PrintName 		= "REAPER";
FLAG.Flag 			= "I";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_flashbang", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_grenade", "weapon_cc_p99", "weapon_cc_csniper", "weapon_cc_tar21", "weapon_cc_asval", "weapon_cc_kriss", "weapon_cc_beanbag", "weapon_cc_doorbreach" };
FLAG.CharName		= "CCA-C45.REAPER.$CID";
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= false;
FLAG.CanEditCPs		= false;
FLAG.CanJW			= true;

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/dpfilms/metropolice/playermodels/pm_urban_police.mdl";
		
	end
	
	return "models/dpfilms/metropolice/playermodels/pm_urban_police.mdl";
	
end
