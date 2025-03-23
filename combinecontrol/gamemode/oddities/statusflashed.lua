ODDITY.ID				= "statusflashed";
ODDITY.Name 			= "Status: Flashed";
ODDITY.Description		= "Lose 50% Accuracy for two turns. If you are on Overwatch, lose the Attack Points you have and Overwatch status.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You got flashed!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

        ply:SetAttack( math.Clamp( ply:Attack()  -10, -1000, 1000 ) );
        ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -50, -1000, 1000 ) );
        ply:RemoveOddity( ply:GetOddity( "statusoverwatch" ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then 
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I am no longer flashed.", { CB_ALL, CB_IC }, nil, guy ); end
if ( SERVER ) then
        ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  +50, -1000, 1000 ) );
        ply:SetAttack( math.Clamp( ply:Attack()  -5, -1000, 1000 ) );
        ply:GiveOddity("statusflashed2")
end end