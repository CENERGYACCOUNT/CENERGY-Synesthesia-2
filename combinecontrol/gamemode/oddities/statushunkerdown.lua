ODDITY.ID				= "statushunkerdown";
ODDITY.Name 			= "Status: Hunker Down";
ODDITY.Description		= "Gain 10% Resistance and 25% Accuracy";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are hunkered down!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  +25, -1000, 1000 ) );
	ply:SetResistance( math.Clamp( ply:Resistance()  +10, -1000, 1000 ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer hunkered down.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -25, -1000, 1000 ) );
	ply:SetResistance( math.Clamp( ply:Resistance() -10, -1000, 1000 ) );

end end