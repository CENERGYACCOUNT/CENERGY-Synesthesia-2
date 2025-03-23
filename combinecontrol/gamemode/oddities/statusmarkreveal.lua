ODDITY.ID				= "statusmarkreveal";
ODDITY.Name 			= "Status: Mark - Revealed";
ODDITY.Description		= "Take double shredding damage.";
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
GAMEMODE:AddChat( Color(200, 200, 200, 255 ), "CombineControl.ChatNormal", "Enemy officer is revealing you!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  +25, -1000, 1000 ) );
	   ply:SetRevealed( true );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color(200, 200, 200, 255), "CombineControl.ChatNormal", "You are no longer revealed.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  -25, -1000, 1000 ) );
    ply:SetRevealed( false );
end end