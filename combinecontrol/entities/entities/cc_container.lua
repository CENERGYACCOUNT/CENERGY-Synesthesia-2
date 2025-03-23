AddCSLuaFile()

ENT.Base = "cc_base_ent"

function ENT:Initialize()
	self:SetModel("models/acdc/acdc4.mdl")
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		local phys = self:GetPhysicsObject()
		
		if phys and phys:IsValid() then
			phys:EnableMotion(false)
		end
		
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use(ply)
	if not self.id or not GAMEMODE.containers[self.id] then
		net.Start("nCBrokenContainer")
		net.Send(ply)

		GAMEMODE:LogBug("Broken container id: '"..self.id.."', pos: "..tostring(self:GetPos())..", err: No container id!", true)

		self:Remove()

		return
	end

	if self.containerType == nil then
		net.Start("nCBrokenContainer")
		net.Send(ply)

		GAMEMODE:LogBug("Broken container id: '"..self.id.."', pos: "..tostring(self:GetPos())..", err: No container type!", true)

		self:Remove()
		
		return
	elseif self.containerType == CONTAINER_PASSWORD then
		if not self.typeValue then
			net.Start("nCBrokenContainer")
			net.Send(ply)

			GAMEMODE:LogBug("Broken container id: '"..self.id.."', pos: "..tostring(self:GetPos())..", err: No password!", true)

			self:Remove()

			return
		else
			net.Start("nCContainerPassword")
				net.WriteString(self.id)
			net.Send(ply)

			return
		end
	elseif self.containerType == CONTAINER_COMBINE then
		local flag = ply:getFlag() -- Important: Replace this

		if not flag or not flag.isCombine then
			net.Start("nCLockedContainer")
			net.Send(ply)

			return
		end
	elseif self.containerType == CONTAINER_FLAG then
		local flag = ply:getFlag() -- Important: Replace this

		if not flag or not table.HasValue(self.typeValue, flag.Flag) then
			net.Start("nCLockedContainer")
			net.Send(ply)

			return
		end
	elseif self.containerType == CONTAINER_ADMIN then
		if not ply:IsAdmin() then
			net.Start("nCLockedContainer")
			net.Send(ply)

			return
		end
	end

	self:EmitSound("AmmoCrate.Open")

	net.Start("nCOpenContainer")
		net.WriteString(self.id)
	net.Send(ply)
end