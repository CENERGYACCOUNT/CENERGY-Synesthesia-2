AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Corpse Disposal";
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
	
	self:SetStoveOn( true );
	self:SetBroken( false );
	
	self:SetModel( "models/props_blackmesa/metalcrate01_static.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
	
	if( self:GetStoveOn() ) then
		
		local omin = self:OBBMins();
		local omax = self:OBBMaxs();
		
		omin.z = 10;
		omax.z = 10;
		
		local min, max = self:GetRotatedAABB( omin, omax );
		
		if( self:GetModel() == "models/props_blackmesa/metalcrate01_static.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -5, 5, 5 ), Vector( 5, 5, 5 ) );
			
		end
		
		if( self:GetModel() == "models/props_c17/tv_monitor01.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -20, -20, -8 ), Vector( 20, 20, 32 ) );
			
		end
		
		local enttab = ents.FindInBox( self:GetPos() + min, self:GetPos() + max );
		
		local bleach = nil;
		local drugbreen = nil;
		local smallmedkit = nil;
		local water = nil;
		local vodka = nil;
		
		local items = { };
		
		for _, v in pairs( enttab ) do
			
			if( v:GetClass() == "cc_cleanbag" ) then
				
					self:EmitSound( Sound( "physics/metal/metal_solid_strain4.wav" ) );


						v:Remove();
					
		end
			
		end
		

 end end