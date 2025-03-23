AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Ready Up"
SWEP.Slot = 1
SWEP.SlotPos = 55

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "End your turn!"
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 2)


        self.Owner:SetReadyUp(true)
        self.Owner:EmitSound("borderlands/newu_save.mp3")
        self.Owner:ViewPunch(Angle(2, 0, 0))  -- Small recoil effect
 
end
