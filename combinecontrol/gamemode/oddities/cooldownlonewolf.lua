ODDITY.ID				= "cooldownlonewolf"
ODDITY.Name 			= "Cooldown: Lonewolf"
ODDITY.Description		= ""
ODDITY.Obvious			= true
ODDITY.Operable			= false
ODDITY.RemoveOnTurnEnd			= true;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(ply:GetOddity(oddityID))
    end
end
