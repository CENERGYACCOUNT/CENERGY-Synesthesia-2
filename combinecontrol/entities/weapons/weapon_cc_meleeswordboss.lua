AddCSLuaFile()

-- General
SWEP.Base			= "weapon_cc_meleeblunt"
SWEP.Firearm            = true
SWEP.Primary.InfiniteAmmo  = true
-- Inventory
SWEP.PrintName 		= "EPIC BOSS SWORD"
SWEP.Itemize = true
SWEP.ItemDescription = "An epic boss sword."
SWEP.ItemWeight = 4
SWEP.ItemFOV = 12;
SWEP.ItemCamPos = Vector( 0.9, 50, 8.04 );
SWEP.ItemLookAt = Vector( 1.61, 1.61, -1.6 );
SWEP.Slot 			= 2
SWEP.SlotPos 		= 62
SWEP.SecondaryBlock = false;
-- Visuals
SWEP.UseHands     = true
SWEP.RepositionToHand = true;
SWEP.ViewModelFlip   = false;
SWEP.ViewModel       = "models/epangelmatikes/vsword/c_vibrosword.mdl"
SWEP.WorldModel   = "models/epangelmatikes/vsword/vsword.mdl"
SWEP.Primary.TracerName    = "";
SWEP.CSMuzzleFlashes	= true
SWEP.Attachment = 0
-- Sounds
SWEP.Primary.Sound         = "weapons/l4d2_oren_katana/katana_swing_miss3.wav"
SWEP.Primary.ReloadSound   = "models/epangelmatikes/vsword/vsword.mdl"
-- Anims
SWEP.Primary.AnimationHit = "atk_b"  -- Default hit animation
SWEP.Primary.AnimationMiss = "atk_h_r"  -- Default miss animation
SWEP.HoldType = "melee2"
SWEP.HoldTypeHolster = "passive"
SWEP.Holsterable = true
SWEP.CanSprint = true;
SWEP.ViewModelFOV = 70
SWEP.SwayScale    = 1;
SWEP.HolsterPos = Vector( 6.07, -0.47, -3.06 );
SWEP.HolsterAng = Vector( -7.05, 36.62, 0 );
SWEP.AimPos = Vector( 0, 0, 0 );
SWEP.AimAng = Vector( 0, 0, 0 );
-- Stats
SWEP.Primary.Automatic     = true
SWEP.Primary.Damage        = 25
SWEP.Primary.CritChance        = 25
SWEP.Primary.CritDamage        = 50
SWEP.Primary.Force         = 10
SWEP.Primary.DamageType = "slash" -- Options: "bullet", "slash", "blunt", "heat"
SWEP.Primary.BulletSize = 5 -- 1 size = 0.2. Enemy dodge is then multiplied by the total of that number. (meaning 5=100% chance to dodge with 100 agility, 1 = 20% with 100 agility)
SWEP.Primary.Penetration = 50
SWEP.Primary.Shredding = 1
SWEP.Primary.DodgeShredding = 0
SWEP.Primary.MaxRange = 160  -- Default, can be changed per weapon
SWEP.Primary.Accuracy      = 0.05
SWEP.Primary.Delay         = 0.95 -- THIS CANNOT GO UNDER 0.05 OTHERWISE SHIT BREAKS DO NOT ASK WHY DO NOT ASK ME TO FIX IT ITS JUST THE WAY IT IS
SWEP.KnockbackStrength = 1 -- Adjustable knockback strength
SWEP.Primary.RecoilAdd     =5
SWEP.Primary.ViewKick     = 5
SWEP.Primary.Recoil     = 5
SWEP.Scoped = false
SWEP.NoLaser = true;
SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.CrippleChance = 50  -- Example: 20% chance for suppression

-- Costs
SWEP.Primary.AttackCost   = 5
SWEP.Primary.ReloadCost   = 5
 
SWEP.StatMultipliers = {
    MuscleTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 },
    AgilityTemporary = { damage = 3, penetration = 3, shredding = 3, maxRange = 1 },
    ReflexesTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 },
    SlyTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 },
    CoolTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 },
    SmartsTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 },
    PersistenceTemporary = { damage = 0, penetration = 0, shredding = 0, maxRange = 0 }
}



local recoil = 5

function CalculateStatMultiplier(player, weapon)
    local totalDamage = 1
    local totalPenetration = 1
    local totalShredding = 1
    local totalMaxRange = 1  -- Add this line to calculate the MaxRange multiplier

    for stat, multipliers in pairs(weapon.StatMultipliers) do
        local statValue = player[stat] and player[stat](player) or 0
        totalDamage = totalDamage + (statValue * multipliers.damage * 0.01)
        totalPenetration = totalPenetration + (statValue * multipliers.penetration * 0.01)
        totalShredding = totalShredding + (statValue * multipliers.shredding * 0.01)
        totalMaxRange = totalMaxRange + (statValue * multipliers.maxRange * 0.01)  -- Apply multiplier for MaxRange
    end

    return totalDamage, totalPenetration, totalShredding, totalMaxRange  -- Return the totalMaxRange value
end



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

local ActIndex = {
    [ "pistol" ]        = ACT_HL2MP_IDLE_PISTOL,
    [ "revolver" ]      = ACT_HL2MP_IDLE_REVOLVER,
    [ "smg" ]           = ACT_HL2MP_IDLE_SMG1,
    [ "grenade" ]       = ACT_HL2MP_IDLE_GRENADE,
    [ "ar2" ]           = ACT_HL2MP_IDLE_AR2,
    [ "shotgun" ]       = ACT_HL2MP_IDLE_SHOTGUN,
    [ "rpg" ]           = ACT_HL2MP_IDLE_RPG,
    [ "physgun" ]       = ACT_HL2MP_IDLE_PHYSGUN,
    [ "crossbow" ]      = ACT_HL2MP_IDLE_CROSSBOW,
    [ "melee" ]         = ACT_HL2MP_IDLE_MELEE,
    [ "slam" ]          = ACT_HL2MP_IDLE_SLAM,
    [ "normal" ]        = ACT_HL2MP_IDLE,
    [ "" ]              = ACT_HL2MP_IDLE,
    [ "fist" ]          = ACT_HL2MP_IDLE_FIST,
    [ "melee2" ]        = ACT_HL2MP_IDLE_MELEE2,
    [ "passive" ]       = ACT_HL2MP_IDLE_PASSIVE,
    [ "knife" ]         = ACT_HL2MP_IDLE_KNIFE,
    [ "camera" ]        = ACT_HL2MP_IDLE_CAMERA,
    [ "duel" ]          = ACT_HL2MP_IDLE_DUEL,
    [ "magic" ]         = ACT_HL2MP_IDLE_MAGIC,
    [ "zombie" ]        = ACT_HL2MP_IDLE_ZOMBIE,
    [ "suitcase" ]      = ACT_HL2MP_IDLE_SUITCASE
}

function SWEP:SetWeaponHoldType( t )
    
    local index = ActIndex[ t ]
    
    self.ActivityTranslate = { }
    self.ActivityTranslate [ ACT_MP_STAND_IDLE ]                = index
    self.ActivityTranslate [ ACT_MP_WALK ]                      = index+1
    self.ActivityTranslate [ ACT_MP_RUN ]                       = index+2
    self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ]               = index+3
    self.ActivityTranslate [ ACT_MP_CROUCHWALK ]                = index+4
    self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]  = index+5
    self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
    self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]              = index+6
    self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]             = index+6
    self.ActivityTranslate [ ACT_MP_JUMP ]                      = index+7
    self.ActivityTranslate [ ACT_RANGE_ATTACK1 ]                = index+8
    
    if t == "normal" then
        self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
    end
    
    if t == "revolver" then
        self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL;
    end
    
    if t == "passive" then
        self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_IDLE_CROUCH;
    end
    
    if( t == "suitcase" ) then
        
        self.ActivityTranslate [ ACT_MP_STAND_IDLE ]                = ACT_HL2MP_IDLE_SUITCASE
        self.ActivityTranslate [ ACT_MP_WALK ]                      = ACT_HL2MP_WALK_SUITCASE
        self.ActivityTranslate [ ACT_MP_RUN ]                       = ACT_HL2MP_IDLE+2
        self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ]               = ACT_HL2MP_IDLE+3
        self.ActivityTranslate [ ACT_MP_CROUCHWALK ]                = ACT_HL2MP_IDLE+4
        self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]  = ACT_HL2MP_IDLE+5
        self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = ACT_HL2MP_IDLE+5
        self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]              = ACT_HL2MP_IDLE+6
        self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]             = ACT_HL2MP_IDLE+6
        self.ActivityTranslate [ ACT_MP_JUMP ]                      = ACT_HL2MP_IDLE+7
        self.ActivityTranslate [ ACT_RANGE_ATTACK1 ]                = ACT_HL2MP_IDLE+8
        
    end

