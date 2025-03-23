AddCSLuaFile()

ENT.Base = "cc_grenade_frag"
ENT.Type = "anim"

ENT.PrintName = ""
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:PostEntityPaste(ply, ent, tab)
    GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!")
    ent:Remove()
end

function ENT:Explode(tr)
    if tr.Fraction ~= 1.0 then
        self:SetPos(tr.HitPos + tr.Normal * 0.6)
    end

    net.Start("nFlashbang")
        net.WriteVector(self:GetPos())
    net.Broadcast()

    if SERVER then
        for _, ply in ipairs(player.GetAll()) do
            if ply:GetPos():Distance(self:GetPos()) < 650 and not (ply:HasOddity("statusflashed") or ply:HasOddity("statusflashed2")) then
                local trace = util.TraceLine({
                    start = self:GetPos(),
                    endpos = ply:EyePos(),
                    filter = {self, ply}, 
                    mask = MASK_OPAQUE 
                })

                if not trace.Hit then
                    ply:GiveOddity("statusflashed")
                end
            end
        end
    end

    self:Remove()
end

if CLIENT then
    local function nFlashbang(len)
        local vec = net.ReadVector()
        local tvec = vec:ToScreen()
        local d = DynamicLight(1)

        if d then
            d.Pos = vec
            d.r = 255
            d.g = 255
            d.b = 255
            d.Brightness = 20
            d.Size = 256
            d.Decay = 4096
            d.DieTime = CurTime() + 0.3
            d.Style = 0
        end

        if tvec.visible and vec:Distance(LocalPlayer():EyePos()) < 650 then
            GAMEMODE.FlashbangStart = CurTime()
            if vec:Distance(LocalPlayer():GetPos()) < 512 then
                LocalPlayer():SetDSP(math.random(35, 37))
            end
        end
    end
    net.Receive("nFlashbang", nFlashbang)
end
