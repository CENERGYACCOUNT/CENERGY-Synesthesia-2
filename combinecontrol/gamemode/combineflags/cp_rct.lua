FLAG.PrintName 		= "Recruit";
FLAG.Flag 			= "A";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_stunstick", "weapon_cc_pistol", "smallmedkit" };
FLAG.CharName		= "CCA-C45.RcT.$CID";
FLAG.CanSpawn		= false;
FLAG.CanBroadcast	= false;
FLAG.CanEditLoans	= false;
FLAG.CanEditCPs		= false;
FLAG.CanJW			= false;
FLAG.PromoteTo		= "B";

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/dpfilms/metropolice/playermodels/pm_female_police.mdl";
		
	end
	
	return "models/dpfilms/metropolice/playermodels/pm_hdpolice.mdl";
	
end