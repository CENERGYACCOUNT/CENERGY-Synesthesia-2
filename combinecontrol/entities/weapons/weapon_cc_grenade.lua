AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Apexi Frag Grenade";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 59;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_grenade.mdl";
SWEP.WorldModel 	= "models/vj_htunsc/hrweapons/grenade_launched.mdl";

SWEP.HoldType = "grenade";
SWEP.HoldTypeHolster = "normal";

SWEP.Holsterable = true;

SWEP.HolsterPos = Vector( -0, -12.94, 0 );
SWEP.HolsterAng = Vector( 0, 0, 0 );

SWEP.AimPos = Vector();
SWEP.AimAng = Vector();

SWEP.Itemize = true;
SWEP.ItemDescription = "A fragmentation grenade. A favorite of the Apexi Death Squad attack dogs.";
SWEP.ItemWeight = 2;
SWEP.ItemFOV = 8;
SWEP.ItemCamPos = Vector( 50, 50, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 4.65 );

SWEP.GrenadeClass = "cc_grenade_frag";


function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      
      
   end
   
end

function SWEP:DeployChild()
	self.Redraw = false;
end

function SWEP:Holster()
	if self.NoHolster then return false end
	self.Redraw = false;
	timer.Stop("cc_weapon_idle" .. self:EntIndex());
	self:HolsterChild();
	return true;
end

function SWEP:PrimaryUnholstered()
    if self.Redraw or self.NoHolster then return end
    
    -- Check if the player has the 'abilityquickthrow' oddity
    local specialCost = 10

    if self.Owner:HasOddity("abilityquickthrow") then
        -- If the player has 'abilityquickthrow'
        if self.Owner:HasOddity("cooldownquickthrow") then
            -- If the cooldown is active, apply the Special cost
            if self.Owner:Special() < specialCost then
                self.Owner:EmitSound("common/wpn_denyselect.wav")
                return
            end
            self.Owner:SetSpecial(self.Owner:Special() - specialCost)
        end
        -- If there is no cooldown, allow throw with no Special cost
    else
        -- If they don't have the 'abilityquickthrow' oddity, use the normal Special cost
        if self.Owner:Special() < specialCost then
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            return
        end     if SERVER then 
        self.Owner:SetSpecial(self.Owner:Special() - specialCost) end
    end
    
    self.NoHolster = true
    self.Thrown = false
    self:SendWeaponAnimShared(ACT_VM_PULLBACK_HIGH)
    self.NextAct = CurTime() + self.Weapon:SequenceDuration()
    self:SetNextPrimaryFire(CurTime() + math.huge)

    if SERVER then
        -- After the throw, apply the cooldown only if the player doesn't already have it
        if self.Owner:HasOddity("abilityquickthrow") and not self.Owner:HasOddity("cooldownquickthrow") then
            self.Owner:GiveOddity("cooldownquickthrow")  -- 10 seconds cooldown for quick throw
        end
    end
end

function SWEP:SecondaryUnholstered()
    if self.Redraw or self.NoHolster then return end

    -- Check if the player has the 'abilityquickthrow' oddity
    local specialCost = 10
    if self.Owner:HasOddity("abilityquickthrow") then
        -- If the player has 'abilityquickthrow'
        if self.Owner:HasOddity("cooldownquickthrow") then
            -- If the cooldown is active, apply the Special cost
            if self.Owner:Special() < specialCost then
                self.Owner:EmitSound("common/wpn_denyselect.wav")
                return
            end
            self.Owner:SetSpecial(self.Owner:Special() - specialCost)
        end
        -- If there is no cooldown, allow throw with no Special cost
    else
        -- If they don't have the 'abilityquickthrow' oddity, use the normal Special cost
        if self.Owner:Special() < specialCost then
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            return
        end


           
            if SERVER then
        self.Owner:SetSpecial(self.Owner:Special() - specialCost) end
    end
   
    self.NoHolster = true
    self.Thrown = false
    self.AttackLow = true
    self:SendWeaponAnimShared(ACT_VM_PULLBACK_LOW)
    self.NextAct = CurTime() + self.Weapon:SequenceDuration()
    self:SetNextSecondaryFire(CurTime() + math.huge)


    if SERVER then
        -- After the throw, apply the cooldown only if the player doesn't already have it
        if self.Owner:HasOddity("abilityquickthrow") and not self.Owner:HasOddity("cooldownquickthrow") then
            self.Owner:GiveOddity("cooldownquickthrow")  -- 10 seconds cooldown for quick throw
        end
    end
end


