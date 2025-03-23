ODDITY.ID				= "injurylight2";
ODDITY.Name 			= "Injury: Open Wound";
ODDITY.Description		= "Lose 25% Max Health";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;


ODDITY.RemoveOnTurnEnd          = false;



ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You have an opem wound!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:SetBonusHealth( math.Clamp( ply:BonusHealth()  -25, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatBonusHealth", tostring(ply:BonusHealth() ), true ); -- special

 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your wound had healed.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetBonusHealth( math.Clamp( ply:BonusHealth()  +25, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatBonusHealth", tostring(ply:BonusHealth() ), true ); -- special

end end