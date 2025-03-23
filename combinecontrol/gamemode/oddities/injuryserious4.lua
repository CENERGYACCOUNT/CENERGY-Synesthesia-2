-- Crushed Arm Oddity
ODDITY.ID               = "injuryheavy4";
ODDITY.Name             = "Injury: Coughing Blood";
ODDITY.Description      = "Take 10HP damage every turn all the way to 30HP.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I have internal bleeding and I am coughing blood up!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "I am no longer coughing up blood.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end
