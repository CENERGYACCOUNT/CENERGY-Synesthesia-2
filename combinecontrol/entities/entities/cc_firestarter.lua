AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Fire Starter";
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
	




	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
self:SetMaterial( "null" )
	self:SetModel( "models/props_c17/paper01.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end
		self.KillTime = CurTime() + 5; 

			timer.Simple(3, function()
	   self:Ignite(30)
	end)
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( CurTime() > self.KillTime ) then
		
		self:Remove();
		
	end
	
end


function ENT:Use( ply )
	

end


