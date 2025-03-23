AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"
SWEP.PrintName = "Ability Overwatch"
SWEP.Slot = 1
SWEP.SlotPos = 21

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true
SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Activate Overwatch and gain the 'statusoverwatch' oddity. Costs 10 Attack and 5 Special."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    local ply = self.Owner

    -- Check if the player has enough Attack and Special
    if ply:Attack() < 10 or ply:Special() < 5 then
        ply:EmitSound("common/wpn_denyselect.wav") -- Sound on failure
        ply:ViewPunch(Angle(-2, 0, 0)) -- Small recoil effect
        return
    end

    -- Only give oddity if player doesn't already have it
    if not ply:HasOddity("statusoverwatch") then
        ply:GiveOddity("statusoverwatch")
        ply:EmitSound("npc/roller/blade_in.wav") -- Sound on success
        self:CheckAndPlayVoice("boost")
        ply:ViewPunch(Angle(3.5, 0, 0)) -- Small recoil effect
        ply:SetAttack(ply:Attack() - 10)  -- Deduct 10 Attack
        ply:SetSpecial(ply:Special() - 5)   -- Deduct 5 Special
    else
        ply:EmitSound("common/wpn_denyselect.wav") -- Sound if already has the oddity
        ply:ViewPunch(Angle(-1, 0, 0)) -- Small recoil effect
    end

    -- Set next primary fire to avoid spamming
    self:SetNextPrimaryFire(CurTime() + 2)
    self:SetNextSecondaryFire(CurTime() + 2)
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack()
end

function SWEP:Reload()
    self:PrimaryAttack()
end
