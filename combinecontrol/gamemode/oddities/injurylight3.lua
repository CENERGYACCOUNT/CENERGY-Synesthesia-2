ODDITY.ID               = "injurylight3";
ODDITY.Name             = "Injury: Damaged Eye";
ODDITY.Description      = "Lose 25% Accuracy due to impaired vision.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your vision is impaired from an eye injury!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary() -25, -1000, 1000  ) );
    ply:SetAccuracy( math.Clamp( ply:Accuracy() -25, -1000, 1000  ) );
    ply:UpdateCharacterField( "StatAccuracy", tostring(ply:Accuracy()), true ); -- special
end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your vision has recovered.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary() +25, -1000, 1000  ) );
    ply:SetAccuracy( math.Clamp( ply:Accuracy() +25,-1000, 1000  ) );
    ply:UpdateCharacterField( "StatAccuracy", tostring(ply:Accuracy()), true ); -- special
end end
