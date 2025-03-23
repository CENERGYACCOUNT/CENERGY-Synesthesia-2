ODDITY.ID				= "statusadaptreflexes";
ODDITY.Name 			= "Status: Adapt - Focus";
ODDITY.Description		= "Gain 25% Reflexes for one turn.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are now in focused mode!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetReflexesTemporary( math.Clamp( ply:ReflexesTemporary()  +25, -1000, 1000 ) );
	ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  +12.5, -1000, 1000 ) );
	ply:SetParryTemporary( math.Clamp( ply:ParryTemporary()  +16.5, -1000, 1000 ) );
	ply:SetAttack( math.Clamp( ply:Attack()  + 1, -1000, 1000 ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer in focused mode.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetReflexesTemporary( math.Clamp( ply:ReflexesTemporary()  -25, -1000, 1000 ) );
ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -12.5, -1000, 1000 ) );
ply:SetParryTemporary( math.Clamp( ply:ParryTemporary()  -16.5, -1000, 1000 ) );
end end