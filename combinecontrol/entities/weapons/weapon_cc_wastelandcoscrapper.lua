AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthshotgunbase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "WastelandCO - Scrapper"
SWEP.Itemize = true
SWEP.ItemDescription = "This shit thing looks very homemade."
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
SWEP.ViewModel       = "models/tnb/trpweapons/c_tc_70watt.mdl"
SWEP.WorldModel   = "models/tnb/trpweapons/w_tc_70watt.mdl"
SWEP.Primary.TracerName    = "Tracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 3
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/weapon_canon.wav"
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
SWEP.Primary.Damage        = 1
SWEP.Primary.CritChance        = 5
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 5
SWEP.Primary.NumBullets		= 10;
SWEP.Primary.DamageType = "bullet" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 10
SWEP.Primary.Shredding = 15
SWEP.Primary.DodgeShredding = 0
SWEP.Primary.MaxRange = 1000
SWEP.Primary.Accuracy      = 0.1
SWEP.Primary.Delay         = 0.5 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.5 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 5.3
SWEP.Primary.ViewKick     = 5.9
SWEP.Primary.Recoil     = 5.25
SWEP.Scoped = false
SWEP.NoLaser = false;
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.DefaultClip 	= 20
SWEP.SupressionChance = 25  -- Example: 20% chance for suppression
SWEP.CrippleChance = 75  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 2.5
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 5
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 4.41


if( CLIENT ) then

   SWEP.LaserMat = Material( "" );
   

   
end


function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
     
      
   end
   
end