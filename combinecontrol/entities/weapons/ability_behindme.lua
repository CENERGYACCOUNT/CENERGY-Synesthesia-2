AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Behind Me!"
SWEP.Slot = 1
SWEP.SlotPos = 19

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Grant 'statuscovered' to yourself and allies within range. Costs 5 Special and 1 Energy."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has enough Energy (1) and Special (5)
    if self.Owner:Energy() > 1 - 0.1 and self.Owner:Special() > 5 - 0.1 then
        -- Get the team or faction of the owner (player)
        local isGoodGuy = self.Owner:HasOddity("goodguy")

        local alliesInRange = 0
        local maxRange = 150  -- Range for detecting allies

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

        -- If there is at least one ally, grant 'statuscovered' to the owner and allies
        if alliesInRange > 0 then
            -- Apply the 'statuscovered' oddity to the player and all nearby allies
            if SERVER then
                -- Apply to the owner
                self.Owner:GiveOddity("statuscovered")
                -- Apply to each ally within range
                for _, v in ipairs(player.GetAll()) do
                    if v ~= self.Owner and v:GetPos():Distance(self.Owner:GetPos()) <= maxRange then
                        -- Apply the 'statuscovered' oddity to the ally
                        if (isGoodGuy and v:HasOddity("goodguy")) or (not isGoodGuy and v:HasOddity("badguy")) then
                            v:GiveOddity("statuscovered")
                        end
                    end
                end
            end

            -- Play the sound effect
            self.Owner:EmitSound("npc/roller/blade_in.wav")
            self:CheckAndPlayVoice("order")  -- Optional voice feedback
            -- Small recoil effect
            self.Owner:ViewPunch(Angle(2, 0, 0))

            -- Reduce Special and Energy by the specified amounts
            self.Owner:SetSpecial(self.Owner:Special() - 5)
            self.Owner:SetEnergy(self.Owner:Energy() - 1)
            self.Owner:UpdateCharacterField("StatEnergy", tostring(self.Owner:Energy()), true)

            -- Set cooldown before using the ability again (5 seconds)
            self:SetNextPrimaryFire(CurTime() + 5)  -- 5-second cooldown
        end
    else
        -- Not enough Special or Energy, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small reverse recoil effect

        -- Set cooldown before using the ability again (2 seconds)
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
    end
end

-- Secondary attack function (if needed for other purposes)
function SWEP:SecondaryAttack()

end

function SWEP:Reload()
    -- Add reload functionality if necessary
end
