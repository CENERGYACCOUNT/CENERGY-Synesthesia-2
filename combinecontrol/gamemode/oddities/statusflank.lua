ODDITY.ID				= "statusflank";
ODDITY.Name 			= "Status: Flank";
ODDITY.Description		= "Gain 10 Movement, can be used once per battle.";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;


ODDITY.RemoveOnTurnEnd          = false;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(ply:GetOddity(oddityID))
    end
end

ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are flanking!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetMovement( math.Clamp( ply:Movement()  +10, -1000, 1000 ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer flanking!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

 end end