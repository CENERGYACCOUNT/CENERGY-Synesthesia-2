-- Crushed Arm Oddity
ODDITY.ID               = "injuryheavy1";
ODDITY.Name             = "Injury: Collapsed Lung";
ODDITY.Description      = "Lose all Energy and Ultimate Points. If you go down one more time, you will die.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My lungs had been injured. I hear the death bells.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetEnergy( math.Clamp( ply:ExtraEnergy() -100, -1000, 1000 ) );
    ply:SetExtraEnergy( math.Clamp( ply:ExtraEnergy() -100, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatExtraEnergy", tostring(ply:ExtraEnergy()), true ); -- special

end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "My lungs are better.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetExtraEnergy( math.Clamp( ply:ExtraEnergy() +100, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatExtraEnergy", tostring(ply:ExtraEnergy()), true ); -- special

end end
