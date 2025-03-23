AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Glass";
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
	

	self:NetworkVar( "Bool", 1, "Broken" );






	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
self:SetMaterial( "null" )
	self:SetBroken( false );
	
	self.GlassHealth = 20;
self.NextCheck = CurTime() + 50000
	self:SetModel( "models/props_destruction/glass_fracture_128x128_b.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );	

	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
		
		if( !self.NextCheck ) then self.NextCheck = CurTime() end
		
		if( CurTime() >= self.NextCheck ) then
			
	local snd = Sound( "ambient/energy/zap1.wav" );
		self.NextCheck = CurTime() + SoundDuration(snd) + 50000

		local r = math.random( 1, 2 );
			
			if( r != 1 ) then

					local r = math.random( 1, 2 );
			
			if( r != 1 ) then

					local r = math.random( 1, 2 );
			
			if( r != 1 ) then


self:SetMaterial( "" )
self:SetBroken( true );
self:EmitSound( Sound( "physics/glass/glass_impact_bullet4.wav" ) );
end end end
end end

function ENT:OnTakeDamage( dmginfo )
	
	self:TakePhysicsDamage( dmginfo );
	
	if( self:GetBroken() ) then return end
	
	self.GlassHealth = self.GlassHealth - dmginfo:GetDamage();
	
	if( self.GlassHealth <= 0 ) then
		
self:SetMaterial( "" )
self:SetBroken( true );
self:EmitSound( Sound( "physics/glass/glass_impact_bullet4.wav" ) );
	
	
	end
	
end



