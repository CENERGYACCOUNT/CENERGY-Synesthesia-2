ODDITY.ID               = "abilitysuperiorrace"
ODDITY.Name             = "Superior Race"
ODDITY.Description      = "Gain 15 Reflexes, 15 Agility, and 15 Muscle."
ODDITY.Obvious          = true
ODDITY.Operable         = false
ODDITY.RemoveOnTurnEnd          = false;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(self) -- Use 'self' instead of fetching the oddity again
    end
end

ODDITY.OnGiven = function(self, ply)
    if CLIENT then
        GAMEMODE:AddChat(Color(200, 200, 200, 255), "CombineControl.ChatNormal", "You gain the Superior Race buff!", {CB_ALL, CB_IC}, nil, guy)
    end

    if SERVER then
        -- Apply the bonuses
        ply:SetReflexes(ply:Reflexes() + 15)
        ply:UpdateCharacterField( "StatReflexes", tostring( ply:Reflexes() ), true ); 
        ply:SetAgility(ply:Agility() + 15)
        ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ), true );
        ply:SetMuscle(ply:Muscle() + 15)
        ply:UpdateCharacterField( "StatMuscle", tostring( ply:Muscle() ), true );
        ply:EmitSound("npc/roller/blade_in.wav")
    end
end

ODDITY.OnRemoved = function(self, ply)
    if SERVER then
        -- Remove the bonuses
        ply:SetReflexes(ply:Reflexes() - 15)
        ply:SetAgility(ply:Agility() - 15)
        ply:SetMuscle(ply:Muscle() - 15)
    ply:UpdateCharacterField( "StatReflexes", tostring( ply:Reflexes() ), true ); 
    ply:UpdateCharacterField( "StatAgility", tostring( ply:Agility() ), true );
    ply:UpdateCharacterField( "StatMuscle", tostring( ply:Muscle() ), true );
    end
end
