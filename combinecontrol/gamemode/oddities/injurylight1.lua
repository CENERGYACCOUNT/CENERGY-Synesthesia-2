ODDITY.ID				= "injurylight1";
ODDITY.Name 			= "Injury: Broken Bone";
ODDITY.Description		= "Lose 25 Dodge and -2.5 Max Movement Speed";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;


ODDITY.RemoveOnTurnEnd          = false;



ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your leg bone had snapped!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetMovement( math.Clamp( ply:Movement()  -2.5, -1000, 1000 ) );
    ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  -25, -1000, 1000 ) );
    ply:SetDodge( math.Clamp( ply:Dodge()  -25, -1000, 1000 ) );
	ply:SetExtraMovement( math.Clamp( ply:ExtraMovement()  -2.5, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatExtraMovement", tostring(ply:ExtraMovement() ), true ); -- special
    ply:UpdateCharacterField( "StatDodge", tostring(ply:Dodge() ), true ); -- special
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your leg had healed.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetMovement( math.Clamp( ply:Movement()  +2.5, -1000, 1000 ) );
    ply:SetExtraMovement( math.Clamp( ply:ExtraMovement()  +2.5, -1000, 1000 ) );
    ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  +25, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatExtraMovement", tostring(ply:ExtraMovement() ), true ); -- special
    ply:UpdateCharacterField( "StatDodge", tostring(ply:Dodge() ), true ); -- special
end end