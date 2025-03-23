AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthshotgunbase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "R1PP3R - Apexforce"
SWEP.Itemize = true
SWEP.ItemDescription = "A fine plasma shotgun by the new Corporate Council of the Apexforce. Will serve for a long time, before becoming outdated, and that by the Plasma Apex Hand Cannons. 10 Damage, 5 Shells, 5% Crit Chabcem 50% Crit Damage, Weapon Type: Heat, 10 Penetration, 5 Shredding, Effective Range 1000 Accuracy 0.1 Suppression Chance 10%, Cripple Chance 50%, Cost 5A, Reload Cost 10S"
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 75
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/tnb/trpweapons/c_skynet_shotgun.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_skynet_shotgun.mdl"
SWEP.Primary.TracerName    = "AR2Tracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/plasma_boss.wav"
SWEP.Primary.ReloadSound   = "weapons/7thpistol/si2reload.wav"
-- Anims
SWEP.HoldType = "shotgun"
SWEP.HoldTypeHolster = "passive"
SWEP.Holsterable = true
SWEP.CanSprint = false;
SWEP.ViewModelFOV = 55
SWEP.SwayScale    = 1;
SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );
SWEP.AimPos = Vector( -1.98, 0.84, 0 );
SWEP.AimAng = Vector( 0, 0, 0 );




-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 10
SWEP.Primary.CritChance        = 5
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 5555555555
SWEP.Primary.NumBullets		= 5;
SWEP.Primary.DamageType = "heat" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 10
SWEP.Primary.Shredding = 5
SWEP.Primary.DodgeShredding = 0
SWEP.Primary.MaxRange = 1000
SWEP.Primary.Accuracy      = 0.1
SWEP.Primary.Delay         = 0.5 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.5 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 1.3
SWEP.Primary.ViewKick     = 0.9
SWEP.Primary.Recoil     = 1.25
SWEP.Scoped = false
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.DefaultClip 	= 20
SWEP.SupressionChance = 10  -- Example: 20% chance for suppression
SWEP.CrippleChance = 50  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 5
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 5
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 2.41

