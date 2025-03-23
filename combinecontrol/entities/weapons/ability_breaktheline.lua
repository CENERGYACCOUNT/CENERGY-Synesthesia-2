AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Break The Line!"
SWEP.Slot = 1
SWEP.SlotPos = 17

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Dash forward and stun enemies within range. Costs 5 Movement, 5 Special, and 1 Energy."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

-- Primary attack (dash and stun ability)
function SWEP:PrimaryAttack()
    -- Check if player has enough Movement (5), Special (5), and Energy (1)
    if self.Owner:Energy() > 1 - 0.1 and self.Owner:Special() > 5 - 0.1 and self.Owner:Movement() > 5 - 0.1 then
        -- Prevent the ability from triggering multiple times
        if self:GetNextPrimaryFire() > CurTime() then return end

        -- Dash: Apply forward velocity boost (200)
        if self.Owner:IsOnGround() then
            local forward = self.Owner:GetForward()  -- Get the player's facing direction
            self.Owner:SetVelocity(self.Owner:GetVelocity() + forward * 750)  -- Add a forward velocity boost (adjust 200 as needed)
        end

        -- Deduct costs and set cooldown immediately after the dash
        if SERVER then
            self.Owner:SetMovement(self.Owner:Movement() - 5)
            self.Owner:SetSpecial(self.Owner:Special() - 5)
            self.Owner:SetEnergy(self.Owner:Energy() - 1)
            self:CheckAndPlayVoice("warcry")  -- Optional voice feedback
            self.Owner:UpdateCharacterField("StatEnergy", tostring(self.Owner:Energy()), true)  -- Update the energy stat
        end

        self:SetNextPrimaryFire(CurTime() + 2)  -- 5-second cooldown after dash

        -- Get the team or faction of the owner (player)
        local isGoodGuy = self.Owner:HasOddity("goodguy")

        -- After a brief delay, apply the stun effect to enemies in range
        timer.Simple(0.5, function()  -- Wait for the player to be moved
            -- Create a small radius around the player to apply the "statusstunned" oddity
            local radius = 100  -- Radius for "statusstunned"
            local enemiesInRange = 0

            -- Loop through all players and check for enemies in range
            for _, v in ipairs(player.GetAll()) do
                -- Exclude the player using the ability
                if v ~= self.Owner then
                    -- Check if the player is in range
                    if v:GetPos():Distance(self.Owner:GetPos()) <= radius then
                        -- Check if the player is an enemy based on GoodGuy/BadGuy logic
                        if (isGoodGuy and not v:HasOddity("goodguy")) or (not isGoodGuy and not v:HasOddity("badguy")) then
                            -- Prevent applying the "statusstunned" oddity if it's already applied
                            if not v:HasOddity("statusstunned") then
                                -- Ensure the oddities table exists for the player
                                if not v.Oddities then
                                    v.Oddities = {}  -- Initialize the oddities table if it's nil
                                end

                                -- Apply the "statusstunned" oddity to the enemy
                                v:GiveOddity("statusstunned")
                                enemiesInRange = enemiesInRange + 1
                            end
                        end
                    end
                end
            end

            -- If there were any enemies in range, play the sound effect
            if enemiesInRange > 0 then
                -- Play the sound effect
                self.Owner:EmitSound("npc/roller/blade_in.wav")

                -- Small recoil effect
                self.Owner:ViewPunch(Angle(2, 0, 0))
            end
        end)

    else
        -- Not enough Movement, Special, or Energy, play deny sound
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
