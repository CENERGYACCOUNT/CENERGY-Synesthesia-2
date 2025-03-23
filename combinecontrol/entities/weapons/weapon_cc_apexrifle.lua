AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthriflebase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "3ST-4ND4RD 04"
SWEP.Itemize = true
SWEP.ItemDescription = "A standard issue Apexforce Assault Rifle, during the Crystal Wars period. Usually carried by ground officers of The Hand. Long time before printer mags were fully integrated. 10 Damage, 10% Crit Chabcem 50% Crit Damage, Weapon Type: Heat, 30 Penetration, 10 Shredding, 1 Dodge Shredding, Effective Range 2000, Accuracy 0.3 Suppression Chance 20%, Cripple Chance 20%, Cost 2A, Reload Cost 5S"
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 71
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/tnb/trpweapons/c_skynet_55watt.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_skynet_45watt.mdl"
SWEP.Primary.TracerName    = "GunshipTracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/plasma_rifle1.wav"
SWEP.Primary.ReloadSound   = "weapons/7thpistol/si2reload.wav"
-- Anims
SWEP.HoldType = "ar2"
SWEP.HoldTypeHolster = "passive"
SWEP.Holsterable = true
SWEP.CanSprint = false;
SWEP.ViewModelFOV = 55
SWEP.SwayScale    = 1;
SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );
SWEP.AimPos = Vector( -5.89, 1.58, -10 );
SWEP.AimAng = Vector( 0, 0, 0 );



-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 15
SWEP.Primary.CritChance        = 10
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 10
SWEP.Primary.DamageType = "heat" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 30
SWEP.Primary.Shredding = 10
SWEP.Primary.DodgeShredding = 1
SWEP.Primary.MaxRange = 2000
SWEP.Primary.Accuracy      = 0.025
SWEP.Primary.Delay         = 0.25 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.1 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 1.3
SWEP.Primary.ViewKick     = 0.9
SWEP.Primary.Recoil     = 1.25
SWEP.Scoped = true
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.DefaultClip 	= 20
SWEP.SupressionChance = 20 -- Example: 20% chance for suppression
SWEP.CrippleChance = 20  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 2
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 5
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 2.41

