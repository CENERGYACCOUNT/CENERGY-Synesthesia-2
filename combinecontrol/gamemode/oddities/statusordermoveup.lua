ODDITY.ID				= "statusordermoveup";
ODDITY.Name 			= "Status: Order - Move up!"
ODDITY.Description		= "Gain 10M";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were ordered to move up!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetMovement( math.Clamp( ply:Movement()  + 10, -1000, 1000 ) );
 end end

