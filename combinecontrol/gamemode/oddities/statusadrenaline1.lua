ODDITY.ID				= "statusadrenaline1";
ODDITY.Name 			= "Status: Juiced Up";
ODDITY.Description		= "Gain 50 Health, 10 Agility and 10 Resistance.";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;


ODDITY.RemoveOnTurnEnd          = false;

ODDITY.Think = function(self, ply)
    if SERVER and GAMEMODE:Combat() == 0 then
        ply:RemoveOddity(ply:GetOddity(oddityID))
    end
end

ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were injected with adrenaline and are now Juiced Up!!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary()  +25, -1000, 1000 ) );
    ply:SetResistance( math.Clamp( ply:Resistance()  +10, -1000, 1000 ) );
      local extraHealth = ply.BonusHealth and ply:BonusHealth() or 0
        local regenBonus = ply.BonusHealthRegeneration and ply:BonusHealthRegeneration() or 0

        -- Calculate max health
                local MuscleTemporary = ply:MuscleTemporary() or 0
        local maxHP = 100 + extraHealth + math.floor(MuscleTemporary / 5) * 5
    ply:SetHealth(math.min(ply:Health() + 50, maxHP))
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then end

if ( SERVER ) then
end end