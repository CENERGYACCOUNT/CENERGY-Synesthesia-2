AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_synthriflebase"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "WastelandCO: Beaster"
SWEP.Itemize = true
SWEP.ItemDescription = "A giantic anti armour rifle, used to slay largerly armoured steel beasts. Or to shred Apexi Armor."
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
SWEP.ViewModel       = "models/tnb/weapons/c_ptrs41.mdl"
SWEP.WorldModel   = "models/tnb/weapons/w_ptrs41.mdl"
SWEP.Primary.TracerName    = "Tracer";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "tekka/weapons/weapon_ied_close.wav"
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
SWEP.AimPos = Vector( -6.21, 2.7, 0 );
SWEP.AimAng = Vector( 0, 0, 0 );




-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 50
SWEP.Primary.CritChance        = 25
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 522
SWEP.Primary.DamageType = "heat" -- Options: "bullet", "slash", "blunt"
SWEP.Primary.BulletSize = 10 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number.
SWEP.Primary.Penetration = 75
SWEP.Primary.Shredding = 75
SWEP.Primary.DodgeShredding = 1
SWEP.Primary.MaxRange = 4000
SWEP.Primary.Accuracy      = 0.01
SWEP.Primary.Delay         = 0.25 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 0.5 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     = 5.3
SWEP.Primary.ViewKick     = 5.9
SWEP.Primary.Recoil     = 5.25
SWEP.Scoped = false
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= 1
SWEP.Primary.DefaultClip 	= 1
SWEP.SupressionChance = 0 -- Example: 20% chance for suppression
SWEP.CrippleChance = 100  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCostS   = 0
SWEP.Primary.AttackCostA   = 10
SWEP.Primary.AttackCostM   = 0
SWEP.Primary.ReloadCostS   = 5
SWEP.Primary.ReloadCostA   = 0
SWEP.Primary.ReloadCostM   = 0

local recoil = 8.41


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