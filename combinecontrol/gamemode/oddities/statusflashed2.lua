ODDITY.ID				= "statusflashed2";
ODDITY.Name 			= "Status: Flash Aftermath";
ODDITY.Description		= "Lose 50% Accuracy for a turn and 5 Attack.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You suffer from flash aftermath.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

    
        ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -50, -1000, 1000 ) );
    
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then 
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I no longer suffer from flash aftermath.", { CB_ALL, CB_IC }, nil, guy ); end
if ( SERVER ) then
        ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  +50, -1000, 1000 ) );

end end