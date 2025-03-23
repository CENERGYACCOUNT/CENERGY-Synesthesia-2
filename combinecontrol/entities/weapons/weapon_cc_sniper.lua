AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_akimbo"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "Test Sniper"
SWEP.Itemize = true
SWEP.ItemDescription = "A station manufactured and standard issued pistol. Used by the station personnel."
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 60
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/tnb/trpweapons/c_skynet_80watt.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_skynet_20watt.mdl"
SWEP.Primary.TracerName    = "AR2Tracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/plasma_rifle2.wav"
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
SWEP.AimPos = Vector( -5.95, 0.21, -10 );
SWEP.AimAng = Vector( 0, 0, 0 );



-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 50
SWEP.Primary.MaxRange        = 50000
SWEP.Primary.Force         = 50
SWEP.Primary.DamageType = "bullet" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 15
SWEP.Primary.Shredding = 50
SWEP.Primary.Accuracy      = 0.0001
SWEP.Primary.Delay         = 1 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 50 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 5
SWEP.Primary.ViewKick     = 5
SWEP.Primary.Recoil     = 5
SWEP.Scoped = true
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 200
SWEP.Primary.DefaultClip 	= 20000
SWEP.SupressionChance = 50  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCost   = 2.5
SWEP.Primary.ReloadCost   = 5


local recoil = 2.41

