ODDITY.ID				= "statusordernostep";
ODDITY.Name 			= "Status: Order - No Step Back!"
ODDITY.Description		= "Lose 5M";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were ordered to make not one step back!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
		ply:SetResistance( math.Clamp( ply:Resistance() +25, -1000, 1000 ) );
 end end


ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then

if ( SERVER ) then
	ply:SetResistance( math.Clamp( ply:Resistance() -25, -1000, 1000 ) );
	ply:SetMovement( math.Clamp( ply:Movement()  - 5, -1000, 1000 ) );
end end end