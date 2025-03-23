ODDITY.ID				= "statusoverwatch";
ODDITY.Name 			= "Status: Overwatch";
ODDITY.Description		= "Gain attack points on your enemies turn, you can fire at moving enemies.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "I am on Overwatch.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then


 end end