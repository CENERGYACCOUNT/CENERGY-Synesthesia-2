AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthsmgbase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "L1LFR3ND - Apexforce"
SWEP.Itemize = true
SWEP.ItemDescription = "A peak of Apexi technology. So people would say sometime during the Apexi invasion of the Wastes. Years later, completely replaced. 5 Damage, 5% Crit Chance 50% Crit Damage, Weapon Type: Heat, 10 Penetration, 2 Shredding, 2 Dodge Shredding, Effective Range 1000, Accuracy 0.1, Suppression Chance 35%, Cripple Chance 10%, Cost 0.25A, Reload Cost 10S"
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 74
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/tnb/trpweapons/c_skynet_60watt.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_skynet_60watt.mdl"
SWEP.Primary.TracerName    = "GunshipTracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/weapon_burstcharge.wav"
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
SWEP.AimPos = Vector( -5.76, 1.55, 0 );
SWEP.AimAng = Vector( 0, 0, 0 );


-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 5
SWEP.Primary.CritChance        = 5
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 10
SWEP.Primary.DamageType = "heat" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 25
SWEP.Primary.Shredding = 2
SWEP.Primary.DodgeShredding = 2
SWEP.Primary.MaxRange = 1000
SWEP.Primary.Accuracy      = 0.05
SWEP.Primary.Delay         = 0.1 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.025 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 2.6
SWEP.Primary.ViewKick     = 1.7
SWEP.Primary.Recoil     = 2.5
SWEP.Scoped = false
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 200
SWEP.Primary.DefaultClip 	= 200
SWEP.SupressionChance = 35  -- Example: 20% chance for suppression
SWEP.CrippleChance = 10  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 0.25
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 10
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 2.41

