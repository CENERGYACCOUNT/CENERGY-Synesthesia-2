ODDITY.ID				= "statuskneeshooting";
ODDITY.Name 			= "Status: Knee Shooting";
ODDITY.Description		= "Gain 25% extra chance to cripple someone with rifles.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "It's knee shootin' time!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then


 end end