ODDITY.ID				= "supressed1";
ODDITY.Name 			= "supressed1";
ODDITY.Description		= "You are supressed!";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;
ODDITY.RemoveOnTurnEnd          = true;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(ply:GetOddity(oddityID))
    end
end



ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I am being supressed!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetAttack( math.Clamp( ply:Attack()  -10, -1000, 1000 ) );
    ply:SetSupressed( true );
    end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I am no longer supressed!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetMovement( math.Clamp( ply:Movement()  -5, -1000, 1000 ) );
    ply:SetSupressed( false );
    
    end end