ODDITY.ID				= "statusstable";
ODDITY.Name 			= "statusstable";
ODDITY.Description		= "Your aim is stable!";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My aim is stable!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  +25, -1000, 1000 ) );
    end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My aim is no longer stable.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -25, -1000, 1000 ) );
    end end