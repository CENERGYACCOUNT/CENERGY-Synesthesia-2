FLAG.PrintName 	= "Overwatch Commander";
FLAG.Flag 		= "Q";
FLAG.Team		= TEAM_OVERWATCH;
FLAG.Loadout	= { "weapon_cc_hands", "weapon_cc_flare", "weapon_cc_ar2", "weapon_cc_csniper", "weapon_cc_beanbag", "weapon_cc_doorbreach", "weapon_cc_shotgun", "weapon_cc_grenade", "weapon_cc_flashbang" };
local ARMOR = 500

function FLAG.ModelFunc( ply )	
	ply:SetHunger( math.max( ply:Hunger() - 100, 0 ) );
	ply:UpdateCharacterField( "Hunger", ply:Hunger() );
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
	ply:UpdateCharacterField( "StatAim", tostring( ply:Aim() ), true );

	ply:SetArmor( ARMOR )
	
	return "models/tnb/combine/combine_dvl.mdl";
end
