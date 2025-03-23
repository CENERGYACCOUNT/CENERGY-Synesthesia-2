AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Flank"
SWEP.Slot = 1
SWEP.SlotPos = 14

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Grants yourself 10M. Can be used once per battle."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has enough Energy (1)

        -- If player already has the 'statusflank' oddity, prevent using again
        if self.Owner:HasOddity("statusflank") then
            return
        end

        if SERVER then
            -- Play the sound effect
            self.Owner:EmitSound("npc/roller/blade_in.wav")
            -- Give the player the 'statusflank' oddity
            self.Owner:GiveOddity("statusflank")
            -- Reduce the player's energy by 1
   
            -- Optionally, you can add an effect or visual feedback here
            self:CheckAndPlayVoice("boost")  -- Optional voice feedback

            -- Small recoil effect
            self.Owner:ViewPunch(Angle(2, 0, 0))
       
        -- Set cooldown before using the ability again
        self:SetNextPrimaryFire(CurTime() + 5)  -- 5-second cooldown
        self:SetNextSecondaryFire(CurTime() + 5)
        self.NextReload = CurTime() + 5
    else
        -- Not enough energy, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect

        -- Set cooldown before using the ability again
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2
   
 end
 end
-- Secondary attack can have a different functionality if needed
function SWEP:SecondaryAttack()

end

function SWEP:Reload()
 
end
