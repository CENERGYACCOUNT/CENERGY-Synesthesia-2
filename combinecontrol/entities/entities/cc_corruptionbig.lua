AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Corruption Big";
ENT.Author			= "Matt";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;


function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	
	self:NetworkVar( "Bool", 0, "StoveOn" );
	self:NetworkVar( "Bool", 1, "Invisible" );
	self:NetworkVar( "Bool", 2, "Broken" );
	self:NetworkVar( "String", 0, "Building" );
	self:NetworkVar( "Int", 0, "Deployer" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
	self:SetStoveOn( false );
	self:SetBroken( false );
	self:SetMaterial ("models/props_xen/c4a1a/xen_interdimensional_track");
	self:SetColor ( Color(30, 30, 30, 255) );
	self:SetModel( "models/props_xen/blob05.mdl" );
		self:PhysicsInit( SOLID_VPHYSICS );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();

end
	
		self:SetStoveOn( !self:GetStoveOn() );
		
		if( ( !self.SteamEnt or !self.SteamEnt:IsValid() ) and self:GetModel() != "models/props_c17/tv_monitor01.mdl" ) then
			
			local pos = self:GetPos();
			if( string.lower( self:GetModel() ) == "models/props_wasteland/kitchen_stove001a.mdl" ) then
				
				pos = self:GetPos() + self:GetRight() * -20 + self:GetUp() * 18;
				
			end
			
			self.SteamEnt = ents.Create( "env_smokestack" );
			self.SteamEnt:SetPos( pos );
			self.SteamEnt:SetKeyValue( "BaseSpread", "1" );
			self.SteamEnt:SetKeyValue( "SpreadSpeed", "20" );
			self.SteamEnt:SetKeyValue( "Speed", "1" );
			self.SteamEnt:SetKeyValue( "StartSize", "1" );
			self.SteamEnt:SetKeyValue( "EndSize", "2" );
			self.SteamEnt:SetKeyValue( "roll", "10");
			self.SteamEnt:SetKeyValue( "Rate", "500" );
			self.SteamEnt:SetKeyValue( "JetLength", "5" );
			self.SteamEnt:SetKeyValue( "twist", "1" );
			self.SteamEnt:SetKeyValue( "SmokeMaterial", "particle/wallworm/ventsmoke" );
	

			self.SteamEnt:Spawn();
			self.SteamEnt:SetParent( self );
			self.SteamEnt:Activate();
			self:DeleteOnRemove( self.SteamEnt );
			
		end
		
		if( self:GetStoveOn() ) then
			
			if( self.SteamEnt and self.SteamEnt:IsValid() ) then
				
				self.SteamEnt:Fire( "TurnOn" );
				
			end
			
			self.ExplodeTime = CurTime() + math.random( 600, 900 );
			self.NextExplodeCheck = nil;
			
		else
			
			if( self.SteamEnt and self.SteamEnt:IsValid() ) then
				
				self.SteamEnt:Fire( "TurnOff" );
				
			end
			
		end
		


end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
	
	if( self:GetStoveOn() ) then
		

if not self.NextStaticSound then self.NextStaticSound = CurTime() end
		if CurTime() >= self.NextStaticSound then

			local snd = Sound( "" .. table.Random( { "	doom3/lostsoul/chatter_01.wav", "doom3/lostsoul/chatter_02.wav", "doom3/lostsoul/chatter_03.wav", "life_sounds/soma/glitch/glitch_low_04.wav", "life_sounds/soma/glitch/glitch_med_2.wav", "life_sounds/soma/glitch/glitch_med_5.wav", "life_sounds/soma/glitch/glitch_high_2.wav", "npc/nihilanth/nihilanth_coldopen01.wav", "npc/nihilanth/nihilanth_comesanother01.wav", "zombies/hord3.mp3" } ) .. "", 100, 100 );
			self.NextStaticSound = CurTime() + SoundDuration(snd) + -1
			self:EmitSound(snd)

		end
		end end



function ENT:OnRemove()
				self:StopSound("xen/healingpool/healingpool_active01.wav")
	end


	function ENT:Touch( hitEnt )
 	if ( hitEnt:IsValid() and hitEnt:IsPlayer() ) then

if not self.NextCorruption then self.NextCorruption = CurTime() end
		if CurTime() >= self.NextCorruption then
 			hitEnt:SetCorruption( math.Clamp( hitEnt:Corruption() + 10, 0, 100 ) );
		hitEnt:UpdateCharacterField( "Corruption", hitEnt:Corruption() );
		self.NextCorruption = CurTime() +1
	end
	end
 end