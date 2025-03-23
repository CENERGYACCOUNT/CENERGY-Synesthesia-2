ODDITY.ID				= "statuspindown";
ODDITY.Name 			= "Status: Pin Down";
ODDITY.Description		= "Increase your suppression chance by 25%.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You prepare to pin an enemy.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then


 end end