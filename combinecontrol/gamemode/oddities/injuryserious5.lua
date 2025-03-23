-- Crushed Arm Oddity
ODDITY.ID               = "injuryheavy5";
ODDITY.Name             = "Injury: Traumatized";
ODDITY.Description      = "Every turn, there is a 50% chance to become stunned.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I've seen too much! I am traumatized!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
   
end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The trauma is gone.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end
