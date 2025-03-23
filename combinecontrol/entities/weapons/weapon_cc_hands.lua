AddCSLuaFile();

SWEP.Base			= "weapon_cc_base";

SWEP.PrintName 		= "Your Hands";
SWEP.Slot 			= 2;
SWEP.SlotPos 		= 100;

SWEP.UseHands		= true;
SWEP.ViewModel 		= "models/weapons/c_arms_apex.mdl";
SWEP.WorldModel 	= "";

SWEP.HoldType = "fist";
SWEP.HoldTypeHolster = "normal";

SWEP.DrawAnim = "fists_draw";
SWEP.HolsterAnim = "fists_holster";

SWEP.Holsterable = true;
SWEP.HolsterUseAnim = true;

SWEP.HolsterPos = Vector();
SWEP.HolsterAng = Vector();

SWEP.AimPos = Vector( -2.93, 2.81, -4.24 );
SWEP.AimAng = Vector( -0.81, 0, 0 );

SWEP.SecondaryBlock = true;
SWEP.BlockMul = 0.5;
SWEP.CanSprint = true;

SWEP.InfoText = [[Brand - Your Mother
Weapon Type - Fists
Light Attack - 2.5 Attack Points
]];

SWEP.UnholsterText = "";

SWEP.AttackAnims = { 
	{ "fists_left", Angle( 0, -10, 0 ) },
	{ "fists_right", Angle( 0, 10, 0 ) },
	{ "fists_uppercut", Angle( -7, 2, 0 ) } };
	
SWEP.HitSounds = {
	"npc/vort/foot_hit.wav",
	"weapons/crossbow/hitbod1.wav",
	"weapons/crossbow/hitbod2.wav"
}

SWEP.SwingSounds = {
	"npc/vort/claw_swing1.wav",
	"npc/vort/claw_swing2.wav"
}

function SWEP:Initialize()
	
	self:SetWeaponHoldType( self.HoldType );
	self:SetWeaponHoldTypeHolster( self.HoldTypeHolster );
	
	if( !GAMEMODE.DoorRammingEnabled ) then
		
		self.InfoText = [[Holstered - Primary: Knock on doors.
Holstered - Secondary: Nothing.
Unholstered - Primary: Punch.
Unholstered - Secondary: Block.]];
		
	end
	
end

function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      
      
   end
   
end

function SWEP:Precache()
	
	util.PrecacheSound( "physics/wood/wood_crate_impact_hard2.wav" );
	
	util.PrecacheSound( "doors/door_latch3.wav" );
	util.PrecacheSound( "doors/door_locked2.wav" );
	
	for _, v in pairs( self.HitSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
	for _, v in pairs( self.SwingSounds ) do
		
		util.PrecacheSound( v );
		
	end
	
end

function SWEP:IdleNow()
	
	local vm = self.Owner:GetViewModel();
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) );
	
end

function SWEP:PreDrawViewModel( vm, wep, ply )

	vm:SetMaterial( "engine/occlusionproxy" ) -- Hide that view model with hacky material

end


function SWEP:PrimaryHolstered()
	
	local tr = GAMEMODE:GetHandTrace( self.Owner );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() ) then

			timer.Simple( 0.2, function()
		self:PlaySound( "physics/wood/wood_crate_impact_hard2.wav", 70, math.random( 95, 105 ) );
		end)

timer.Simple( 0.6, function()
		self:PlaySound( "physics/wood/wood_crate_impact_hard2.wav", 70, math.random( 95, 105 ) );
		end)

timer.Simple( 1, function()
		self:PlaySound( "physics/wood/wood_crate_impact_hard2.wav", 70, math.random( 95, 105 ) );
		end)

	self.Owner:PlayVCD( "barney_knock" );
	self.Owner:SetSequence( self.Owner:LookupSequence( "barney_knock" ) );
	GAMEMODE:FreezePlayer( self.Owner, 1.9 );
		self:SetNextPrimaryFire( CurTime() + 1.9 );
		
	end
	
