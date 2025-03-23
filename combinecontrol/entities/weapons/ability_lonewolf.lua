AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Lonewolf"
SWEP.Slot = 1
SWEP.SlotPos = 10

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Gain 10A, 10S, 10M if no allies are within 10m. Costs 1 Energy."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

function SWEP:PrimaryAttack()
    -- Check if player has the cooldown oddity
    if self.Owner:HasOddity("cooldownlonewolf") then
        -- If the player has the cooldown oddity, do not allow the ability to be used again
        return
    end

    -- Check if primary attack can be performed

    -- Check if player has enough Energy (1)
    if self.Owner:Energy() > 1 - 0.1 then
        local alliesInRange = 0
        local maxRange = 350  -- Range for checking allies

        -- Loop through all players and check for allies in range
        for _, v in ipairs(player.GetAll()) do
            -- Exclude the player using the ability
            if v ~= self.Owner then
                -- Check if the player is in range
                if v:GetPos():Distance(self.Owner:GetPos()) <= maxRange then
                    alliesInRange = alliesInRange + 1
                end
            end
        end

        -- If no allies are within range, grant the Lonewolf benefits
        if alliesInRange == 0 then
            -- Apply the benefits: 10 A, 10 S, 10 M
                if( SERVER ) then
            self.Owner:SetAttack(self.Owner:Attack() + 10)  -- Apply 10 A (Attack)
            self.Owner:SetSpecial(self.Owner:Special() + 10)  -- Apply 10 S (Special)
            self.Owner:SetMovement(self.Owner:Movement() + 10)  -- Apply 10 M (Movement)
            self:CheckAndPlayVoice("warcry")  -- Optional voice feedback
            -- Reduce energy by 1
            self.Owner:SetEnergy(self.Owner:Energy() - 1)
            self.Owner:UpdateCharacterField( "StatEnergy", tostring(self.Owner:Energy() ), true ); -- special
end
            -- Play the sound effect
            self.Owner:EmitSound("npc/roller/blade_in.wav")

            -- Small recoil effect
            self.Owner:ViewPunch(Angle(2, 0, 0))

            -- Apply cooldown oddity to prevent ability from being used again immediately
            self.Owner:GiveOddity("cooldownlonewolf")

            -- Set the cooldown for primary attack (0.5 seconds)
            self:SetNextPrimaryFire(CurTime() + 0.5)
        else
            -- If there are allies nearby, play deny sound
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small reverse recoil effect
        end
    else
        -- Not enough energy, play deny sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-2, 0, 0))  -- Small reverse recoil effect

        -- Set cooldown before using the ability again (0.5 seconds)
        self:SetNextPrimaryFire(CurTime() + 0.5)
    end
end
