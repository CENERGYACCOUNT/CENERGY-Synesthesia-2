ODDITY.ID               = "abilitystandtall"
ODDITY.Name             = "Stand Tall"
ODDITY.Description      = "Gain 25 BonusHealth and 25 Threat when near an enemy."
ODDITY.Obvious          = true
ODDITY.Operable         = false
ODDITY.RemoveOnTurnEnd          = true;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(self) -- Use 'self' instead of fetching the oddity again
    end
end

ODDITY.OnGiven = function(self, ply)
    if CLIENT then
        GAMEMODE:AddChat(Color(200, 200, 200, 255), "CombineControl.ChatNormal", "You gain the Stand Tall buff!", {CB_ALL, CB_IC}, nil, guy)
    end

    if SERVER then
        -- Apply the health and threat bonuses
        ply:SetBonusHealth(ply:BonusHealth() + 25)
        ply:UpdateCharacterField( "StatBonusHealth", tostring( ply:BonusHealth() ), true ); -- special
        ply:SetThreat(ply:Threat() + 25)
        ply:UpdateCharacterField( "StatThreat", tostring( ply:Threat() ), true ); -- special
        ply:EmitSound("npc/roller/blade_in.wav")
    end
end

ODDITY.OnRemoved = function(self, ply)
    if SERVER then
        -- Remove the health and threat bonuses
        ply:SetBonusHealth(ply:BonusHealth() - 25)
        ply:UpdateCharacterField( "StatBonusHealth", tostring( ply:BonusHealth() ), true ); -- special
        ply:SetThreat(ply:Threat() - 25)
        ply:UpdateCharacterField( "StatThreat", tostring( ply:Threat() ), true ); -- special
    end
end
