ODDITY.ID				= "statusadaptmuscle";
ODDITY.Name 			= "Status: Adapt - Defense";
ODDITY.Description		= "Gain 25% Muscle for one turn.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are now in defense mode!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetMuscleTemporary( math.Clamp( ply:MuscleTemporary()  +25, -1000, 1000 ) );
	ply:SetResistance( math.Clamp( ply:Resistance()  +15, -1000, 1000 ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer in defense mode.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetMuscleTemporary( math.Clamp( ply:MuscleTemporary()  -25, -1000, 1000 ) );
	ply:SetResistance( math.Clamp( ply:Resistance() -15, -1000, 1000 ) );

end end