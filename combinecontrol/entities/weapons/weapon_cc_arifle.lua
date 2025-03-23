AddCSLuaFile()

SWEP.Base			= "weapon_cc_base"

SWEP.PrintName 		= "H4 - Classic"
SWEP.Slot 			= 2
SWEP.SlotPos 		= 71
SWEP.CSMuzzleFlashes	= true

SWEP.UseHands		= true
SWEP.ViewModel 		= "models/tekka/weapons/c_hk_standard.mdl"
SWEP.WorldModel 	= "models/tekka/weapons/w_hk_standard.mdl"

SWEP.Firearm				= true
SWEP.ViewModelFOV = 60
SWEP.SwayScale    = 3;
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Ammo			= "cc_smg"
SWEP.Primary.InfiniteAmmo	= true
SWEP.Primary.Automatic		= true
SWEP.Primary.Sound			= "vj_weapons/m16a1/m16a1_single.wav"
SWEP.Primary.Damage			= 5
SWEP.Primary.Force			= 20
SWEP.Primary.Accuracy		= 0.1
SWEP.Primary.Delay			= 0.20
SWEP.Primary.RecoilAdd		= 0.6
SWEP.Primary.ReloadSound	= ""
SWEP.Primary.ViewKick     = 2.5
SWEP.Primary.Recoil     = 2.5


SWEP.CanSprint = true;
SWEP.NoLaser = false;

SWEP.HoldType = "ar2"
SWEP.HoldTypeHolster = "passive"

SWEP.Holsterable = true
SWEP.Attachment = 1

SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );

SWEP.AimPos = Vector( -5.15, 0.85, -10 );
SWEP.AimAng = Vector( 0.25, -0.17, -0.75 );

SWEP.Itemize = true
SWEP.ItemDescription = "A station manufactured and standard issued assault rifle. Used by the security personnel."
SWEP.ItemWeight = 4
SWEP.ItemFOV = 20;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );

SWEP.ItemUsable       = true;
SWEP.ItemUseText      = "Equip";

ITEM.OnPlayerUse  = function( self, ply )

      if (ply:HasOddity( "wearingheadgear" ) ) then

      if( CLIENT ) then
         
         GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You are already wearing something on your head.", { CB_ALL, CB_IC } );
         
      end
      
      return true;
      
   end

   if( CLIENT ) then
      
         GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You put the item on your head.", { CB_ALL, CB_IC } );

   else
      
   
               ply:GiveOddity( "wearingheadgear" );
            ply:EmitSound( "weapons/tfa/melee1.wav" );
      ply:GiveItem( "clothesheadtophate" );
   

      
   end
   
end


SWEP.InfoText = [[NAME - X
REQUIRED AMMO - X
]];



if( CLIENT ) then

   SWEP.LaserMat = Material( "effects/bluelaser1" );
   
   local tab = { };
   tab[ "$basetexture" ] = "sprites/light_glow03";
   tab[ "$additive" ] = 1;
   tab[ "$translucent" ] = 1;
   tab[ "$vertexcolor" ] = 1;
   SWEP.SpriteMat = CreateMaterial( "csniper_sprite", "UnlitGeneric", tab );
   
end