end

function SWEP:SetWeaponHoldTypeHolster( t )
    
    local index = ActIndex[ t ]
    
    self.ActivityTranslateHolster = { }
    self.ActivityTranslateHolster [ ACT_MP_STAND_IDLE ]                 = index
    self.ActivityTranslateHolster [ ACT_MP_WALK ]                       = index+1
    self.ActivityTranslateHolster [ ACT_MP_RUN ]                        = index+2
    self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ]                = index+3
    self.ActivityTranslateHolster [ ACT_MP_CROUCHWALK ]                 = index+4
    self.ActivityTranslateHolster [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]   = index+5
    self.ActivityTranslateHolster [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
    self.ActivityTranslateHolster [ ACT_MP_RELOAD_STAND ]               = index+6
    self.ActivityTranslateHolster [ ACT_MP_RELOAD_CROUCH ]              = index+6
    self.ActivityTranslateHolster [ ACT_MP_JUMP ]                       = index+7
    self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ]                 = index+8
    
    if t == "normal" then
        self.ActivityTranslateHolster [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
    end
    
    if t == "revolver" then
        self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ] = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL;
    end
    
    if t == "passive" then
        self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ] = ACT_HL2MP_IDLE_CROUCH;
    end
    
    if( t == "suitcase" ) then
        
        self.ActivityTranslateHolster [ ACT_MP_STAND_IDLE ]                 = ACT_HL2MP_IDLE_SUITCASE
        self.ActivityTranslateHolster [ ACT_MP_WALK ]                       = ACT_HL2MP_WALK_SUITCASE
        self.ActivityTranslateHolster [ ACT_MP_RUN ]                        = ACT_HL2MP_IDLE+2
        self.ActivityTranslateHolster [ ACT_MP_CROUCH_IDLE ]                = ACT_HL2MP_IDLE+3
        self.ActivityTranslateHolster [ ACT_MP_CROUCHWALK ]                 = ACT_HL2MP_IDLE+4
        self.ActivityTranslateHolster [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]   = ACT_HL2MP_IDLE+5
        self.ActivityTranslateHolster [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = ACT_HL2MP_IDLE+5
        self.ActivityTranslateHolster [ ACT_MP_RELOAD_STAND ]               = ACT_HL2MP_IDLE+6
        self.ActivityTranslateHolster [ ACT_MP_RELOAD_CROUCH ]              = ACT_HL2MP_IDLE+6
        self.ActivityTranslateHolster [ ACT_MP_JUMP ]                       = ACT_HL2MP_IDLE+7
        self.ActivityTranslateHolster [ ACT_RANGE_ATTACK1 ]                 = ACT_HL2MP_IDLE+8
        
    end

end

local recoil = 2.41

function SWEP:AddViewKick()
    -- Add a small randomness to the recoil
    local randomPitch = math.Rand(-self.Primary.ViewKick * 1, self.Primary.ViewKick * 1)  -- Small random variation in pitch
    local randomYaw = math.Rand(-self.Primary.ViewKick * 1, self.Primary.ViewKick * 1)    -- Small random variation in yaw

    -- Apply the view punch with the added randomness
    self.Owner:ViewPunch(Angle(-self.Primary.ViewKick + randomPitch, randomYaw, 0))

    if ((game.SinglePlayer() and SERVER) or ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then
        -- Reduce recoil if ironsighting
        recoil = recoil
        local eyeang = self.Owner:EyeAngles()
        eyeang.pitch = eyeang.pitch - recoil - randomPitch  -- Apply random pitch
        eyeang.yaw = eyeang.yaw + randomYaw  -- Apply random yaw
        self.Owner:SetEyeAngles(eyeang)
    end
end



function SWEP:TranslateActivity( act )
    
    local val = -1;
    
    if( self.Owner:Holstered() ) then
        
        if( self.ActivityTranslateHolster[ act ] ) then
            val = self.ActivityTranslateHolster[ act ]
        end
        
    else
        
        if( self.ActivityTranslate[ act ] ) then
            val = self.ActivityTranslate[ act ]
        end
        
    end
    
    local len2d = self.Owner:GetVelocity():Length2D();
    
    if( val == ACT_HL2MP_RUN and len2d >= 200 ) then
        
        val = ACT_HL2MP_RUN_FAST;
        
    end
    
    return val;
    
end

function SWEP:Initialize()
    
    self:SetWeaponHoldType( self.HoldType );
    self:SetWeaponHoldTypeHolster( self.HoldTypeHolster );
    
end

function SWEP:Precache()
    
    if( self.Firearm ) then
        
        if( type( self.Primary.Sound ) == "table" ) then
            
            for _, v in pairs( self.Primary.Sound ) do
                
                util.PrecacheSound( v );
                
            end
            
        else
            
            util.PrecacheSound( self.Primary.Sound );
            
        end
        
        util.PrecacheSound( self.Primary.ReloadSound );
        
    end
    
end

function SWEP:DoDrawAnim()
    
    if( self.DrawAnim ) then
        
        if( type( self.DrawAnim ) == "string" ) then
            
            local vm = self.Owner:GetViewModel();
            vm:SendViewModelMatchingSequence( vm:LookupSequence( self.DrawAnim ) );
            
        else
                self.Owner:EmitSound( "player/weapon_draw_01.wav" );
            self:SendWeaponAnimShared( self.DrawAnim );
            
        end
        
    else
        
        self:SendWeaponAnimShared( ACT_VM_DRAW );
        
    end
    
    self:Idle();
    
end

function SWEP:DoHolsterAnim()
    
    if( self.HolsterAnim ) then
        
        if( type( self.HolsterAnim ) == "string" ) then
            
            local vm = self.Owner:GetViewModel();
            vm:SendViewModelMatchingSequence( vm:LookupSequence( self.HolsterAnim ) );
            
        else
                self.Owner:EmitSound( "player/weapon_draw_01.wav" );
            self:SendWeaponAnimShared( self.HolsterAnim );
            
        end
        
    else
        
        self:SendWeaponAnimShared( ACT_VM_HOLSTER );
        
    end
    
    timer.Stop( "cc_weapon_idle" .. self:EntIndex() );
end

function SWEP:IdleNow()
    
    self:SendWeaponAnimShared( ACT_VM_IDLE );
    
end

function SWEP:Idle()
    
    if( self.DevMode ) then return end -- No pesky animations getting in MY way.
    
    local vm = self.Owner:GetViewModel();
    
    timer.Create( "cc_weapon_idle" .. self:EntIndex(), vm:SequenceDuration(), 1, function()
        
        if( !self or !self:IsValid() or !self.Owner or !self.Owner:IsValid() ) then return end
        
        self:IdleNow();
        
    end )
    
end

function SWEP:Deploy()
    
    if( self.Owner:Holstered() and self.HolsterUseAnim ) then
        
        self:DoHolsterAnim();
        
    elseif( !self.Owner:Holstered() and self.HolsterUseAnim ) then
        
        self:DoDrawAnim();
        
    else
        
        if( self.Owner:Holstered() ) then
            
            self.IronMode = IRON_HOLSTERED;
            self.IronMul = 1;
            
        else
            
            self.IronMode = IRON_IDLE;
            self.IronMul = 0;
            
        end
        
    end
    
    if( self:DeployChild() ) then return false end
    return true;
    
end

function SWEP:DeployChild()
end

function SWEP:OnRemove()
end

function SWEP:HolsterChild()
end

function SWEP:Holster()
    
    timer.Stop( "cc_weapon_idle" .. self:EntIndex() );
    
    if( self:HolsterChild() ) then return false end
    return true;
    
end




function SWEP:Think()


    if( !self.CanSprint ) then 
         if self.Owner:Holstered() then 

         else
-- RUNNING ANIMS

   if (self.Owner:KeyDown(IN_SPEED) and self.Owner:GetAbsVelocity():Length() > 20) or not self.Owner:OnGround() then
local recoil = 2.41
self.Owner:SetHolstered( true );
    timer.Simple( 0.01, function()
self.Owner:SetHolstered( false );
end)
end 
 end
end
    if( self.ApplyReload and CurTime() >= self.ApplyReload ) then
        
        self.ApplyReload = nil;
        
        self:SetClip1( self:Clip1() + self.ApplyReloadAmount );
        
        if( !self.Primary.InfiniteAmmo ) then
            
            self.Owner:RemoveAmmo( self.ApplyReloadAmount, self.Primary.Ammo );
            
        end
        
    end
    
    if( !IsFirstTimePredicted() ) then return end
    
    if( self.ThinkChild ) then
        
        self:ThinkChild()
        
    end
    
    if( !self.Owner or !self.Owner:IsValid() ) then return end
    
    if( self.Owner:Holstered() and self.IronMode > IRON_HOLSTERED ) then -- Going down.
        
        if( self.IronMode > IRON_IDLE ) then
            self.IronMul = 0;
        end
        
        if( self.HolsterUseAnim ) then
            
            self:DoHolsterAnim();
            self.IronMode = IRON_HOLSTERED;
            
        else
            
            self.IronMode = IRON_HOLSTERED2IDLE;
            self.IronDir = 1;
            
            self:Idle();
            
        end
        
    elseif( !self.Owner:Holstered() and self.IronMode < IRON_IDLE ) then -- Raising up.
        
        if( self.HolsterUseAnim ) then
            
            self:DoDrawAnim();
            self.IronMode = IRON_IDLE;
            self.IronMul = 0;
            
        else
            
            self.IronMode = IRON_HOLSTERED2IDLE;
            self.IronDir = -1;
            
            timer.Stop( "cc_weapon_idle" .. self:EntIndex() );
            
        end
        
    end
    
    if( self.Owner:KeyDown( IN_ATTACK2 ) ) then
        
        if( self.IronMode == IRON_IDLE or self.IronMode == IRON_IDLE2AIM ) then
            
            self.IronMode = IRON_IDLE2AIM;
            self.IronDir = 1;
            
        end
        
    elseif( self.IronMode > IRON_IDLE ) then
        
        self.IronMode = IRON_IDLE2AIM;
        self.IronDir = -1;
        
    end
    
    if( self.Attachment ) then
                
        local b = self.Attachment
                
        self.Owner:GetViewModel():SetBodygroup(1, b)
        self:SetBodygroup(1, b)
                
    end
    
end

function SWEP:PlaySound( snd, vol, pit )
    
    if( SERVER ) then
        
        if( type( snd ) == "table" ) then
            
            self.Owner:EmitSound( table.Random( snd ), vol, pit );
            
        else
            
            self.Owner:EmitSound( snd, vol, pit );
            
        end
        
    end
    
end

function SWEP:StopSound( snd )
    
    if( SERVER ) then
        
        self.Owner:StopSound( snd );
        
    end
    
end

function SWEP:CanPrimaryAttack( noreload )
    return true;
end

function SWEP:CanSecondaryAttack()
    return true;
end

function SWEP:BulletAccuracyModifier( m )
    
    local m = m or 0.8;
    
    local mulstat = 1 - ( self.Owner:AccuracyTemporary() / 100 ) * m;
    local muliron = self.Owner:KeyDown( IN_ATTACK2 ) and 0.7 or 1;
    
    return mulstat * muliron;
    
end

function SWEP:PrimaryHolstered()    
end


function SWEP:ShootEffects()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        -- Randomly pick hit or miss animation, adjustable in SWEP config
        local anim = math.random(1, 2) == 1 and self.Primary.AnimationHit or self.Primary.AnimationMiss 
        vm:SendViewModelMatchingSequence(vm:LookupSequence(anim)) -- Custom animation
    end

    -- Muzzle flash and player attack animation
    self.Owner:MuzzleFlash()
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    -- Force reset animation after a short delay
    timer.Simple(0, function()
        if IsValid(vm) then
            vm:SetPlaybackRate(1) -- Ensure it plays at normal speed
        end
    end)
end


function SWEP:PrimaryUnholstered()
        if (GAMEMODE:Combat() == 0) or (self.Owner:Attack() > self.Primary.AttackCost - 0.1) then

        -- Your attack logic here
  

        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:ShootEffects()
        self:Idle()

        -- View Kick or Punch
        if self.AddViewKick then
            self:AddViewKick()
        else
            local punch = self.Primary.ViewPunch
            if type(punch) == "Angle" then
                self.Owner:ViewPunch(Angle(punch.p, math.random(-punch.y, punch.y), math.random(-punch.r, punch.r)))
            else
                self:DoMachineGunKick(punch.x, punch.y, self.Primary.Delay, punch.z)
            end
        end

        -- Reload and Sound
        self.CanReload = true
        if type(self.Primary.Sound) == "table" then
            for _, sound in pairs(self.Primary.Sound) do
                self:PlaySound(sound, 80, 100)
            end
        else
            self:PlaySound(self.Primary.Sound, 80, 100)
        end

        -- Shooting
        if IsFirstTimePredicted() then

            
  self:ShootBullet(self.Primary.Damage, self.Primary.Force, self.Primary.NumBullets, self.Primary.Accuracy * self:BulletAccuracyModifier())
       
        end
 if self.Owner:IsOnGround() then  -- Ensure player is on the ground before moving
            local forward = self.Owner:GetForward()  -- Get the player's facing direction
            self.Owner:SetVelocity(self.Owner:GetVelocity() + forward * 50) end -- Add a forward velocity boost (adjust 200 as needed)
        -- Attack Cost Timer
        if SERVER then
          timer.Simple(0, function()
                self.Owner:SetAttack(math.Clamp(self.Owner:Attack() - self.Primary.AttackCost, 0, 100))
            end)
        end
    end
end

function SWEP:SecondaryHolstered()
end

function SWEP:SecondaryUnholstered()
        if (GAMEMODE:Combat() == 0) or (self.Owner:Attack() > self.Primary.AttackCost  * 2 - 0.1) then

        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:ShootEffects()
        self:Idle()

        -- View Kick or Punch
        if self.AddViewKick then
            self:AddViewKick()
        else
            local punch = self.Primary.ViewPunch
            if type(punch) == "Angle" then
                self.Owner:ViewPunch(Angle(punch.p, math.random(-punch.y, punch.y), math.random(-punch.r, punch.r)))
            else
                self:DoMachineGunKick(punch.x, punch.y, self.Primary.Delay, punch.z)
            end
        end

        -- Reload and Sound
        self.CanReload = true
        if type(self.Primary.Sound) == "table" then
            for _, sound in pairs(self.Primary.Sound) do
                self:PlaySound(sound, 80, 100)
            end
        else
            self:PlaySound(self.Primary.Sound, 80, 100)
        end
 if self.Owner:IsOnGround() then  -- Ensure player is on the ground before moving
            local forward = self.Owner:GetForward()  -- Get the player's facing direction
            self.Owner:SetVelocity(self.Owner:GetVelocity() + forward * 100) end -- Add a forward velocity boost (adjust 200 as needed)
        -- Shooting
        if IsFirstTimePredicted() then

            
  self:ShootBulletHeavy(self.Primary.Damage, self.Primary.Force, self.Primary.NumBullets, self.Primary.Accuracy * self:BulletAccuracyModifier())
       
        end

        -- Attack Cost Timer
        if SERVER then
          timer.Simple(0, function()
             self.Owner:SetAttack(math.Clamp(self.Owner:Attack() - self.Primary.AttackCost * 2, 0, 100))  -- Double the cost


            end)
        end
 end
end

function SWEP:ShootBulletHeavy(damage, force, n, aimcone)
    local bulletheavy = {}
    bulletheavy.Num     = n or 1
    bulletheavy.Src     = self.Owner:GetShootPos()
    bulletheavy.Dir     = self.Owner:GetAimVector()
    bulletheavy.Spread  = Vector(aimcone, aimcone, 0)
    bulletheavy.Tracer  = 1
    bulletheavy.HullSize = 0.01
    bulletheavy.Damage  = 0.0
    bulletheavy.Force   = force
    bulletheavy.AmmoType = "Pistol"
    bulletheavy.TracerName = self.Primary.TracerName or "Tracer"

    local tr = util.TraceLine({
        start = bulletheavy.Src,
        endpos = bulletheavy.Src + bulletheavy.Dir * 10000,
        filter = self.Owner
    })

    local distance = tr.HitPos:Distance(self.Owner:GetShootPos())
    local maxRange = self.Primary.MaxRange
    local damageMultiplier, penetrationMultiplier, shreddingMultiplier, maxRangeMultiplier = CalculateStatMultiplier(self.Owner, self)

    -- Apply the multiplier to MaxRange
    local effectiveMaxRange = maxRange * maxRangeMultiplier

    if distance > effectiveMaxRange then
        self.Owner:EmitSound("weapons/l4d2_oren_katana/katana_swing_miss1.wav")
        return
    end

    bulletheavy.Callback = function(ply, tr, dmg)
        if CLIENT then return end

        if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then
            ply:EmitSound("weapons/l4d2_oren_katana/katana_impact_world1.wav")
            return
        end

        ply:EmitSound("weapons/l4d2_oren_katana/melee_katana_02.wav")

        local rangeFactor = 1 - math.Clamp(distance / effectiveMaxRange, 0, 1)

        local effectiveDamage = damage * rangeFactor * damageMultiplier *2
        local effectivePenetration = self.Primary.Penetration * penetrationMultiplier



if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
-- Dodge mechanics
local statAgility = tr.Entity:Agility() or 0
local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
local dodgeChance = statAgility * bulletSizeFactor * 2  -- Double the dodge chance

if math.random(1, 100) <= dodgeChance then
    dmg:SetDamage(0)
    tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_swing_miss2.wav")
    tr.Entity:SetVelocity(VectorRand() * math.random(60, 200))
    return
end

    if self.Primary.DodgeShredding and self.Primary.DodgeShredding > 0 then
            -- Check if the target has the AgilityTemporary stat
            local agilityTemporary = tr.Entity:AgilityTemporary() or 0
            local newAgility = math.max(0, agilityTemporary - self.Primary.DodgeShredding)  -- Deduct DodgeShredding, ensure it doesn't go below 0
            tr.Entity:SetAgilityTemporary(newAgility)  -- Apply the new AgilityTemporary value
        end

if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
-- Parry mechanics
local statParry = tr.Entity:Parry() or 0
local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
local parryChance = statParry * bulletSizeFactor * 2  -- Double the parry chance

if math.random(1, 100) <= parryChance then
    dmg:SetDamage(0)
    tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_impact_world1.wav")
    tr.Entity:SetVelocity(VectorRand() * math.random(20, 60))
    return
end




-- Determine hit part based on hitgroup
local hitPart = "" -- Default to an empty string
if hitgroup == HITGROUP_HEAD then
    hitPart = "Head"
elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
    hitPart = "Chest"
elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
    hitPart = "Arms"
elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
    hitPart = "Legs"
end

if hitPart ~= "" then
    -- Apply shredding with range factor, rounded up to the nearest whole number
    ApplyShredding(tr.Entity, "Blunt", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Slash", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Bullet", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Heat", hitPart, rangeFactor)
end


        local hitgroup = tr.HitGroup
        local armorValue = 0
        local damageType = self.Primary.DamageType or "bullet"
        local defenseMethodBase = string.gsub(damageType, "^%l", string.upper)

        if hitgroup == HITGROUP_HEAD then
            defenseMethodBase = defenseMethodBase .. "HeadDefenseTemporary"
        elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
            defenseMethodBase = defenseMethodBase .. "ChestDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
            defenseMethodBase = defenseMethodBase .. "ArmsDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
            defenseMethodBase = defenseMethodBase .. "LegsDefenseTemporary"
        end

        if tr.Entity[defenseMethodBase] then
            armorValue = tr.Entity[defenseMethodBase](tr.Entity) or 0
            local newArmorValue = math.max(math.Round(armorValue), 0)
            local setDefenseMethod = "Set" .. defenseMethodBase
            if tr.Entity[setDefenseMethod] then
                tr.Entity[setDefenseMethod](tr.Entity, newArmorValue)
            end
            armorValue = newArmorValue
        end

-- Shredding effect with range factor, rounded up to the nearest whole number
local shreddingValue = self.Primary.Shredding * shreddingMultiplier or 0
local damageType = self.Primary.DamageType or "bullet" -- Default to "bullet"

local function ApplyShredding(entity, defenseType, hitPart, rangeFactor)
    -- Check if the target has 'statusmarkreveal' oddity and double the shredding value if true
    if entity:HasOddity("statusmarkreveal") then
        shreddingValue = shreddingValue * 1.2  -- Double the shredding value if the target has 'statusmarkreveal'
    end

    local defenseMethod = defenseType .. hitPart .. "DefenseTemporary" -- e.g., BluntHeadDefense, SlashChestDefense
    local setDefenseMethod = "Set" .. defenseMethod

    if entity[defenseMethod] and entity[setDefenseMethod] then
        local currentDefense = entity[defenseMethod](entity) or 0
        local adjustedShreddingValue = shreddingValue -- Apply range factor to shredding value

        -- Round up to the next whole number
        adjustedShreddingValue = math.ceil(adjustedShreddingValue)

        -- Prevent negative values
        local newDefense = math.max(currentDefense - adjustedShreddingValue * 2, 0) -- Apply double multiplier
        entity[setDefenseMethod](entity, newDefense)
    end
end


-- Determine hit part based on hitgroup
local hitPart = "" -- Default to an empty string
if hitgroup == HITGROUP_HEAD then
    hitPart = "Head"
elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
    hitPart = "Chest"
elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
    hitPart = "Arms"
elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
    hitPart = "Legs"
end

if hitPart ~= "" then
    -- Apply shredding with range factor, rounded up to the nearest whole number
    ApplyShredding(tr.Entity, "Blunt", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Slash", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Bullet", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Heat", hitPart, rangeFactor)
end

        if effectivePenetration >= armorValue then
            if hitgroup == HITGROUP_HEAD then
                effectiveDamage = effectiveDamage * 2
            elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
                effectiveDamage = effectiveDamage * 0.5
            elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
                effectiveDamage = effectiveDamage * 0.5
            end

               local critChance = self.Owner:CriticalChanceTemporary() + self.Primary.CritChance  or 0  -- Expected to return a percentage value (e.g., 25 for 25%)
            local critDamage = self.Owner:CriticalDamageTemporary() + self.Primary.CritDamage or 0  -- Expected to return a percentage bonus

    if tr.Entity:HasOddity("statusmarktarget") then
    critChance = critChance + 50  -- Increase crit chance by 50% if the target has 'statusmarktarget'
end

              if math.random(1, 100) <= critChance then
                effectiveDamage = effectiveDamage * (1 + (critDamage * 2 / 100))
                -- Play critical sound
                       ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
                ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
            end
              local resistance = tr.Entity.Resistance and tr.Entity:Resistance() or 0
            effectiveDamage = effectiveDamage * (1 - (resistance / 100))

    -- Apply final damage


        if math.random(1, 100) <= self.CrippleChance then
    -- Check the hitgroup for the body part
    if tr.Entity:IsPlayer() then
        if tr.HitGroup == HITGROUP_LEFTLEG or tr.HitGroup == HITGROUP_RIGHTLEG then
            -- Check if the player does not already have the "crippledleg" status
            if not tr.Entity:HasOddity("crippledleg") then
                tr.Entity:GiveOddity("crippledleg")  -- Apply the crippled leg effect
           tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        elseif tr.HitGroup == HITGROUP_LEFTARM or tr.HitGroup == HITGROUP_RIGHTARM then
            -- Check if the player does not already have the "crippledarm" status
            if not tr.Entity:HasOddity("crippledarm") then
                tr.Entity:GiveOddity("crippledarm")  -- Apply the crippled arm effect
         tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        end
    end
end

    tr.Entity:TakeDamage(effectiveDamage, ply, self)

            local shotDirection = (tr.Entity:GetPos() - ply:GetShootPos()):GetNormalized()
            tr.Entity:SetVelocity(shotDirection * (force * 0.5))

         local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("bloodimpact", effectData, true, true)


        else
            dmg:SetDamage(0)
            tr.Entity:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")
            util.Decal("Impact.Concrete", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

            local originalBloodEffect = tr.Entity.BloodEffect or nil
            tr.Entity.BloodEffect = ""

            local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("StunstickImpact", effectData, true, true)

            timer.Simple(0, function()
                if IsValid(tr.Entity) then
                    tr.Entity.BloodEffect = originalBloodEffect
                end
            end)
        end
    end

    timer.Simple(0.20, function()
        self.Owner:FireBullets(bulletheavy)
    end)
end











function SWEP:ShootBullet(damage, force, n, aimcone)
    local bullet = {}
    bullet.Num     = n or 1
    bullet.Src     = self.Owner:GetShootPos()
    bullet.Dir     = self.Owner:GetAimVector()
    bullet.Spread  = Vector(aimcone, aimcone, 0)
    bullet.Tracer  = 1
    bullet.HullSize = 0.01
    bullet.Damage  = 0.0
    bullet.Force   = force
    bullet.AmmoType = "Pistol"
    bullet.TracerName = self.Primary.TracerName or "Tracer"

    local tr = util.TraceLine({
        start = bullet.Src,
        endpos = bullet.Src + bullet.Dir * 10000,
        filter = self.Owner
    })

    local distance = tr.HitPos:Distance(self.Owner:GetShootPos())
    local maxRange = self.Primary.MaxRange
    local damageMultiplier, penetrationMultiplier, shreddingMultiplier, maxRangeMultiplier = CalculateStatMultiplier(self.Owner, self)

    -- Apply the multiplier to MaxRange
    local effectiveMaxRange = maxRange * maxRangeMultiplier

    if distance > effectiveMaxRange then
        self.Owner:EmitSound("weapons/l4d2_oren_katana/katana_swing_miss1.wav")
        return
    end

    bullet.Callback = function(ply, tr, dmg)
        if CLIENT then return end

        if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then
            ply:EmitSound("weapons/l4d2_oren_katana/katana_impact_world1.wav")
            return
        end

        ply:EmitSound("weapons/l4d2_oren_katana/melee_katana_02.wav")

        local rangeFactor = 1 - math.Clamp(distance / effectiveMaxRange, 0, 1)

        local effectiveDamage = damage * rangeFactor * damageMultiplier
        local effectivePenetration = self.Primary.Penetration * penetrationMultiplier
    



   if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
        -- Dodge mechanics
        local statAgility = tr.Entity:Agility() or 0
        local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
        local dodgeChance = statAgility * bulletSizeFactor

        if math.random(1, 100) <= dodgeChance then
            dmg:SetDamage(0)
            tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_swing_miss2.wav")
            tr.Entity:SetVelocity(VectorRand() * math.random(60, 200))
            return
        end

         if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
        -- Parry mechanics
        local statParry = tr.Entity:Parry() or 0
        local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
        local dodgeChance = statParry * bulletSizeFactor

        if math.random(1, 100) <= dodgeChance then
            dmg:SetDamage(0)
            tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_impact_world1.wav")
            tr.Entity:SetVelocity(VectorRand() * math.random(20, 60))
            return
        end

    if self.Primary.DodgeShredding and self.Primary.DodgeShredding > 0 then
            -- Check if the target has the AgilityTemporary stat
            local agilityTemporary = tr.Entity:AgilityTemporary() or 0
            local newAgility = math.max(0, agilityTemporary - self.Primary.DodgeShredding)  -- Deduct DodgeShredding, ensure it doesn't go below 0
            tr.Entity:SetAgilityTemporary(newAgility)  -- Apply the new AgilityTemporary value
        end

        local hitgroup = tr.HitGroup
        local armorValue = 0
        local damageType = self.Primary.DamageType or "bullet"
        local defenseMethodBase = string.gsub(damageType, "^%l", string.upper)

        if hitgroup == HITGROUP_HEAD then
            defenseMethodBase = defenseMethodBase .. "HeadDefenseTemporary"
        elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
            defenseMethodBase = defenseMethodBase .. "ChestDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
            defenseMethodBase = defenseMethodBase .. "ArmsDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
            defenseMethodBase = defenseMethodBase .. "LegsDefenseTemporary"
        end

        if tr.Entity[defenseMethodBase] then
            armorValue = tr.Entity[defenseMethodBase](tr.Entity) or 0
            local newArmorValue = math.max(math.Round(armorValue), 0)
            local setDefenseMethod = "Set" .. defenseMethodBase
            if tr.Entity[setDefenseMethod] then
                tr.Entity[setDefenseMethod](tr.Entity, newArmorValue)
            end
            armorValue = newArmorValue
        end

local shreddingValue = self.Primary.Shredding * shreddingMultiplier or 0
local damageType = self.Primary.DamageType or "bullet" -- Default to "bullet"

local function ApplyShredding(entity, defenseType, hitPart, rangeFactor)
    -- Check if the target has 'statusmarkreveal' oddity and double the shredding value if true
    if entity:HasOddity("statusmarkreveal") then
        shreddingValue = shreddingValue * 1.2  -- Double the shredding value if the target has 'statusmarkreveal'
    end

    local defenseMethod = defenseType .. hitPart .. "DefenseTemporary" -- e.g., BluntHeadDefense, SlashChestDefense
    local setDefenseMethod = "Set" .. defenseMethod

    if entity[defenseMethod] and entity[setDefenseMethod] then
        local currentDefense = entity[defenseMethod](entity) or 0
        local adjustedShreddingValue = shreddingValue -- Apply range factor to shredding value

        -- Round up to the next whole number
        adjustedShreddingValue = math.ceil(adjustedShreddingValue)

        -- Prevent negative values
        local newDefense = math.max(currentDefense - adjustedShreddingValue * 2, 0) -- Apply double multiplier
        entity[setDefenseMethod](entity, newDefense)
    end
end


-- Determine hit part based on hitgroup
local hitPart = "" -- Default to an empty string
if hitgroup == HITGROUP_HEAD then
    hitPart = "Head"
elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
    hitPart = "Chest"
elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
    hitPart = "Arms"
elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
    hitPart = "Legs"
end

if hitPart ~= "" then
    -- Apply shredding with range factor, rounded up to the nearest whole number
    ApplyShredding(tr.Entity, "Blunt", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Slash", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Bullet", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Heat", hitPart, rangeFactor)
end

        if effectivePenetration >= armorValue then
            if hitgroup == HITGROUP_HEAD then
                effectiveDamage = effectiveDamage * 2
            elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
                effectiveDamage = effectiveDamage * 0.5
            elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
                effectiveDamage = effectiveDamage * 0.5
            end

            local critChance = self.Owner:CriticalChanceTemporary() + self.Primary.CritChance  or 0  -- Expected to return a percentage value (e.g., 25 for 25%)
            local critDamage = self.Owner:CriticalDamageTemporary() + self.Primary.CritDamage or 0  -- Expected to return a percentage bonus

    if tr.Entity:HasOddity("statusmarktarget") then
    critChance = critChance + 50  -- Increase crit chance by 50% if the target has 'statusmarktarget'
end

              if math.random(1, 100) <= critChance then
                effectiveDamage = effectiveDamage * (1 + (critDamage * 2 / 100))
                -- Play critical sound
                       ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
                ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
            end
              local resistance = tr.Entity.Resistance and tr.Entity:Resistance() or 0
            effectiveDamage = effectiveDamage * (1 - (resistance / 100))

    -- Apply final damage


        if math.random(1, 100) <= self.CrippleChance then
    -- Check the hitgroup for the body part
    if tr.Entity:IsPlayer() then
        if tr.HitGroup == HITGROUP_LEFTLEG or tr.HitGroup == HITGROUP_RIGHTLEG then
            -- Check if the player does not already have the "crippledleg" status
            if not tr.Entity:HasOddity("crippledleg") then
                tr.Entity:GiveOddity("crippledleg")  -- Apply the crippled leg effect
            tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        elseif tr.HitGroup == HITGROUP_LEFTARM or tr.HitGroup == HITGROUP_RIGHTARM then
            -- Check if the player does not already have the "crippledarm" status
            if not tr.Entity:HasOddity("crippledarm") then
                tr.Entity:GiveOddity("crippledarm")  -- Apply the crippled arm effect
        tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        end
    end
end

    tr.Entity:TakeDamage(effectiveDamage, ply, self)

            local shotDirection = (tr.Entity:GetPos() - ply:GetShootPos()):GetNormalized()
            tr.Entity:SetVelocity(shotDirection * (force * 0.5))

                     local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("bloodimpact", effectData, true, true)

        else
            dmg:SetDamage(0)
            tr.Entity:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")
            util.Decal("Impact.Concrete", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

            local originalBloodEffect = tr.Entity.BloodEffect or nil
            tr.Entity.BloodEffect = ""

            local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("StunstickImpact", effectData, true, true)

            timer.Simple(0, function()
                if IsValid(tr.Entity) then
                    tr.Entity.BloodEffect = originalBloodEffect
                end
            end)
        end
    end

    timer.Simple(0.20, function()
        self.Owner:FireBullets(bullet)
    end)
end



function SWEP:PrimaryAttack()
    
    if( self.Owner:Holstered() ) then
        
        self:PrimaryHolstered();
        
    else
        
        self:PrimaryUnholstered();
        
    end
    
end

function SWEP:SecondaryAttack()
    
    if( self.Owner:Holstered() ) then
        
        self:SecondaryHolstered();
        
    else
        
        self:SecondaryUnholstered();
        
    end
    
end

function SWEP:IsBlocking()

    
    if( self.SecondaryBlock ) then
        
        if( !self.Owner:Holstered() and self.Owner:KeyDown( IN_ATTACK2 ) ) then
                    self:SetNextPrimaryFire( CurTime() + 1 );
    self:SetNextSecondaryFire( CurTime() + 1 );
            return true;
            
        end
        
    end
    
    return false;
    
end 

function SWEP:Reload()
            if (GAMEMODE:Combat() == 0) or (self.Owner:Attack() > self.Primary.AttackCost * 1 - 0.1) then
                        if (GAMEMODE:Combat() == 0) or (self.Owner:Special() > self.Primary.AttackCost * 1 - 0.1) then
        if( !self.NextReload ) then self.NextReload = CurTime() end
    
    if( CurTime() < self.NextReload ) then return end
        self.NextReload = CurTime() + self.Primary.Delay;
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:ShootEffects()
        self:Idle()

        -- View Kick or Punch
        if self.AddViewKick then
            self:AddViewKick()
        else
            local punch = self.Primary.ViewPunch
            if type(punch) == "Angle" then
                self.Owner:ViewPunch(Angle(punch.p, math.random(-punch.y, punch.y), math.random(-punch.r, punch.r)))
            else
                self:DoMachineGunKick(punch.x, punch.y, self.Primary.Delay, punch.z)
            end
        end

        -- Reload and Sound
        self.CanReload = true
        if type(self.Primary.Sound) == "table" then
            for _, sound in pairs(self.Primary.Sound) do
                self:PlaySound(sound, 80, 100)
            end
        else
            self:PlaySound(self.Primary.Sound, 80, 100)
        end
 if self.Owner:IsOnGround() then  -- Ensure player is on the ground before moving
            local forward = self.Owner:GetForward()  -- Get the player's facing direction
            self.Owner:SetVelocity(self.Owner:GetVelocity() + forward * 200) end -- Add a forward velocity boost (adjust 200 as needed)
        -- Shooting
        if IsFirstTimePredicted() then

            
  self:ShootBulletSpecial(self.Primary.Damage, self.Primary.Force, self.Primary.NumBullets, self.Primary.Accuracy * self:BulletAccuracyModifier())
       
        end

        -- Attack Cost Timer
        if SERVER then
          timer.Simple(0, function()
             self.Owner:SetAttack(math.Clamp(self.Owner:Attack() - self.Primary.AttackCost * 1, 0, 100))  -- Double the cost
            self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - self.Primary.AttackCost * 1, 0, 100))  -- Double the cost

            end)
        end
    end end
end



function SWEP:ShootBulletSpecial(damage, force, n, aimcone)
    local bulletspecial = {}
    bulletspecial.Num     = n or 1
    bulletspecial.Src     = self.Owner:GetShootPos()
    bulletspecial.Dir     = self.Owner:GetAimVector()
    bulletspecial.Spread  = Vector(aimcone, aimcone, 0)
    bulletspecial.Tracer  = 1
    bulletspecial.HullSize = 0.01
    bulletspecial.Damage  = 0.0
    bulletspecial.Force   = force
    bulletspecial.AmmoType = "Pistol"
    bulletspecial.TracerName = self.Primary.TracerName or "Tracer"

    local tr = util.TraceLine({
        start = bulletspecial.Src,
        endpos = bulletspecial.Src + bulletspecial.Dir * 10000,
        filter = self.Owner
    })

    local distance = tr.HitPos:Distance(self.Owner:GetShootPos())
    local maxRange = self.Primary.MaxRange
    local damageMultiplier, penetrationMultiplier, shreddingMultiplier, maxRangeMultiplier = CalculateStatMultiplier(self.Owner, self)

    -- Apply the multiplier to MaxRange
    local effectiveMaxRange = maxRange * maxRangeMultiplier

    if distance > effectiveMaxRange then
        self.Owner:EmitSound("weapons/l4d2_oren_katana/katana_swing_miss1.wav")
        return
    end

    bulletspecial.Callback = function(ply, tr, dmg)
        if CLIENT then return end

        if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then
            ply:EmitSound("weapons/l4d2_oren_katana/katana_impact_world1.wav")
            return
        end

        ply:EmitSound("weapons/l4d2_oren_katana/melee_katana_02.wav")

        local rangeFactor = 1 - math.Clamp(distance / effectiveMaxRange, 0, 1)

        local effectiveDamage = damage *0.75 * rangeFactor * damageMultiplier
        local effectivePenetration = self.Primary.Penetration *2 * penetrationMultiplier



   if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
        -- Dodge mechanics
        local statAgility = tr.Entity:Agility() or 0
        local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
        local dodgeChance = statAgility * bulletSizeFactor

        if math.random(1, 100) <= dodgeChance then
            dmg:SetDamage(0)
            tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_swing_miss2.wav")
            tr.Entity:SetVelocity(VectorRand() * math.random(60, 200))
            return
        end


         if not tr.Entity:IsPlayer() or not tr.Entity:IsValid() then return end
        -- Parry mechanics
        local statParry = tr.Entity:Parry() or 0
        local bulletSizeFactor = math.Clamp(self.Primary.BulletSize / 5, 0.1, 1)
        local dodgeChance = statParry * bulletSizeFactor

        if math.random(1, 100) <= dodgeChance then
            dmg:SetDamage(0)
            tr.Entity:EmitSound("weapons/l4d2_kf2_katana/katana_impact_world1.wav")
            tr.Entity:SetVelocity(VectorRand() * math.random(20, 60))
            return
        end

    if self.Primary.DodgeShredding and self.Primary.DodgeShredding > 0 then
            -- Check if the target has the AgilityTemporary stat
            local agilityTemporary = tr.Entity:AgilityTemporary() or 0
            local newAgility = math.max(0, agilityTemporary - self.Primary.DodgeShredding)  -- Deduct DodgeShredding, ensure it doesn't go below 0
            tr.Entity:SetAgilityTemporary(newAgility)  -- Apply the new AgilityTemporary value
        end

        local hitgroup = tr.HitGroup
        local armorValue = 0
        local damageType = self.Primary.DamageType or "bullet"
        local defenseMethodBase = string.gsub(damageType, "^%l", string.upper)

        if hitgroup == HITGROUP_HEAD then
            defenseMethodBase = defenseMethodBase .. "HeadDefenseTemporary"
        elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
            defenseMethodBase = defenseMethodBase .. "ChestDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
            defenseMethodBase = defenseMethodBase .. "ArmsDefenseTemporary"
        elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
            defenseMethodBase = defenseMethodBase .. "LegsDefenseTemporary"
        end

        if tr.Entity[defenseMethodBase] then
            armorValue = tr.Entity[defenseMethodBase](tr.Entity) or 0
            local newArmorValue = math.max(math.Round(armorValue), 0)
            local setDefenseMethod = "Set" .. defenseMethodBase
            if tr.Entity[setDefenseMethod] then
                tr.Entity[setDefenseMethod](tr.Entity, newArmorValue)
            end
            armorValue = newArmorValue
        end

local shreddingValue = self.Primary.Shredding * shreddingMultiplier or 0
local damageType = self.Primary.DamageType or "bullet" -- Default to "bullet"

local function ApplyShredding(entity, defenseType, hitPart, rangeFactor)
    -- Check if the target has 'statusmarkreveal' oddity and double the shredding value if true
    if entity:HasOddity("statusmarkreveal") then
        shreddingValue = shreddingValue * 1.2  -- Double the shredding value if the target has 'statusmarkreveal'
    end

    local defenseMethod = defenseType .. hitPart .. "DefenseTemporary" -- e.g., BluntHeadDefense, SlashChestDefense
    local setDefenseMethod = "Set" .. defenseMethod

    if entity[defenseMethod] and entity[setDefenseMethod] then
        local currentDefense = entity[defenseMethod](entity) or 0
        local adjustedShreddingValue = shreddingValue -- Apply range factor to shredding value

        -- Round up to the next whole number
        adjustedShreddingValue = math.ceil(adjustedShreddingValue)

        -- Prevent negative values
        local newDefense = math.max(currentDefense - adjustedShreddingValue * 2, 0) -- Apply double multiplier
        entity[setDefenseMethod](entity, newDefense)
    end
end


-- Determine hit part based on hitgroup
local hitPart = "" -- Default to an empty string
if hitgroup == HITGROUP_HEAD then
    hitPart = "Head"
elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
    hitPart = "Chest"
elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
    hitPart = "Arms"
elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
    hitPart = "Legs"
end

if hitPart ~= "" then
    -- Apply shredding with range factor, rounded up to the nearest whole number
    ApplyShredding(tr.Entity, "Blunt", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Slash", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Bullet", hitPart, rangeFactor)
    ApplyShredding(tr.Entity, "Heat", hitPart, rangeFactor)
end

        if effectivePenetration >= armorValue then
            if hitgroup == HITGROUP_HEAD then
                effectiveDamage = effectiveDamage * 2
            elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
                effectiveDamage = effectiveDamage * 0.5
            elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
                effectiveDamage = effectiveDamage * 0.5
            end

           local critChance = self.Owner:CriticalChanceTemporary() + self.Primary.CritChance  or 0  -- Expected to return a percentage value (e.g., 25 for 25%)
            local critDamage = self.Owner:CriticalDamageTemporary() + self.Primary.CritDamage or 0  -- Expected to return a percentage bonus



-- Double the crit chance and crit damage
critChance = critChance * 2
critDamage = critDamage * 2

    if tr.Entity:HasOddity("statusmarktarget") then
    critChance = critChance + 50  -- Increase crit chance by 50% if the target has 'statusmarktarget'
end

if math.random(1, 100) <= critChance then
    effectiveDamage = effectiveDamage * (1 + (critDamage * 2 / 100))
    -- Play critical sound
           ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
                ply:EmitSound("npc/ministrider/flechette_flesh_impact1.wav")
end
              local resistance = tr.Entity.Resistance and tr.Entity:Resistance() or 0
            effectiveDamage = effectiveDamage * (1 - (resistance / 100))

    -- Apply final damage


        if math.random(1, 100) <= self.CrippleChance then
    -- Check the hitgroup for the body part
    if tr.Entity:IsPlayer() then
        if tr.HitGroup == HITGROUP_LEFTLEG or tr.HitGroup == HITGROUP_RIGHTLEG then
            -- Check if the player does not already have the "crippledleg" status
            if not tr.Entity:HasOddity("crippledleg") then
                tr.Entity:GiveOddity("crippledleg")  -- Apply the crippled leg effect
               tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        elseif tr.HitGroup == HITGROUP_LEFTARM or tr.HitGroup == HITGROUP_RIGHTARM then
            -- Check if the player does not already have the "crippledarm" status
            if not tr.Entity:HasOddity("crippledarm") then
                tr.Entity:GiveOddity("crippledarm")  -- Apply the crippled arm effect
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
                tr.Entity:EmitSound("player/pl_fallpain1.wav")
            end
        end
    end
end
    tr.Entity:TakeDamage(effectiveDamage, ply, self)

            local shotDirection = (tr.Entity:GetPos() - ply:GetShootPos()):GetNormalized()
            tr.Entity:SetVelocity(shotDirection * (force * 0.5))

         local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("bloodimpact", effectData, true, true)


        else
            dmg:SetDamage(0)
            tr.Entity:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav")
            util.Decal("Impact.Concrete", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

            local originalBloodEffect = tr.Entity.BloodEffect or nil
            tr.Entity.BloodEffect = ""

            local effectData = EffectData()
            effectData:SetOrigin(tr.HitPos)
            effectData:SetNormal(tr.HitNormal)
            effectData:SetEntity(tr.Entity)
            util.Effect("StunstickImpact", effectData, true, true)

            timer.Simple(0, function()
                if IsValid(tr.Entity) then
                    tr.Entity.BloodEffect = originalBloodEffect
                end
            end)
        end
    end

    timer.Simple(0.20, function()
        self.Owner:FireBullets(bulletspecial)
    end)
end

SWEP.Holstered = false;
SWEP.IronMode = IRON_HOLSTERED;
SWEP.IronDir = 1;
SWEP.IronMul = 1;

SWEP.IronNetPos = Vector();
SWEP.IronNetAng = Vector();


function SWEP:CalcIron()
    
    if( !self.Holsterable and self.IronMode < IRON_IDLE ) then
        
        self.IronMode = IRON_IDLE;
        
    end
    
    if( self.HolsterPos and self.AimPos and self.HolsterAng and self.AimAng ) then
        
        if( self.IronMode == IRON_HOLSTERED ) then
            
            self.IronNetPos = self.HolsterPos;
            self.IronNetAng = self.HolsterAng;
            
        elseif( self.IronMode == IRON_HOLSTERED2IDLE ) then
            
            if( self.IronMul == 1 and self.IronDir == 1 ) then -- Going up... and hit idle
                
                self.IronMode = IRON_HOLSTERED;
                
            elseif( self.IronMul == 0 and self.IronDir == -1 ) then -- Going down... and hit holstered
                
                self.IronMode = IRON_IDLE;
                
            else
                
                self.IronMul = math.Clamp( self.IronMul + self.IronDir * GAMEMODE:IronsightsMul(), 0, 1 );
                
                self.IronNetPos = self.IronMul * self.HolsterPos;
                self.IronNetAng = self.IronMul * self.HolsterAng;
                
            end
            
        elseif( self.IronMode == IRON_IDLE ) then
            
            self.IronNetPos = Vector();
            self.IronNetAng = Vector();
            
        elseif( self.IronMode == IRON_IDLE2AIM ) then
            
            if( self.IronMul == 1 and self.IronDir == 1 ) then
                
                self.IronMode = IRON_AIM;
                
            elseif( self.IronMul == 0 and self.IronDir == -1 ) then
                
                self.IronMode = IRON_IDLE;
                
            else
                
                self.IronMul = math.Clamp( self.IronMul + self.IronDir * GAMEMODE:IronsightsMul(), 0, 1 );
                
                self.IronNetPos = self.IronMul * self.AimPos;
                self.IronNetAng = self.IronMul * self.AimAng;
                
            end
            
        elseif( self.IronMode == IRON_AIM ) then
            
            self.IronNetPos = self.AimPos;
            self.IronNetAng = self.AimAng;
            
        end
        
    end
    
end

function SWEP:getTargetBlendPos()
        local pos, ang

        
            pos = self.viewDefault.pos
            ang = self.viewDefault.ang
    
        return pos, ang
    end

function SWEP:GetViewModelPosition( pos, ang )
    
    if( CCP.IronDev ) then
        
        ang:RotateAroundAxis( ang:Up(), GAMEMODE.IronDevAng.y );
        ang:RotateAroundAxis( ang:Right(), GAMEMODE.IronDevAng.x );
        ang:RotateAroundAxis( ang:Forward(), GAMEMODE.IronDevAng.z );

        pos = pos + GAMEMODE.IronDevPos.x * ang:Right();
        pos = pos + GAMEMODE.IronDevPos.y * ang:Up();
        pos = pos + GAMEMODE.IronDevPos.z * ang:Forward();
        
        return pos, ang;
        
    end
    
    local vOriginalOrigin = pos;
    local vOriginalAngles = ang;
    
    self:CalcIron();
    
    ang:RotateAroundAxis( ang:Right(), self.IronNetAng.x );
    ang:RotateAroundAxis( ang:Up(), self.IronNetAng.y );
    ang:RotateAroundAxis( ang:Forward(), self.IronNetAng.z );

    pos = pos + self.IronNetPos.x * ang:Right();
    pos = pos + self.IronNetPos.y * ang:Up();
    pos = pos + self.IronNetPos.z * ang:Forward();
    
    if( !self.m_vecLastFacing ) then
        
        self.m_vecLastFacing = vOriginalOrigin;
        
    end
    
    local forward = vOriginalAngles:Forward();
    local right = vOriginalAngles:Right();
    local up = vOriginalAngles:Up();
    
    local vDifference = self.m_vecLastFacing - forward;
    
    local flSpeed = 7;
    
    local flDiff = vDifference:Length();
    if( flDiff > 1.5 ) then
        
        flSpeed = flSpeed * ( flDiff / 1.5 );
        
    end
    
    vDifference:Normalize();
    
    self.m_vecLastFacing = self.m_vecLastFacing + vDifference * flSpeed * FrameTime();
    self.m_vecLastFacing:Normalize();
    pos = pos + ( vDifference * -1 ) * 5;
    
    return pos - forward * 5, ang;
    
end

function SWEP:FreezeMovement()
    
    if( self.Owner.FreezeTime and CurTime() < self.Owner.FreezeTime ) then
        
        return true;
        
    end
    
    return false;
    
end

SWEP.DevMode = false;
SWEP.ScopeTexture = "models/tnb/trpweapons/aim_red_trans";
SWEP.ScopeTextureTop = "gmod/scope";

function SWEP:PreDrawViewModel( vm, wep, ply )
    
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

function SWEP:InScope()
    
    if( self.Scoped and self.IronMode == IRON_AIM ) then
        
        return true;
        
    end
    
    return false;
    
end

function SWEP:DrawHUD()
    
    if( self:InScope() ) then
        
        local h = ScrH();
        local w = ( 4 / 3 ) * h;
        
        local dw = ( ScrW() - w ) / 2;
        
        surface.SetDrawColor( 0, 0, 0, 255 );
        surface.DrawRect( 0, 0, dw, h );
        surface.DrawRect( w + dw, 0, dw, h );
        
        if( render.GetDXLevel() >= 90 ) then
            
            render.UpdateRefractTexture();
            surface.SetTexture( surface.GetTextureID( self.ScopeTexture ) );
            surface.SetDrawColor( 255, 255, 255, 255 );
            surface.DrawTexturedRect( dw, 0, w, h );
            
        end
        
        surface.SetTexture( surface.GetTextureID( self.ScopeTextureTop ) );
        surface.SetDrawColor( 0, 0, 0, 255 );
        surface.DrawTexturedRect( dw, 0, w, h );
        
        surface.SetDrawColor( 0, 0, 0, 255 );
        
        surface.DrawLine( 0, ScrH() / 2, ScrW(), ScrH() / 2 );
        surface.DrawLine( ScrW() / 2, 0, ScrW() / 2, ScrH() );
        
    end
    
    if( CCP.IronDev ) then
        
        surface.SetDrawColor( 255, 255, 255, 255 );
        surface.DrawLine( 0, ScrH() / 2, ScrW(), ScrH() / 2 );
        surface.DrawLine( ScrW() / 2, 0, ScrW() / 2, ScrH() );
        
    end
    
    if( self.DevMode ) then
        
        draw.DrawTextShadow( self.IronMode, "CombineControl.LabelGiant", ScrW(), 0, Color( 255, 255, 255, 255 ), Color( 0, 0, 0, 255 ), 2 );
        draw.DrawTextShadow( self.IronMul, "CombineControl.LabelGiant", ScrW(), 20, Color( 255, 255, 255, 255 ), Color( 0, 0, 0, 255 ), 2 );
        
    end
    
end

function SWEP:TranslateFOV( fov )
    
    if( self:InScope() ) then
        
        return 20;
        
    end
    
    return fov;
    
end

function SWEP:AdjustMouseSensitivity()
    
    if( self:InScope() ) then
        
        return ( 20 / GetConVarNumber( "fov_desired" ) );
        
    end
    
    return 1;
    
end

function SWEP:DrawWorldModel()
    
    if( self.CSFallback ) then
        
        local hasCS = false;
        
        for _, v in pairs( engine.GetGames() ) do
            
            if( v.depot == 240 and v.mounted ) then
                
                hasCS = true;
                
            end
            
        end
        
        if( !hasCS ) then
            
            local hand = self.Owner:GetAttachment( self.Owner:LookupAttachment( "anim_attachment_rh" ) );
            
            if( hand ) then
                
                self:SetRenderOrigin( hand.Pos );
                self:SetRenderAngles( hand.Ang );
                
            end
            
        end
        
    elseif( self.RepositionToHand ) then
        
        local hand = self.Owner:GetAttachment( self.Owner:LookupAttachment( "anim_attachment_rh" ) );
        
        if( hand ) then
            
            self:SetRenderOrigin( hand.Pos );
            self:SetRenderAngles( hand.Ang );
            
        end
        
    end
    
    self:DrawModel();
    
end

function SWEP:ClipPunchAngleOffset( inang, punch, clip )
    
    local final = inang + punch;
    
    for _, v in pairs( { "p", "y", "r" } ) do
        
        inang[v] = math.Clamp( final[v], -clip[v], clip[v] ) - punch[v];
        
    end
    
    return inang;
    
end

function SWEP:DoMachineGunKick( dampEasy, maxVerticalKickAngle, fireDurationTime, slideLimitTime )
    
    local KICK_MIN_X = 0.2;
    local KICK_MIN_Y = 0.2;
    local KICK_MIN_Z = 0.1;
    
    local duration = math.min( fireDurationTime, slideLimitTime );
    local kickPerc = duration / slideLimitTime;
    
    self.Owner:ViewPunchReset( 10 );
    
    local vecScratch = Angle();
    
    vecScratch.p = -( KICK_MIN_X + ( maxVerticalKickAngle * kickPerc ) );
    vecScratch.y = -( KICK_MIN_Y + ( maxVerticalKickAngle * kickPerc ) ) / 3;
    vecScratch.r = KICK_MIN_Z + ( maxVerticalKickAngle * kickPerc ) / 8;
    
    if( math.random( -1, 1 ) >= 0 ) then
        
        vecScratch.y = vecScratch.y * -1;
        
    end
    
    if( math.random( -1, 1 ) >= 0 ) then
        
        vecScratch.r = vecScratch.r * -1;
        
    end
    
    vecScratch = self:ClipPunchAngleOffset( vecScratch, self.Owner:GetViewPunchAngles(), Angle( 24, 3, 1 ) );
    
    self.Owner:ViewPunch( vecScratch * 2 );
    
end

function SWEP:SendWeaponAnimShared( act )
    --[[
    local vm = self.Owner:GetViewModel();
    vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( ACT_VM_IDLE ) );
    
    timer.Simple( 0, function()
        if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
        
        local vm = self.Owner:GetViewModel();
        vm:SendViewModelMatchingSequence( vm:SelectWeightedSequence( act ) );
    end );
    --]]
    --if( SERVER ) then
        
        self:SendWeaponAnim( act );
        
    --end
    
end