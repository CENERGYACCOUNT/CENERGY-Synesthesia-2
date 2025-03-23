ODDITY.ID				= "statusmarktarget";
ODDITY.Name 			= "Status: Mark - Targeted";
ODDITY.Description		= "Ťake 50% Extra Critical Hit Chance.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Enemy officer is targeting you!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
		   ply:SetTargeted( true );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer targeted.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
		   ply:SetTargeted( false );
end end