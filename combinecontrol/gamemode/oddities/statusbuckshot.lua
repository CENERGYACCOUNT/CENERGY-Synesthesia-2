ODDITY.ID				= "statusbuckshot";
ODDITY.Name 			= "Status: Buckshot";
ODDITY.Description		= "Your next shotgun attack is primed to an stun enemy, instead of dealing damage.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You load a buckshot.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then


 end end