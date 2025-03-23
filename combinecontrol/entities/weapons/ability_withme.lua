AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: With Me!"
SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Gain 5S for every ally within 250m of you. Maximum 25S. Costs 1 Energy."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has enough Energy (1)
    if self.Owner:Energy() > 1 - 0.1 then
        -- Check if ability has been used recently to avoid multiple triggers
        if self:GetNextPrimaryFire() > CurTime() then return end

        -- Check if the player already has the cooldown oddity
        if self.Owner:HasOddity("cooldownwithme") then
            return
        end

        -- Get the team or faction of the owner (player)
        local isGoodGuy = self.Owner:HasOddity("goodguy")

        local alliesInRange = 0
        local maxRange = 250  -- Adjusted to your preferred range
        local maxSpecialGain = 25
        local specialGainPerAlly = 5

        -- Loop through all players and check for allies in range
        for _, v in ipairs(player.GetAll()) do
            -- Exclude the player using the ability
            if v ~= self.Owner then
                -- Check if the player is in range and is an ally
                if v:GetPos():Distance(self.Owner:GetPos()) <= maxRange then
                    -- Check if the player is a good guy or bad guy based on owner's status
                    if (isGoodGuy and v:HasOddity("goodguy")) or (not isGoodGuy and v:HasOddity("badguy")) then
                        alliesInRange = alliesInRange + 1
                    end
                end
            end
        end

        -- Calculate Special gain, make sure it doesn't exceed the max
        local specialGain = math.min(alliesInRange * specialGainPerAlly, maxSpecialGain)

        if specialGain > 0 then
            -- Apply the special gain and reduce energy by 1
            self.Owner:SetSpecial(self.Owner:Special() + specialGain)
            self.Owner:SetEnergy(self.Owner:Energy() - 1)
            self.Owner:UpdateCharacterField( "StatEnergy", tostring(self.Owner:Energy() ), true ); -- special
            -- Play the sound effect
            self.Owner:EmitSound("npc/roller/blade_in.wav")

            -- Optionally, play voice feedback
            self:CheckAndPlayVoice("order")  -- Optional voice feedback

            -- Small recoil effect
            self.Owner:ViewPunch(Angle(2, 0, 0))

            -- Apply cooldown oddity
            self.Owner:GiveOddity("cooldownwithme")

            -- Set cooldown before using the ability again
            self:SetNextPrimaryFire(CurTime() + 5)  -- 5-second cooldown
        end
    else
        -- Not enough energy, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0)) -- Small reverse recoil effect

        -- Set cooldown before using the ability again
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
    end
end

-- Secondary attack can have a different functionality if needed
function SWEP:SecondaryAttack()

end

function SWEP:Reload()
    -- Add reload cooldown to prevent it from being triggered too fast

end
