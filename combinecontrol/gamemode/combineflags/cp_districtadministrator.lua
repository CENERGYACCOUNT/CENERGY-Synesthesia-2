FLAG.PrintName 		= "District Administrator";
FLAG.Flag 			= "J";
FLAG.CharName		= "UU-C45.DA.$CID";
FLAG.Loadout		= { "weapon_cc_hands", "radio", "zipties", "smallmedkit", "weapon_cc_357" };
FLAG.Color			= Color( 155, 180, 217, 255 );
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= true;
FLAG.CanEditCPs		= true;
FLAG.CanJW			= true;

function FLAG.ModelFunc( ply )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl";
		
	end
	
	return "models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl";
	
end