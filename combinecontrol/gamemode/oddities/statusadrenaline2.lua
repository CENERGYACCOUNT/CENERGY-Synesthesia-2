ODDITY.ID				= "statusadrenaline2";
ODDITY.Name 			= "Status: Over Juiced";
ODDITY.Description		= "Gain 35 Health, 10 Agility and 5 Resistance, lose 25 Accuracy.";
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
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You were injected with adrenaline and are now Over Juiced!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
	ply:SetAgilityTemporary( math.Clamp( ply:AgilityTemporary()  +10, -1000, 1000 ) );
    ply:SetAccuracyTemporary( math.Clamp( ply:AccuracyTemporary()  -10, -1000, 1000 ) );
    ply:SetResistance( math.Clamp( ply:Resistance()  +5, -1000, 1000 ) );
      local extraHealth = ply.BonusHealth and ply:BonusHealth() or 0
        local regenBonus = ply.BonusHealthRegeneration and ply:BonusHealthRegeneration() or 0

        -- Calculate max health
                local MuscleTemporary = ply:MuscleTemporary() or 0
        local maxHP = 100 + extraHealth + math.floor(MuscleTemporary / 5) * 5
    ply:SetHealth(math.min(ply:Health() + 35, maxHP))
 end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then end

if ( SERVER ) then
end end