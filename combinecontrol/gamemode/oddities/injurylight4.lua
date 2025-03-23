
ODDITY.ID               = "injurylight4";
ODDITY.Name             = "Injury: Concussion";
ODDITY.Description      = "Lose 2.5 Special and 25% Smarts due to head trauma.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your head is spinning from a concussion!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetExtraSpecial( math.Clamp( ply:ExtraSpecial() - 2.5, -1000, 1000 ) );
    ply:SetSmarts( math.Clamp( ply:Smarts() -25, 0, 100 ) );
    ply:SetSmarts( math.Clamp( ply:SmartsTemporary() -25, 0, 100 ) );
    ply:UpdateCharacterField( "StatExtraSpecial", tostring(ply:ExtraSpecial()), true ); -- special
    ply:UpdateCharacterField( "StatSmarts", tostring(ply:Smarts()), true ); -- special
end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your head has cleared up.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetExtraSpecial( math.Clamp( ply:ExtraSpecial() + 2.5, -1000, 1000 ) );
    ply:SetSmarts( math.Clamp( ply:Smarts() +25, 0, 100 ) );
    ply:SetSmarts( math.Clamp( ply:TemporarySmarts() +25, 0, 100 ) );
    ply:UpdateCharacterField( "StatExtraSpecial", tostring(ply:ExtraSpecial()), true ); -- special
    ply:UpdateCharacterField( "StatSmarts", tostring(ply:Smarts()), true ); -- special
end end