function SWEP:DoReload()
	if self.Redraw and self:GetNextPrimaryFire() <= CurTime() and self:GetNextSecondaryFire() <= CurTime() then
		self:SendWeaponAnimShared(ACT_VM_DRAW);
		self:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration());
		self:SetNextSecondaryFire(CurTime() + self.Weapon:SequenceDuration());
		self.AttackLow = false;
		self.NoHolster = false;

		self.Thrown = false;
		self.Redraw = false;
	end
end

function SWEP:CheckThrowPosition(eye, src)
	local trace = {};
	trace.start = eye;
	trace.endpos = src;
	trace.mins = Vector(-4, -4, -4);
	trace.maxs = Vector(4, 4, 4);
	trace.filter = self.Owner;
	local tr = util.TraceHull(trace);
	if tr.Hit then return tr.HitPos end
	return src;
end

function SWEP:Throw()
	if CLIENT then return end
	
	
	self:HandleThrow(1000);
end

function SWEP:Lob()
	if CLIENT then return end


	self:HandleThrow(550, Vector(0, 0, 50));
end

function SWEP:Roll()
	if CLIENT then return end
	
	
	local vecSrc = self.Owner:GetPos() + Vector(0, 0, 4);
	local vecFacing = self.Owner:GetAimVector();
	vecFacing.z = 0;
	vecFacing:Normalize();
	
	local trace = { };
	trace.start = vecSrc;
	trace.endpos = vecSrc + Vector(0, 0, -16);
	trace.filter = self.Owner;
	
	local tr = util.TraceLine(trace);
	if tr.Fraction ~= 1.0 then
		local tangent = vecFacing:Cross(tr.Normal);
		vecFacing = tr.Normal:Cross(tangent);
	end
	
	vecSrc = vecSrc + vecFacing * 18;
	vecSrc = self:CheckThrowPosition(self.Owner:GetPos() + Vector(0, 0, 32), vecSrc);
	
	local vecThrow = self.Owner:GetVelocity();
	vecThrow = vecThrow + vecFacing * 700 
	local orientation = Angle(0, self.Owner:GetAngles().y, -90);
	
	self:SpawnGrenade(vecSrc, vecThrow, orientation, Vector(0, 0, 720));
	self:EmitSound("WeaponFrag.Roll");
	self.Owner:SetAnimation(PLAYER_ATTACK1);
end

function SWEP:HandleThrow(force, extraVec)
	local vecEye = self.Owner:EyePos();
	local vForward = self.Owner:GetForward();
	local vRight = self.Owner:GetRight();
	local vecSrc = vecEye + vForward * 18 + vRight * 8;
	vecSrc = self:CheckThrowPosition(vecEye, vecSrc);
	vForward.z = vForward.z + 0.1;
	
	local vecThrow = self.Owner:GetVelocity();
	vecThrow = vecThrow + vForward * force
	if extraVec then
		vecThrow = vecThrow + extraVec;
	end
	
	self:SpawnGrenade(vecSrc, vecThrow, Angle(), Vector(600, math.random(-1200, 1200), 0));
	self:EmitSound("WeaponFrag.Throw");
	self:SetAnimation(PLAYER_ATTACK1);
end

function SWEP:SpawnGrenade(pos, velocity, angles, angularVelocity)
	local grenade = ents.Create(self.GrenadeClass);
	if not IsValid(grenade) then return end
	
	grenade:SetPos(pos);
	grenade:SetAngles(angles);
	grenade:SetVelocity(velocity);
	grenade:Spawn();
	grenade:Activate();
	grenade:SetTimer(3);
	grenade.Thrower = self.Owner;
	
	local phys = grenade:GetPhysicsObject();
	if IsValid(phys) then
		phys:SetVelocity(velocity);
		phys:AddAngleVelocity(angularVelocity);
	end
	
	-- Deduct 5 Special and remove the item

	
	self.Redraw = true;
end

function SWEP:ThinkChild()
	if self.NextAct and CurTime() >= self.NextAct and not self.Thrown then
		if self.AttackLow then
			if self.Owner:Crouching() then
				self:SendWeaponAnimShared(ACT_VM_SECONDARYATTACK);
			else
				self:SendWeaponAnimShared(ACT_VM_HAULBACK);
			end
		else
			self:SendWeaponAnimShared(ACT_VM_THROW);
		end
		self.NextAct = CurTime() + self:SequenceDuration() - 0.2;
		self.Thrown = true;
	end

	if self.Redraw then self:DoReload() end

	if self.NextAct and CurTime() >= self.NextAct and self.Thrown then
		self.NextAct = nil;
		if self.AttackLow then
			if self.Owner:Crouching() then self:Roll() else self:Lob() end
		else
			self:Throw();
		end
		self:SetNextPrimaryFire(CurTime() + 0.5);
		self:SetNextSecondaryFire(CurTime() + 0.5);

					self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
	end


	self:NextThink(CurTime());
end
