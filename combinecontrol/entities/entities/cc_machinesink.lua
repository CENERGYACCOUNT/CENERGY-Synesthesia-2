AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Sink";
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
	

	self:NetworkVar( "Bool", 2, "Broken" );

	self:NetworkVar( "Bool", 3, "Powered" );


end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );

	self:SetBroken( false );

	self:SetPowered( false );


	self:SetModel( "models/hunter/plates/plate05x05.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	

	
end


function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
		
		if( !self.NextCheck ) then self.NextCheck = CurTime() end
		
		if( CurTime() >= self.NextCheck ) then
			
	local snd = Sound( "ambient/energy/zap1.wav" );
					self.NextCheck = CurTime() + SoundDuration(snd) + 5


	self:SetPowered( false);

for _, v in pairs( ents.FindByClass( "cc_machineastrophobicngenerator" ) ) do


						local dist = 15000;
					
						if( self:GetPos():Distance( v:GetPos() ) < dist ) then
if( v:GetFuel0( true)) then else

	self:SetPowered( true); end
end  end 
 





end end


function ENT:Use( ply )
	
	
	
	
end
