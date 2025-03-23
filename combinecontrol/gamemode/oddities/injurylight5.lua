-- Crushed Arm Oddity
ODDITY.ID               = "injurylight5";
ODDITY.Name             = "Injury: Crushed Arm";
ODDITY.Description      = "Lose 25% Muscle and 25% Agility due to a severely injured arm.";
ODDITY.Obvious          = true;
ODDITY.Operable         = false;

ODDITY.RemoveOnTurnEnd          = false;

ODDITY.OnGiven  = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your arm is crushed, making movement and Muscle difficult!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetMuscleTemporary( math.Clamp( ply:MuscleTemporary() -25, -1000, 1000 ) );
    ply:SetMuscle( math.Clamp( ply:Muscle() -25, -1000, 1000 ) );
    ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary() -25, -1000, 1000 ) );
    ply:SetAgility( math.Clamp( ply:Agility() -25, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatMuscle", tostring(ply:Muscle()), true ); -- special
    ply:UpdateCharacterField( "StatAgility", tostring(ply:Agility()), true ); -- special
end end

ODDITY.OnRemoved    = function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your arm has healed and regained its Muscle.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
    ply:SetMuscleTemporary( math.Clamp( ply:MuscleTemporary() +25, -1000, 1000 ) );
    ply:SetMuscle( math.Clamp( ply:Muscle() +25, -1000, 1000 ) );
    ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary() +25, -1000, 1000 ) );
    ply:SetAgility( math.Clamp( ply:Agility() +25, -1000, 1000 ) );
    ply:UpdateCharacterField( "StatMuscle", tostring(ply:Muscle()), true ); -- special
    ply:UpdateCharacterField( "StatAgility", tostring(ply:Agility()), true ); -- special
end end
