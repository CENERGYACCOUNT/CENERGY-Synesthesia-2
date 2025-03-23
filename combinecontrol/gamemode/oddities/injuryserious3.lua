-- Crushed Arm Oddity
ODDITY.ID               = "injuryheavy3";
ODDITY.Name             = "Injury: Damaged Vocal Cords";
ODDITY.Description      = "Lose ability to communicate. You can only whisper.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were shot in the neck, you cannot speak.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your vocal cords had healed.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then

end end
