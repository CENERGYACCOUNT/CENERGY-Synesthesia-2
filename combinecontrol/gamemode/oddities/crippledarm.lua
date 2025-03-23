ODDITY.ID				= "crippledarm";
ODDITY.Name 			= "Crippled Arm";
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
ply:SetCrippledArm( true );
    end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "MY arm is fine!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAttack( math.Clamp( ply:Attack()  -7.5, -1000, 1000 ) );
ply:SetCrippledArm( false );
    end end