AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "Test Sniper"
SWEP.Slot 			= 2
SWEP.SlotPos 		= 73
SWEP.CSMuzzleFlashes	= true

SWEP.UseHands		= true
SWEP.ViewModel 		= "models/tnb/weapons/c_awm.mdl"
SWEP.WorldModel 	= "models/tnb/weapons/w_awm.mdl"

SWEP.Firearm				= true
SWEP.ViewModelFOV = 60
SWEP.SwayScale    = 3;
SWEP.Primary.ClipSize 		= 2000
SWEP.Primary.DefaultClip 	= 20000
SWEP.Primary.Ammo			= "cc_smg"
SWEP.Primary.InfiniteAmmo	= true
SWEP.Primary.Automatic		= true
SWEP.Primary.Sound			= "weapons/weapon_usp.wav"
SWEP.Primary.Damage			= 0
SWEP.Primary.Force			= 20
SWEP.Primary.Accuracy		= 0.1
SWEP.Primary.Delay			= 0.1
SWEP.Primary.RecoilAdd		= 5.6
SWEP.Primary.ReloadSound	= "vj_weapons/glock_17/reload.wav"
SWEP.Primary.ViewKick     = 5.5
SWEP.Primary.Recoil     = 5.5

SWEP.scoped                 = true;
SWEP.CanSprint = false;
SWEP.NoLaser = true;

SWEP.HoldType = "revolver"
SWEP.HoldTypeHolster = "passive"

SWEP.Holsterable = true
SWEP.Attachment = 0

SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );

SWEP.AimPos = Vector( -2.8, 0.96, -3.99 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.Itemize = true
SWEP.ItemDescription = "A station manufactured and standard issued pistol. Used by the station personnel."
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );


function SWEP:PrimaryUnholstered()
   
   if( self:CanPrimaryAttack() ) then
      
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay );
         GAMEMODE:FreezePlayer( self.Owner, 1.3 );
   
      self.CanReload = true;
      
      self.Weapon:EmitSound( self.Primary.Sound );
      
      self:ShootEffects();
      
      local vecShoot = self.Owner:GetVelocity() * 0.5 + self.Owner:GetAimVector() * 10000;
      
      local e = EffectData();
         e:SetOrigin( self.Owner:GetShootPos() );
         e:SetStart( vecShoot );
      util.Effect( "cc_e_flare", e );
      
      local trace = { };
      trace.start = self.Owner:GetShootPos();
      trace.endpos = trace.start + self.Owner:GetAimVector() * 4000000000;
      trace.filter = self.Owner;
      
      local tr = util.TraceLine( trace );
      
              if( tr.Entity:IsPlayer() ) then
         
            tr.Entity:TakeDamage(  55  ); 
            
            
         end
         
      end
      
      self:TakePrimaryAmmo( 1 );
      
      self:Idle();
      
  
   
end
