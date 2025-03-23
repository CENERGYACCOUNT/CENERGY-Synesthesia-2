ODDITY.ID				= "statuspointer";
ODDITY.Name 			= "Status: Pointer";
ODDITY.Description		= "Gain 10 Resistance if you are near enemy.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You gain your Pointer buff!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetResistance( math.Clamp( ply:Resistance()  +10, -1000, 1000 ) );
	ply:EmitSound("npc/roller/blade_in.wav")
 end end

ODDITY.OnRemoved	= function( self, ply )

if ( SERVER ) then
	ply:SetResistance( math.Clamp( ply:Resistance()  -10, -1000, 1000 ) );

 end end