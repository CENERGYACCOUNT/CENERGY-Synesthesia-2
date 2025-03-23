AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Sprint"
SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Gain 10 Movement. Costs 5 Special."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has enough Special (5)
    if self.Owner:Special() >= 5 then
        -- Check if the ability is on cooldown
      

        -- Apply the effect
            if( SERVER ) then
        self.Owner:SetMovement(self.Owner:Movement() + 10)
        self.Owner:SetSpecial(self.Owner:Special() - 5)
end
        -- Play activation sound
        self.Owner:EmitSound("npc/roller/blade_in.wav")

        -- Apply a small recoil effect
        self.Owner:ViewPunch(Angle(2, 0, 0))

        -- Set ability cooldown
        self:SetNextPrimaryFire(CurTime() + 2) -- 5-second cooldown
    else
        -- Not enough Special, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect

        -- Short cooldown before retrying
        self:SetNextPrimaryFire(CurTime() + 2)
    end
end
