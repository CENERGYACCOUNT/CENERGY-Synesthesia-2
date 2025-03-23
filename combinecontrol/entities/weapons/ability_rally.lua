AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Rally"
SWEP.Slot = 1
SWEP.SlotPos = 5

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Removes the 'downed' status from a single ally you are looking at. Costs 10 Special."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 2)

    if self.Owner:Special() < 10 then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
        return
    end

    local range = 250  -- Max range for ability
    local tr = self.Owner:GetEyeTrace()

    if not tr.Hit or not IsValid(tr.Entity) or not tr.Entity:IsPlayer() then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
        return
    end

    local target = tr.Entity

    -- Ensure the target is within the valid range
    if self.Owner:GetPos():Distance(target:GetPos()) > range then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))
        return
    end

    -- Ensure target is downed and is an ally
    if target:Downed() and ((self.Owner:GoodGuy() and target:GoodGuy()) or (self.Owner:BadGuy() and target:BadGuy())) then
        target:SetDowned(false)
        target:SetTiedUp(false)
        self.Owner:SetSpecial(self.Owner:Special() - 10)
        self.Owner:EmitSound("npc/roller/blade_in.wav")
        self.Owner:ViewPunch(Angle(2, 0, 0))  -- Small recoil effect
    else
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))
    end
end