end

function SWEP:PrimaryUnholstered()
	
	if( self.Owner:KeyDown( IN_ATTACK2 ) ) then return end

	self:SetNextPrimaryFire( CurTime() + 0.6 );
	self:SetNextSecondaryFire( CurTime() + 0.6 );
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	self:PlaySound( table.Random( self.SwingSounds ), 74, math.random( 90, 110 ) );
	

	local vm = self.Owner:GetViewModel();
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_01" ) );
	
	local anim = table.Random( self.AttackAnims );
	
	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( anim[1] ) );
		
		self:Idle();
	end )
	
	timer.Simple( 0.1, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self.Owner:ViewPunch( anim[2] );
	end )
	
	timer.Simple( 0.15, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		self:FistDamage();
	end )
	
end

function SWEP:FistDamage()
	
	if( CLIENT ) then return end
	
	self.Owner:LagCompensation( true );
	
	local trace = { };
	trace.start = self.Owner:GetShootPos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 50;
	trace.filter = self.Owner;
	trace.mins = Vector( -8, -8, -8 );
	trace.maxs = Vector( 8, 8, 8 );
	
	local tr = util.TraceHull( trace );
	
	if( tr.Hit ) then
		
		self:PlaySound( table.Random( self.HitSounds ), 74, math.random( 90, 110 ) );
		
		if( tr.Entity and tr.Entity:IsValid() ) then
		
			
		
			
			local blockmul = 1;
			
			if( tr.Entity:IsPlayer() ) then
				
				if( tr.Entity:GetActiveWeapon() and tr.Entity:GetActiveWeapon():IsValid() ) then
					
					if( tr.Entity:GetActiveWeapon().IsBlocking and tr.Entity:GetActiveWeapon():IsBlocking() ) then
						
						blockmul = tr.Entity:GetActiveWeapon().BlockMul;
						
					end
					
				end
				
			end
			
			if( GAMEMODE.FistsHaveEffectOnPlayers ) then
				
				if( tr.Entity:IsPlayer() ) then
					




			local dmg = DamageInfo();
			dmg:SetAttacker( self.Owner );
			dmg:SetDamage( math.Round( ( ( self.Owner:MuscleTemporary() + 5) / 25 ) * ( 2 ) ) );		
			dmg:SetDamageForce( Vector( 0, 0, 1 ) );
			dmg:SetDamagePosition( tr.Entity:GetPos() );
			dmg:SetDamageType( DMG_CLUB );
			dmg:SetInflictor( self );
			
			tr.Entity:TakeDamageInfo( dmg );
			
		end
		
	end end
	
	self.Owner:LagCompensation( false );
	
end end

