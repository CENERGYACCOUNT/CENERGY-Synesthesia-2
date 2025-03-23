AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Planter";
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
	

	self:NetworkVar( "Bool", 2, "Planted" );

	self:NetworkVar( "Bool", 0, "Watered" );

	self:NetworkVar( "Bool", 3, "Grown1" );

	self:NetworkVar( "Bool", 4, "Grown2" );

	self:NetworkVar( "Bool", 5, "Grown3" );

	self:NetworkVar( "Bool", 6, "SeedExploctus" );
	self:NetworkVar( "Bool", 7, "SeedSpacecado" );
	self:NetworkVar( "Bool", 8, "SeedSteelgrow" );
	self:NetworkVar( "Bool", 9, "SeedHerbplant" );
	self:NetworkVar( "Bool", 10, "SeedSmokeleaf" );
	self:NetworkVar( "Bool", 11, "SeedRubbershroom" );
	self:NetworkVar( "Bool", 12, "SeedHydrobush" );

	self:NetworkVar( "Int", 0, "Deployer" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );

	self:SetWatered( false );

	self:SetPlanted( true );

	self:SetGrown1( false );

	self:SetGrown2( false );

	self:SetGrown3( false );

	self:SetSeedExploctus( false );
	self:SetSeedSpacecado( false );
	self:SetSeedSteelgrow( false );
	self:SetSeedHerbplant( false );
	self:SetSeedSmokeleaf( false );
	self:SetSeedRubbershroom( false );
	self:SetSeedHydrobush( false );


	self:SetModel( "models/hunter/tubes/tube1x1x3.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	

	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetPlanted() ) then return end
	
 if( self:GetGrown3() ) then

if( !self.NextGrow ) then self.NextGrow = CurTime() end
if( CurTime() >= self.NextGrow ) then
local snd = Sound( "vj_gib/gibbing3.wav" );
self.NextGrow = CurTime() + SoundDuration(snd) + 15
self:SetGrown3( false );
self:SetPlanted( true ); 



 if( self:GetSeedExploctus() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_explofruit" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_explofruit" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_explofruit" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_explofruit" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end

 if( self:GetSeedSpacecado() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_spacecado" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_spacecado" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_spacecado" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_spacecado" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end

 if( self:GetSeedSteelgrow() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_steelgrow" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_steelgrow" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_steelgrow" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_steelgrow" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end

 if( self:GetSeedHerbplant() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_herbplant" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_herbplant" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_herbplant" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_herbplant" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end

 if( self:GetSeedSmokeleaf() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_smokeleaf" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_smokeleaf" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_smokeleaf" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_smokeleaf" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end


 if( self:GetSeedRubbershroom() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_rubbershroom" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_rubbershroom" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_rubbershroom" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_rubbershroom" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end


 if( self:GetSeedHydrobush() ) then
local r = math.random( 1, 2 ); if( r != 1 ) then self:EmitSound( snd );
local fruit = ents.Create( "cc_farming_hydrobush" ); fruit:SetPos( self:GetPos() + Vector( 20, -20, 30 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 );	if( r != 1 ) then	self:EmitSound( snd ); 
local fruit = ents.Create( "cc_farming_hydrobush" ); fruit:SetPos( self:GetPos() + Vector( -20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_hydrobush" ); fruit:SetPos( self:GetPos() + Vector( -20, -20, 40 ) ); fruit:Spawn(); fruit:Activate(); end
local r = math.random( 1, 2 ); if( r != 1 ) then
local fruit = ents.Create( "cc_farming_hydrobush" ); fruit:SetPos( self:GetPos() + Vector( 20, 20, 45 ) ); fruit:Spawn(); fruit:Activate(); end
end

self:SetSeedExploctus( false );
self:SetSeedSpacecado( false );
self:SetSeedSteelgrow( false );
self:SetSeedHerbplant( false );
self:SetSeedSmokeleaf( false );
self:SetSeedRubbershroom( false );
self:SetSeedHydrobush( false );
end	end







  if( self:GetWatered() ) then
		
		if( !self.NextGrow ) then self.NextGrow = CurTime() end
		
		if( CurTime() >= self.NextGrow ) then

			local snd = Sound( "vj_gib/gibbing3.wav" );
					self.NextGrow = CurTime() + SoundDuration(snd) + 14

--(they are reversed for a reason)

if( self:GetGrown2( true)) then
self:SetWatered( false);
self:SetGrown2( false );
self:SetGrown3( true );
end


if( self:GetGrown1( true)) then
self:SetWatered( false);
self:SetGrown1( false );
self:SetGrown2( true );
end

if( self:GetWatered( true)) then

if( self:GetGrown3( true)) then

else
self:SetWatered( false);
self:SetGrown1( true );
end end

	

	self:EmitSound( snd );

		end end

 
	
end

function ENT:Use( ply )
	
	if( self:GetPlanted() ) then return end
	
	if( SERVER ) then
		
	

	end
	
end
