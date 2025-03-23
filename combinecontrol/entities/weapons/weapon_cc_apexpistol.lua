AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthpistolbase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "MEX45 - Apex"
SWEP.Itemize = true
SWEP.ItemDescription = "An Apexi classic. Used for decaes, will be used in decades. 10 Damage, 10% Crit Chabcem 50% Crit Damage, Weapon Type: Heat, 35 Penetration, 5 Shredding, Effective Range 1500, Accuracy 0.35, Suppression Chance 10%, Cripple Chance 25%, Cost 5A, Reload Cost 5S"
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 70
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/tnb/trpweapons/c_skynet_20watt.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_skynet_20watt.mdl"
SWEP.Primary.TracerName    = "AR2Tracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/plasma_rifle3.wav"
SWEP.Primary.ReloadSound   = "weapons/7thpistol/si2reload.wav"
-- Anims
SWEP.HoldType = "revolver"
SWEP.HoldTypeHolster = "passive"
SWEP.Holsterable = true
SWEP.CanSprint = false;
SWEP.ViewModelFOV = 55
SWEP.SwayScale    = 1;
SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );
SWEP.AimPos = Vector( -4.56, 0.03, -3 );
SWEP.AimAng = Vector( 0, 0, 0 );

-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 17.5
SWEP.Primary.CritChance        = 10
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 10
SWEP.Primary.DamageType = "heat" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 45
SWEP.Primary.Shredding = 5
SWEP.Primary.DodgeShredding = 0
SWEP.Primary.MaxRange = 1500
SWEP.Primary.Accuracy      = 0.025
SWEP.Primary.Delay         = 0.25 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.3 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 2.6
SWEP.Primary.ViewKick     = 1.5
SWEP.Primary.Recoil     = 2.5
SWEP.Scoped = false
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.DefaultClip 	= 8
SWEP.SupressionChance = 10 -- Example: 20% chance for suppression
SWEP.CrippleChance = 25  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 2.5
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 5
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 2.41