function SWEP:Reload()
	
	
	if( !self.NextReload ) then self.NextReload = CurTime() end
	
	if( CurTime() < self.NextReload ) then return end
	
	local tr = GAMEMODE:GetHandTrace( self.Owner, 128 );
	tr.Normal.z = 0;
	
	if( self.Owner:PassedOut() ) then return end
	if( self.Owner:TiedUp() ) then return end
	if( self.Owner:MountedGun() and self.Owner:MountedGun():IsValid() ) then return end
	if( self.Owner:Crouching() ) then return end
	if( !self.Owner:OnGround() ) then return end
	if( self.Owner:GetVelocity():Length() > 50 ) then return end
	
	if( tr.Entity and tr.Entity:IsValid() and ( tr.Entity:GetClass() == "prop_door_rotating" or ( tr.Entity:GetClass() == "func_door_rotating" and tr.Entity:DoorType() != DOOR_COMBINEOPEN ) ) and tr.Fraction > 0.2 ) then
		
		if( self.Owner:StatTotal("MuscleTemporary") < 40 and !GAMEMODE:LookupCombineFlag( self.Owner:ActiveFlag() ) ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're not strong enough to ram this door!", { CB_ALL, CB_IC } );
				
			end
			
			self.NextReload = CurTime() + 2;
			return;
			
		end
		
		if( SERVER ) then
			
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			
			self.NextReload = CurTime() + 2;
	
			if( self.Owner:Health() > 40 ) then
				
				self.Owner:TakeDamage( 1, tr.Entity, tr.Entity );
				net.Start( "nFlashRed" );
				net.Send( self.Owner );
				
			end
			
			self.Owner:SetVelocity( tr.Normal * 1000 );
			self.Owner:ViewPunch( Angle( -25, 0, 0 ) );
			
			tr.Entity:EmitSound( "physics/wood/wood_crate_impact_hard" .. table.Random( { "1", "4", "5" } ) .. ".wav" );
			
			local n = math.ceil( 10 - ( self.Owner:StatTotal("MuscleTemporary") * 0.08 ) );
			
			if( !tr.Entity:GetSaveTable().m_bLocked ) then
				
				n = math.ceil( 2 - ( self.Owner:StatTotal("MuscleTemporary") * 0.01 ) );
				
			end
			
			if( math.random( 1, n ) == 1 ) then
				
				tr.Entity:EmitSound( "physics/wood/wood_crate_Corruption" .. math.random( 1, 5 ) .. ".wav" );
				
				tr.Entity:Fire( "Unlock" );
				
				timer.Simple( 0, function()
					
					if( tr.Entity and tr.Entity:IsValid() and self and self:IsValid() and self.Owner and self.Owner:IsValid() ) then
						
						tr.Entity:Input( "Use", self.Owner, self );
						
					end
					
				end );
				
			end
			
		end
		
	end
	
end

function SWEP:SecondaryUnholstered()
	
	
	
end

function SWEP:HolsterChild()
	
	self:OnRemove();
	
end

function SWEP:OnRemove()
	
	if( self.Owner and self.Owner:IsValid() ) then
		
		local vm = self.Owner:GetViewModel();
		
		if( vm and vm:IsValid() ) then
			
			vm:SetMaterial( "" );
			
		end
		
	end
	
	timer.Stop( "cc_weapon_idle" .. self:EntIndex() );

end

function SWEP:onCanCarry(entity)

if( entity:GetClass() == "cc_cleanblood" ) then
		return false
	end

	if( entity:GetClass() == "cc_cleanfilth" ) then
		return false
	end


	local physicsObject = entity:GetPhysicsObject()

	if (!IsValid(physicsObject)) then
		return false
	end

if( entity:GetClass() == "cc_cleanbag" ) then

else

	if (physicsObject:GetMass() > 115 or !physicsObject:IsMoveable()) then
		return false
	end
end


	if (IsValid(entity.carrier) or IsValid(self.heldEntity)) then
		return false
	end

	return true
end

function SWEP:doPickup(entity)
	if (entity:IsPlayerHolding()) then
		return
	end

	self.heldEntity = entity

	timer.Simple(0.2, function()
		if (!IsValid(entity) or entity:IsPlayerHolding() or self.heldEntity != entity) then
			self.heldEntity = nil

			return
		end

		self.Owner:PickupObject(entity)
		self.Owner:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 3)..".wav", 75)
	end)

	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:SecondaryHolstered()
	
	if (!IsFirstTimePredicted()) then
		return
	end

	local data = {}
	data.start = self.Owner:GetShootPos()
	data.endpos = data.start + self.Owner:GetAimVector() * 84
	data.filter = {self, self.Owner}
		
	local trace = util.TraceLine(data)
	local entity = trace.Entity
	
	if (SERVER and IsValid(entity)) then
		if (!entity:IsPlayer() and !entity:IsNPC() and self:onCanCarry(entity)) then
			local physObj = entity:GetPhysicsObject()
			physObj:Wake()

			self:doPickup(entity)
		elseif (IsValid(self.heldEntity) and !self.heldEntity:IsPlayerHolding()) then
			self.heldEntity = nil
	end
	end
end