function SWEP:PreDrawViewModel( vm, ply, wep )
   
   if( !self.Owner:Holstered() and self.IronMode < IRON_AIM and self.IronMode >= IRON_IDLE and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      if( self.Owner:InVehicle() ) then return end
      if( self.Owner:GetNoDraw() ) then return end
      if( hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
      
      render.SetMaterial( self.LaserMat );
      render.DrawBeam( vm:GetAttachment( 1 ).Pos, self.Owner:GetEyeTrace().HitPos, 1, 0, 1, Color( 0, 100, 255, 255 ) );
      render.SetMaterial( self.SpriteMat );
      render.DrawSprite( self.Owner:GetEyeTrace().HitPos, 4, 4, Color( 50, 190, 255, 255 ) );
      
   end
   
   if( self.Scoped ) then
      
      if( self.IronMode == IRON_AIM ) then
         
         vm:SetMaterial( "engine/occlusionproxy" );
         
      else
         
         vm:SetMaterial( "" );
         
      end
      
   else
      
      vm:SetMaterial( "" );
      
   end
   
end

function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      render.SetMaterial( self.LaserMat );
      render.DrawBeam( self:GetAttachment( 1 ).Pos, self.Owner:GetEyeTrace().HitPos, 1, 0, 1, Color( 0, 100, 255, 255 ) );
      render.SetMaterial( self.SpriteMat );
      render.DrawSprite( self.Owner:GetEyeTrace().HitPos, 4, 4, Color( 50, 190, 255, 255 ) );
      
   end
   
end

local recoil = 2



function SWEP:Reload()

if( self.Owner:Holstered() ) then return end
if( !self.Firearm ) then return end

if( !self.NextReload ) then self.NextReload = CurTime() end
if( CurTime() < self.NextReload ) then return end


if( self:Clip1() > 0  ) then
self.Owner:EmitSound( "vj_weapons/dryfire_pistol.wav" );
   self.Owner:ViewPunch( Angle( -2, 0, 0 ) );

   self.NextReload = CurTime() + 0.2;
self:SetNextPrimaryFire( CurTime() + 0.2 );
self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

-- Above is base, do not change (sounds exceptions)


--- Underneath, is unloading mags

if( self:Clip1() == 30  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag30" ); end end


if( self:Clip1() == 29  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag29" ); end end

if( self:Clip1() == 28  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag28" ); end end

if( self:Clip1() == 27  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag27" ); end end

if( self:Clip1() == 26  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag26" ); end end

if( self:Clip1() == 25  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag25" ); end end

if( self:Clip1() == 24  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag24" ); end end

if( self:Clip1() == 23  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag23" ); end end

if( self:Clip1() == 22  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag22" ); end end

if( self:Clip1() == 21  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag21" ); end end

if( self:Clip1() == 20  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag20" ); end end

if( self:Clip1() == 19  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag19" ); end end

if( self:Clip1() == 18  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag18" ); end end

if( self:Clip1() == 17  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag17" ); end end


if( self:Clip1() == 16  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag16" ); end end

if( self:Clip1() == 15  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag15" ); end end

if( self:Clip1() == 14  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag14" ); end end

if( self:Clip1() == 13  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag13" ); end end

if( self:Clip1() == 12  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag12" ); end end

if( self:Clip1() == 11  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag11" ); end end

if( self:Clip1() == 10  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag10" ); end end

if( self:Clip1() == 9  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag9" ); end end

if( self:Clip1() == 8  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag8" ); end end

if( self:Clip1() == 7  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag7" ); end end

if( self:Clip1() == 6  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag6" ); end end

if( self:Clip1() == 5  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag5" ); end end

if( self:Clip1() == 4  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag4" ); end end

if( self:Clip1() == 3  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag3" ); end end

if( self:Clip1() == 2  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag2" ); end end

if( self:Clip1() == 1  ) then
if( SERVER ) then    
self.Owner:GiveItem( "smgmag1" ); end end

self:SetClip1( 0 );  

else
-- If mag cannot be unloaded, it starts RELOADING, and checking for mags in inventory. If you have none nothing happens

if( self.Owner:HasItem( "smgmag30" ) ) then
self:SetClip1( 30 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag30" ) ); end else 

if( self.Owner:HasItem( "smgmag29" ) ) then
self:SetClip1( 29 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag29" ) ); end else 

if( self.Owner:HasItem( "smgmag28" ) ) then
self:SetClip1( 28 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag28" ) ); end else 

if( self.Owner:HasItem( "smgmag27" ) ) then
self:SetClip1( 27 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag27" ) ); end else 

if( self.Owner:HasItem( "smgmag26" ) ) then
self:SetClip1( 26 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag26" ) ); end else 

if( self.Owner:HasItem( "smgmag25" ) ) then
self:SetClip1( 25 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag25" ) ); end else 

if( self.Owner:HasItem( "smgmag24" ) ) then
self:SetClip1( 24 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag24" ) ); end else 

if( self.Owner:HasItem( "smgmag23" ) ) then
self:SetClip1( 23 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag23" ) ); end else 

if( self.Owner:HasItem( "smgmag22" ) ) then
self:SetClip1( 22 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag22" ) ); end else 

if( self.Owner:HasItem( "smgmag21" ) ) then
self:SetClip1( 21 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag21" ) ); end else 

if( self.Owner:HasItem( "smgmag20" ) ) then
self:SetClip1( 20 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag20" ) ); end else 

if( self.Owner:HasItem( "smgmag19" ) ) then
self:SetClip1( 19 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag19" ) ); end else 

if( self.Owner:HasItem( "smgmag18" ) ) then
self:SetClip1( 18 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag18" ) ); end else 

if( self.Owner:HasItem( "smgmag17" ) ) then
self:SetClip1( 17 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag17" ) ); end else 

if( self.Owner:HasItem( "smgmag16" ) ) then
self:SetClip1( 16 );
self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag16" ) ); end else 

if( self.Owner:HasItem( "smgmag15" ) ) then
self:SetClip1( 15 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag15" ) ); end else 

if( self.Owner:HasItem( "smgmag14" ) ) then
self:SetClip1( 14 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag14" ) ); end else 

if( self.Owner:HasItem( "smgmag13" ) ) then
self:SetClip1( 13 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag13" ) ); end else 

if( self.Owner:HasItem( "smgmag12" ) ) then
self:SetClip1( 12 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag12" ) ); end else 
if( self.Owner:HasItem( "smgmag11" ) ) then
self:SetClip1( 11 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag11" ) ); end else 


if( self.Owner:HasItem( "smgmag10" ) ) then
self:SetClip1( 10 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag10" ) ); end else 

if( self.Owner:HasItem( "smgmag8" ) ) then
self:SetClip1( 8 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );

if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag8" ) ); end else 

if( self.Owner:HasItem( "smgmag9" ) ) then
self:SetClip1( 9 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag9" ) ); end else 


if( self.Owner:HasItem( "smgmag7" ) ) then
self:SetClip1( 7 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag7" ) ); end else 


if( self.Owner:HasItem( "smgmag6" ) ) then
self:SetClip1( 6 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag6" ) ); end else 


if( self.Owner:HasItem( "smgmag5" ) ) then
self:SetClip1( 5 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag5" ) ); end else 


if( self.Owner:HasItem( "smgmag4" ) ) then
self:SetClip1( 4 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag4" ) ); end else 


if( self.Owner:HasItem( "smgmag3" ) ) then
self:SetClip1( 3 );  self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag3" ) ); end else 

if( self.Owner:HasItem( "smgmag2" ) ) then
self:SetClip1( 2 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag2" ) ); end else 

if( self.Owner:HasItem( "smgmag1" ) ) then
self:SetClip1( 1 );    self:SendWeaponAnimShared( ACT_VM_RELOAD ); self.Owner:SetAnimation( PLAYER_RELOAD ); self.NextReload = CurTime() + 2.2; self:SetNextPrimaryFire( CurTime() + 2.2 ); self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() );
if( SERVER ) then
self.Owner:RemoveItem( self.Owner:GetInventoryItem( "smgmag1" ) ); end else 


 end end end end
 end end   end end end end end end end end end end end end end end end end end end end end end end end end end end 



function SWEP:PrimaryUnholstered()
   
   if( self.Firearm ) then
      
      if( self:CanPrimaryAttack() ) then
         
         self:SetNextPrimaryFire( CurTime() + self.Primary.Delay );
         self:ShootEffects();
-- This checks for the last fired bullet, if last bullet is fired it gives you empty magazine
if( self:Clip1() == 1  ) then
if( SERVER ) then self.Owner:GiveItem( "smgmag0" ); 
self.Owner:EmitSound( "vj_weapons/dryfire_pistol.wav" );
   self.Owner:ViewPunch( Angle( -2, 0, 0 ) );
 end end 
         
         self:TakePrimaryAmmo( 1 );
         self.NextReload = CurTime() + 0.2;

         self:Idle();
         



         --[[if( self.Attachment ) then
            
            local b = self.Attachment
            
            self.Owner:GetViewModel():SetBodygroup(1, b)
            self:SetBodygroup(1, b)
            
         end--]]
         
         if( self.AddViewKick ) then
            
            self:AddViewKick();
            
         else
            
            if( type( self.Primary.ViewPunch ) == "Angle" ) then
               
               self.Owner:ViewPunch( Angle( self.Primary.ViewPunch.p, math.random( -self.Primary.ViewPunch.y, self.Primary.ViewPunch.y ), math.random( -self.Primary.ViewPunch.r, self.Primary.ViewPunch.r ) ) );
               
            else
               
               self:DoMachineGunKick( self.Primary.ViewPunch.x, self.Primary.ViewPunch.y, self.Primary.Delay, self.Primary.ViewPunch.z );
               
            end
            
         end
         
         self.CanReload = true;
         
         if( type( self.Primary.Sound ) == "table" ) then
            for _, v in pairs( self.Primary.Sound ) do
               self:PlaySound( v, 80, 100 );
            end
         else
            self:PlaySound( self.Primary.Sound, 80, 100 );
         end
         
         if( !IsFirstTimePredicted() ) then return end
         



         self:ShootBullet( self.Primary.Damage, self.Primary.Force, self.Primary.NumBullets, self.Primary.Accuracy * self:BulletAccuracyModifier() );
               if( SERVER ) then

            if( !self.Owner.NextShooting ) then self.Owner.NextShooting = 0 end
            
            if( CurTime() >= self.Owner.NextShooting ) then
            self.Owner:SetGuns( math.Clamp( self.Owner:Guns() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Guns() ) * 0.75, 0, 100 ) );
          self.Owner:UpdateCharacterField( "StatGuns", tostring( self.Owner:Guns() ), true );
               self.Owner.NextShooting = CurTime() + 1;
end end
      end
      
   elseif( self.Melee ) then
      
      if( self.Owner:KeyDown( IN_ATTACK2 ) ) then return end
      

      self:SetNextPrimaryFire( CurTime() + self.MissDelay );
      self:SetNextSecondaryFire( CurTime() + self.MissDelay );
      
      self.Owner:LagCompensation( true );
      
      self.Owner:SetAnimation( PLAYER_ATTACK1 );
      
      if( SERVER ) then
                     self.Owner:SetHunger( math.max( self.Owner:Hunger() + 2, 0 ) );
         self.Owner:UpdateCharacterField( "Hunger", self.Owner:Hunger() ); end 

      self:PlaySound( self.SwingSound );
      
      local trace = { };
      trace.start = self.Owner:GetShootPos();
      trace.endpos = trace.start + self.Owner:GetAimVector() * self.Length;
      trace.filter = self.Owner;
      trace.mins = Vector( -8, -8, -8 );
      trace.maxs = Vector( 8, 8, 8 );
      
      local tr = util.TraceHull( trace );
      
      if( tr.Hit ) then
         
         
      self.Weapon:SendWeaponAnimShared( self.MissAnim or ACT_VM_MISSCENTER );
         
         self:SetNextPrimaryFire( CurTime() + self.HitDelay );
         self:SetNextSecondaryFire( CurTime() + self.HitDelay );
         
         local ltr = util.TraceLine( trace );
         
         if( tr.Entity and tr.Entity:IsValid() and ( tr.Entity:IsPlayer() or tr.Entity:IsNPC() ) ) then
            
            self:PlaySound( self.HitFleshSound );
            
         else
            
            if( type( self.HitWallSound ) == "boolean" ) then
               
               if( self.HitWallSound ) then
                  
                  self:PlaySound( GAMEMODE:GetImpactSound( tr ) );
                  
               end
               
            else
               
               self:PlaySound( self.HitWallSound );
               
            end
            
         end
         
         if( type( self.BulletDecal ) == "boolean" and self.BulletDecal ) then
            
            util.Decal( GAMEMODE:GetTraceDecal( tr ), ltr.HitPos + ltr.HitNormal, ltr.HitPos - ltr.HitNormal );
            
         elseif( self.BulletDecal ) then
            
            util.Decal( self.BulletDecal, ltr.HitPos + ltr.HitNormal, ltr.HitPos - ltr.HitNormal );
            
         end
         
         if( SERVER ) then
            
            if( !self.Owner.NextStrength ) then self.Owner.NextStrength = 0 end
            
            if( CurTime() >= self.Owner.NextStrength ) then
               
               self.Owner:SetStrength( math.Clamp( self.Owner:Strength() + GAMEMODE:ScaledStatIncrease( self.Owner, self.Owner:Strength() ) * 0.02, 0, 100 ) );
               self.Owner:UpdateCharacterField( "StatStrength", tostring( self.Owner:Strength() ), true );
               
               self.Owner.NextStrength = CurTime() + 5;
               
            end
            
            local blockmul = 1;
            
            if( tr.Entity:IsPlayer() ) then
               
               if( tr.Entity:GetActiveWeapon() and tr.Entity:GetActiveWeapon():IsValid() ) then
                  
                  if( tr.Entity:GetActiveWeapon().IsBlocking and tr.Entity:GetActiveWeapon():IsBlocking() ) then
                     
                     blockmul = tr.Entity:GetActiveWeapon().BlockMul;
                     
                  end
                  
               end
               
            end
            
            if( tr.Entity:IsPlayer() ) then
               
               net.Start( "nFlashRed" );
               net.Send( tr.Entity );
               
            end
            
            local dmg = DamageInfo();
            dmg:SetAttacker( self.Owner );
            dmg:SetDamage( math.Round( ( ( self.Owner:Strength() + 20 ) / 50 ) * ( self.DamageMul or 10 ) * blockmul ) );
            dmg:SetDamageForce( tr.Normal * 50 );
            dmg:SetDamagePosition( tr.HitPos );
            dmg:SetDamageType( self.DamageType or DMG_SLASH );
            dmg:SetInflictor( self );
            
            if( tr.Entity.DispatchTraceAttack ) then
               
               tr.Entity:DispatchTraceAttack( dmg, tr );
               
            end
            
         end
         
      else
         
         self.Weapon:SendWeaponAnimShared( self.MissAnim or ACT_VM_MISSCENTER );
         
      end
      
      if( self.AddViewKick ) then
         
         self:AddViewKick();
      
      else
         
         if( type( self.Primary.ViewPunch ) == "Angle" ) then
            
            self.Owner:ViewPunch( Angle( self.Primary.ViewPunch.p, math.random( -self.Primary.ViewPunch.y, self.Primary.ViewPunch.y ), math.random( -self.Primary.ViewPunch.r, self.Primary.ViewPunch.r ) ) );
            
         else
            
            self:DoMachineGunKick( self.Primary.ViewPunch.x, self.Primary.ViewPunch.y, self.Primary.Delay, self.Primary.ViewPunch.z );
            
         end
         
      end
      
      self.Owner:LagCompensation( false );
      self:Idle();
      
   end
   
end

