ODDITY.ID				= "statusstunned";
ODDITY.Name 			= "Status: Stunned";
ODDITY.Description		= "Lose your next turn.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You got stunned!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

	    ply:SetStunned( true );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You lose your turn due to being stunned.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetStunned( false );
ply:SetAttack(0)
ply:SetMovement(0)
ply:SetSpecial(0)
end end