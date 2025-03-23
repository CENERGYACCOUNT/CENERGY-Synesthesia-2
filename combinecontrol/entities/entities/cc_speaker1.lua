AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Dynamic Sound - Aliens";
ENT.Author			= "Matt";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

ENT.Base = "cc_base_ent"

function ENT:PostEntityPaste(ply, ent, tab)
	GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate "..ent:GetClass().."!")
	ent:Remove()
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "TVOn")
	self:NetworkVar("Bool", 1, "Static")
	self:NetworkVar("Bool", 2, "Broken")
	self:NetworkVar("Int", 0, "Deployer")
end

function ENT:Initialize()
	if CLIENT then return end
	
	self:SetUseType(SIMPLE_USE)
	
	self.TVHealth = 20
	
	self:SetTVOn(true)
	self:SetBroken(false)
	
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)

	local micsamplers = ents.FindByName("cc_micsamplepoint")
	
	if #micsamplers == 0 then
		self:SetStatic(true)
	end
	

	local phys = self:GetPhysicsObject()
	
	if phys and phys:IsValid() then
		phys:Wake()
	end
end



function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
	
	if self:GetBroken() then return end
	
	self.TVHealth = self.TVHealth - dmginfo:GetDamage()
	
	if self.TVHealth <= 0 then
		self:SetBroken(true)
		self:SetTVOn(false)
	
		
		if self.Speaker and self.Speaker:IsValid() then
			self.Speaker:Remove()
		end
	end
end

function ENT:Think()
	if CLIENT then return end
	
	if self:GetBroken() then return end
	
	if self:GetTVOn() and self:GetStatic() then
		if not self.NextStaticSound then self.NextStaticSound = CurTime() end
		if CurTime() >= self.NextStaticSound then
			local snd = Sound( "" .. table.Random( { "xen/soundscape/boid_xen_medium01.wav", "xen/soundscape/boid_xen_medium12.wav", "xen/soundscape/boid_xen_medium10.wav"
			

		 } ) .. "", 15000, 10000 );
			self.NextStaticSound = CurTime() + SoundDuration(snd) + 3
			self:EmitSound(snd)
		end
	end
end

function ENT:Use(ply)
	if self:GetBroken() then return end
	
	if SERVER then
		self:EmitSound(Sound("buttons/lightswitch2.wav"))
		
		self:SetTVOn(not self:GetTVOn())
		
	
		
		if not self:GetTVOn() then
			for i = 1, 15 do
				self:StopSound("ambient/levels/prison/radio_random"..math.random(1, 15)..".wav")
			end
		end
	end
end


function ENT:Draw()
	self:DrawModel()
	
	if self:GetBroken() then return end
	end
		

function ENT:CanPhysgun()
	return true
end