AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Stability"
SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Gain the oddity 'statusstable' and lose 5 Special."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has enough Energy (1)
    if self.Owner:Special() > 5 - 0.1 then
        -- Check if the ability is on cooldown
        if self:GetNextPrimaryFire() > CurTime() then return end

        -- Check if the player already has "statusstable"
        if self.Owner:HasOddity("statusstable") then
            self.Owner:EmitSound("common/wpn_denyselect.wav") -- Deny sound
            self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect
            self:SetNextPrimaryFire(CurTime() + 2) -- Short cooldown
            return
        end

        -- Check if player has at least 5 Special
        if self.Owner:Special() >= 5 then
            -- Apply effect
            self.Owner:GiveOddity("statusstable") -- Grant Stability oddity
            self.Owner:SetSpecial(self.Owner:Special() - 5) -- Remove 5 Special
   

            -- Play activation sound
            self.Owner:EmitSound("npc/roller/blade_in.wav")

            -- Small recoil effect
            self.Owner:ViewPunch(Angle(2, 0, 0))
        else
            -- Not enough Special, play deny sound
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect
        end

        -- Set ability cooldown
        self:SetNextPrimaryFire(CurTime() + 2) -- 2-second cooldown
    else
        -- Not enough Energy, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect

        -- Short cooldown before retrying
        self:SetNextPrimaryFire(CurTime() + 2)
    end
end
