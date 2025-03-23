ODDITY.ID				= "statusheadhunting";
ODDITY.Name 			= "Status: Head Hunting";
ODDITY.Description		= "Gain 50% extra damage on headshots with rifles.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "It's head huntin' time!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then


 end end