ODDITY.ID				= "statusadaptagility";
ODDITY.Name 			= "Status: Adapt - Offense";
ODDITY.Description		= "Gain 25% Agility for one turn.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You are now in offensive mode!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary()  +25, -1000, 1000 ) );
	ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  +16.5, -1000, 1000 ) );
	ply:SetMovement( math.Clamp( ply:Movement()  + 1, -1000, 1000 ) );
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255), "CombineControl.ChatNormal", "You are no longer in offensive mode.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary()  -25, -1000, 1000 ) );
ply:SetDodgeTemporary( math.Clamp( ply:DodgeTemporary()  -16.5, -1000, 1000 ) );

end end