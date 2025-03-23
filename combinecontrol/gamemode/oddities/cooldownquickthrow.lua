ODDITY.ID				= "cooldownquickthrow"
ODDITY.Name 			= "Cooldown: Quickthrow"
ODDITY.Description		= ""
ODDITY.Obvious			= true
ODDITY.Operable			= false
ODDITY.RemoveOnTurnEnd			= true;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(ply:GetOddity(oddityID))
    end
end

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You used your free throw!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

 end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You can use quickthrow again!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end