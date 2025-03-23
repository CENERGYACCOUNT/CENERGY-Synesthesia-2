FLAG.PrintName 		= "Ground Unit";
FLAG.Flag 			= "B";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_flashbang", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_glock17", "weapon_cc_pistol", "weapon_cc_m16", "weapon_cc_ump45", "weapon_cc_mossberg", "weapon_cc_knife", "weapon_cc_smg", "weapon_cc_fnf2000", "weapon_cc_beanbag", "weapon_cc_doorbreach" };
FLAG.CharName		= "CCA-C45.$SQUAD-$ID.$CID";
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= false;
FLAG.CanEditCPs		= false;
FLAG.CanJW			= false;

FLAG.DemoteTo		= "A";

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/metropolice/playermodels/pm_female_police2.mdl";
		
	end
	
	return "models/dpfilms/metropolice/playermodels/pm_hl2concept.mdl";
	
end
