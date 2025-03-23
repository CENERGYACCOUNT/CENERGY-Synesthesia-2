ODDITY.ID				= "statusorderattack";
ODDITY.Name 			= "Status: Order - Attack!"
ODDITY.Description		= "Gain 5M";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were ordered to assault the enemy!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAttack( math.Clamp( ply:Attack()  + 5, -1000, 1000 ) );
 end end

