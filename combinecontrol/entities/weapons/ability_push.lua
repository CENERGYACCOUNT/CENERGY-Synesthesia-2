AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Push"
SWEP.Slot = 1
SWEP.SlotPos = 32

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Pushes away an enemy you are looking at. Costs 10 Special."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 2)
    
    if SERVER then
        -- Check if player has enough Special
        if self.Owner:Special() < 4.9 then
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
            return
        end

        local range = 75  -- Range for checking enemies
        local trace = self.Owner:GetEyeTrace()  -- Get the trace for where the player is looking

        -- Check if the trace hit something and the target is a player within range
        if trace.Hit and trace.Entity:IsPlayer() and not trace.Entity:Downed() then
            local target = trace.Entity
            local distance = self.Owner:GetPos():Distance(target:GetPos())  -- Check the distance to the target

            if distance <= range then  -- Only push if within range
                -- Apply a force to push the enemy away
                local pushDirection = (target:GetPos() - self.Owner:GetPos()):GetNormalized()  -- Direction away from the player
                target:SetVelocity(pushDirection * 500)  -- Push force (adjust the strength as needed)

                self.Owner:SetSpecial(self.Owner:Special() - 5) 
                self.Owner:EmitSound("npc/roller/blade_in.wav")
                self.Owner:ViewPunch(Angle(2, 0, 0))  -- Small recoil effect
            else
                self.Owner:EmitSound("common/wpn_denyselect.wav")
                self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
            end
        else
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
        end
    end
end
