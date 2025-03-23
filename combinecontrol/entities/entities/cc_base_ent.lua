-- base entity used by containers, can easily be applied to other entities as well

AddCSLuaFile()

ENT.Base 					= "base_anim"
ENT.Type 					= "anim"

ENT.PrintName 				= ""
ENT.Author 					= ""
ENT.Contact					= ""
ENT.Purpose					= ""
ENT.Instructions			= ""

ENT.Spawnable 				= false
ENT.AdminSpawnable			= false

ENT.AutomaticFrameAdvance	= true

function ENT:PostEntityPaste(ply, ent, tab)
	GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate "..ent:GetClass().."!")
	ent:Remove()
end

function ENT:CanPhysgun()
	return false
end