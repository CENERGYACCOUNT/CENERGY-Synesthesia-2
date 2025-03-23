AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Astrophobic Fuel Generator";
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
	

	self:NetworkVar( "Bool", 20, "Broken" );

	self:NetworkVar( "Bool", 0, "Fuel0" );

	self:NetworkVar( "Bool", 1, "Fuel1" );

	self:NetworkVar( "Bool", 2, "Fuel2" );

	self:NetworkVar( "Bool", 3, "Fuel3" );

	self:NetworkVar( "Bool", 4, "Fuel4" );

	self:NetworkVar( "Bool", 5, "Fuel5" );

	self:NetworkVar( "Bool", 6, "Fuel6" );

	self:NetworkVar( "Bool", 7, "Fuel7" );

	self:NetworkVar( "Bool", 8, "Fuel8" );

	self:NetworkVar( "Bool", 9, "Fuel9" );

	self:NetworkVar( "Bool", 10, "Fuel10" );


	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );

	self:SetBroken( false );

	self:SetFuel0( false);

	self:SetFuel1( false );

	self:SetFuel2( false );

	self:SetFuel3( false );

	self:SetFuel4( false );

	self:SetFuel5( false );

	self:SetFuel6( false );

	self:SetFuel7( false );

	self:SetFuel8( false );

	self:SetFuel9( false );

	self:SetFuel10( true );

	self:SetModel( "models/props_furniture/scifi_bactatank.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	

end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
		
		if( !self.NextUsage ) then self.NextUsage = CurTime() end
		
		if( CurTime() >= self.NextUsage ) then
			
	local snd = Sound( "bms_objects/portal/portal_in_01.wav" );
					self.NextUsage = CurTime() + SoundDuration(snd) + 50
if ( math.random(1, 2000) == 2 ) then
	self:SetBroken( true);
end
			if( self:GetFuel0( true)) then	
			else	
	self:EmitSound( snd );
end


if( self:GetFuel10( true)) then
self:SetFuel10( false);
self:SetFuel9( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel9( true)) then
self:SetFuel9( false);
self:SetFuel8( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel8( true)) then
self:SetFuel8( false);
self:SetFuel7( true);
return end   

if( self:GetFuel7( true)) then
self:SetFuel7( false);
self:SetFuel5( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel6( true)) then
self:SetFuel6( false);
self:SetFuel5( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel5( true)) then
self:SetFuel5( false);
self:SetFuel4( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel4( true)) then
self:SetFuel4( false);
self:SetFuel3( true);
self:SetSkin( 1 )
return end   

if( self:GetFuel3( true)) then
self:SetFuel3( false);
self:SetFuel2( true);
self:SetSkin( 1 )
return end   
	

if( self:GetFuel2( true)) then
self:SetFuel2( false);
self:SetFuel1( true);
self:SetSkin( 1 )
return end   


if( self:GetFuel1( true)) then
self:SetFuel1( false);
self:SetFuel0( true);	
self:SetSkin( 0 )
return end   

end end

