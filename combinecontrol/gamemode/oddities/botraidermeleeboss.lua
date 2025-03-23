ODDITY.ID				= "npcraidermeleeboss";
ODDITY.Name 			= "Injury: Open Wound";
ODDITY.Description		= "Lose 25% Max Health";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;


ODDITY.RemoveOnTurnEnd          = false;



ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "NPC!", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then


ply:SetAttack(0)
ply:SetMovement(0)
ply:SetSpecial(0)
ply:SetMuscleTemporary(0)
ply:SetAgilityTemporary(0)
ply:SetReflexesTemporary(0)
ply:SetSlyTemporary(0)
ply:SetCoolTemporary(0)
ply:SetSmartsTemporary(0)
ply:SetPersistenceTemporary(0)
ply:SetAccuracyTemporary(0)
ply:SetBluntProficiencyTemporary(0)
ply:SetSlashProficiencyTemporary(0)
ply:SetMartialProficiencyTemporary(0)
ply:SetThreatTemporary(0)
ply:SetParryTemporary(0)
ply:SetDodgeTemporary(0)
ply:SetCriticalDamageTemporary(0)
ply:SetCriticalChanceTemporary(0)
ply:SetSneakTemporary(0)
ply:SetBluntHeadDefenseTemporary(0)
ply:SetBluntChestDefenseTemporary(0)
ply:SetBluntArmsDefenseTemporary(0)
ply:SetBluntLegsDefenseTemporary(0)
ply:SetSlashHeadDefenseTemporary(0)
ply:SetSlashChestDefenseTemporary(0)
ply:SetSlashArmsDefenseTemporary(0)
ply:SetSlashLegsDefenseTemporary(0)
ply:SetBulletHeadDefenseTemporary(0)
ply:SetBulletChestDefenseTemporary(0)
ply:SetBulletArmsDefenseTemporary(0)
ply:SetBulletLegsDefenseTemporary(0)
ply:SetHeatHeadDefenseTemporary(0)
ply:SetHeatChestDefenseTemporary(0)
ply:SetHeatArmsDefenseTemporary(0)
ply:SetHeatLegsDefenseTemporary(0)
ply:SetSneakTemporary(0)
ply:SetAgilityTemporary(0)
ply:SetReflexesTemporary(0)
ply:SetSlyTemporary(0)
ply:SetCoolTemporary(0)
ply:SetSmartsTemporary(0)
ply:SetPersistenceTemporary(0)
ply:SetAccuracyTemporary(0)
ply:SetResistance(0)


ply:RemoveOddity( ply:GetOddity( "goodguy" ) );
ply:RemoveOddity( ply:GetOddity( "badguy" ) );
ply:RemoveOddity( ply:GetOddity( "goodguy" ) );
ply:RemoveOddity( ply:GetOddity( "badguy" ) );
ply:SetBadGuy( true );

        -- Function to round up to the nearest multiple of 5
        local function RoundToFive(num)
            return math.ceil(num / 5) * 5
        end

        -- Assign random armor values (rounded)
        local bluntArmor = RoundToFive(math.random(75, 100))
        local slashArmor = RoundToFive(math.random(250, 300))
        local heatArmor = RoundToFive(math.random(150, 200))
        local bulletArmor = RoundToFive(math.random(250, 300))
        local dodge = RoundToFive(math.random(0, 0))

        -- Set defenses for all limbs
        ply:SetBluntHeadDefenseTemporary(bluntArmor)
        ply:SetBluntChestDefenseTemporary(bluntArmor)
        ply:SetBluntArmsDefenseTemporary(bluntArmor)
        ply:SetBluntLegsDefenseTemporary(bluntArmor)

        ply:SetSlashHeadDefenseTemporary(slashArmor)
        ply:SetSlashChestDefenseTemporary(slashArmor)
        ply:SetSlashArmsDefenseTemporary(slashArmor)
        ply:SetSlashLegsDefenseTemporary(slashArmor)

        ply:SetHeatHeadDefenseTemporary(heatArmor)
        ply:SetHeatChestDefenseTemporary(heatArmor)
        ply:SetHeatArmsDefenseTemporary(heatArmor)
        ply:SetHeatLegsDefenseTemporary(heatArmor)

        ply:SetBulletHeadDefenseTemporary(bulletArmor)
        ply:SetBulletChestDefenseTemporary(bulletArmor)
        ply:SetBulletArmsDefenseTemporary(bulletArmor)
        ply:SetBulletLegsDefenseTemporary(bulletArmor)

        -- Set dodge stat
        ply:SetAgility(dodge)
        ply:SetHealth(ply:Health() + 50)
        
local weapons = { "weapon_cc_meleesword2", "weapon_cc_wastelandcoscrapper", "weapon_cc_meleesword3", "weapon_cc_meleesword4" }  
local weaponChoice = weapons[math.random(#weapons)] -- Randomly pick one from the table  

ply:Give(weaponChoice)  
ply:SelectWeapon(weaponChoice)  
end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your wound had healed.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then




end end