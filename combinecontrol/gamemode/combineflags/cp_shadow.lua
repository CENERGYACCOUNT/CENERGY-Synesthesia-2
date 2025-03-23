FLAG.PrintName 		= "SHADOW";
FLAG.Flag 			= "H";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "radio", "zipties", "weapon_cc_flashbang", "smallmedkit", "weapon_cc_medkit", "weapon_cc_stunstick", "weapon_cc_flare", "weapon_cc_grenade", "weapon_cc_357", "weapon_cc_p99", "weapon_cc_ar2", "weapon_cc_tar21", "weapon_cc_kriss", "weapon_cc_beanbag", "weapon_cc_doorbreach" };
FLAG.CharName		= "CCA-C45.SHADOW.$CID";
FLAG.CanSpawn		= true;
FLAG.CanBroadcast	= true;
FLAG.CanEditLoans	= false;
FLAG.CanEditCPs		= false;
FLAG.CanJW			= false;

function FLAG.ModelFunc( ply )

	ply:SetMoney( 0 );
	ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
	
	ply:SetSpeed( 100 )
	ply:UpdateCharacterField( "StatSpeed", tostring( ply:Speed() ), true );
	
	ply:SetStrength( 100 )
	ply:UpdateCharacterField( "StatStrength", tostring( ply:Strength() ), true );
	
	ply:SetToughness( 100 )
	ply:UpdateCharacterField( "StatToughness", tostring( ply:Toughness() ), true );
	
	ply:SetPerception( 100 )
	ply:UpdateCharacterField( "StatPerception", tostring( ply:Perception() ), true );
	
	ply:SetAgility( 100 )
	ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ), true );
	
	ply:SetAim( 100 )
	ply:UpdateCharacterField( "StatAim", tostring( ply:Aim() ), true )
	
	if( ply:Gender() == GENDER_FEMALE ) then
		
		return "models/dpfilms/metropolice/playermodels/pm_police_bt.mdl";
		
	end
	
	return "models/dpfilms/metropolice/playermodels/pm_police_bt.mdl";
	
end
