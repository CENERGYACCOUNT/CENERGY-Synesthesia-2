ODDITY.ID				= "crippledleg";
ODDITY.Name 			= "Crippled Leg";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My leg is hit!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetCrippledLeg( true );
    end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My leg is fine!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetMovement( math.Clamp( ply:Movement()  -7.5, -1000, 1000 ) );
ply:SetCrippledLeg( false );
    end end