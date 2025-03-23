AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Decals"

ENT.PrintName		= "Body Bag";
ENT.Author			= "Matt";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;


function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()

	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	self:SetModel( "" .. table.Random( { "models/props_misc/bodybag_01/bodybag_01.mdl" } ) );

	self:PhysicsInit( SOLID_VPHYSICS );
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end

self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end
	
function DontCollide(self)
self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end
