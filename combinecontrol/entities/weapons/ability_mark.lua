AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Leader Ability: Enemy Mark"
SWEP.Slot = 1
SWEP.SlotPos = 9

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Mark enemy. Primary attack to reveal them and double your teams Shredding against them. Secondary attack to make them a priority target, increasing Crit Chance on them. Reload to track them, decreasing their Dodge."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

-- Function to perform the action on the target player instead of the owner
-- Function to perform the action on the target player
function SWEP:PerformActionOnTarget(target, oddity, recoilAngle, sound, voiceType, gesture)
    -- Check if target is valid
    if not IsValid(target) then return end  -- Skip if no valid target

    -- Ensure the target is within 500 units range
    if self.Owner:GetPos():Distance(target:GetPos()) > 50000 then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        return
    end

    -- Determine team affiliation
    local ownerIsGood = self.Owner:HasOddity("goodguy")
    local targetIsGood = target:HasOddity("goodguy")

    -- Ensure that Good Guys can only target Bad Guys, and vice versa
    if ownerIsGood == targetIsGood then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        return
    end

    -- Only apply status if the target does not already have it
    if target:HasOddity("statusmarkreveal") or
       target:HasOddity("statusmarktrack") or
       target:HasOddity("statusmarktarget") then
        return
    end

    -- Perform the action if the conditions are met
    if SERVER then
        target:EmitSound("npc/roller/blade_in.wav")
        target:GiveOddity(oddity)
        self:CheckAndPlayVoice(voiceType)  -- Play appropriate voice

        -- Apply recoil effect to both owner and target
        target:ViewPunch(recoilAngle)
        self.Owner:ViewPunch(recoilAngle)

        -- Decrease special stat of the owner
        self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))  

        -- Ensure the gesture is played correctly
        if gesture and IsValid(self.Owner) then
            timer.Simple(0.1, function()
                if IsValid(self.Owner) then
                    self.Owner:DoAnimationEvent(gesture)
                end
            end)
        end
    end
end


-- Primary track function
-- Primary attack function
function SWEP:PrimaryAttack()
    local target = self:GetTargetPlayer()  -- Function to determine the target player

    -- Check if we have a target player or not
    if target and IsValid(target) and (GAMEMODE:Combat() == 0 or self.Owner:Special() > 5 - 0.1) then
        -- Perform action on target and make the owner do the group signal gesture
        self:PerformActionOnTarget(target, "statusmarkreveal", Angle(3.5, 0, 0), "npc/roller/blade_in.wav", "debuff", ACT_SIGNAL_FORWARD)
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    else
        -- If no player is targeted, apply the effects to the owner
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    end
end

-- Secondary attack function
function SWEP:SecondaryAttack()
    local target = self:GetTargetPlayer()  -- Function to determine the target player

    -- Check if we have a target player or not
    if target and IsValid(target) and (GAMEMODE:Combat() == 0 or self.Owner:Special() > 5 - 0.1) then
        -- Perform action on target and make the owner do the halt signal gesture
        self:PerformActionOnTarget(target, "statusmarktarget", Angle(-3.5, 0, 0), "npc/roller/blade_in.wav", "debuff", ACT_SIGNAL_FORWARD)
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    else
        -- If no player is targeted, apply the effects to the owner
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    end
end

-- Reload function
function SWEP:Reload()
    local target = self:GetTargetPlayer()  -- Function to determine the target player

    if self.NextReload and CurTime() < self.NextReload then return end  -- Cooldown check

    -- Check if we have a target player or not
    if target and IsValid(target) and (GAMEMODE:Combat() == 0 or self.Owner:Special() > 5 - 0.1) then
        -- Perform action on target and make the owner perform the forward signal gesture
        self:PerformActionOnTarget(target, "statusmarktrack", Angle(-3.5, 0, 0), "npc/roller/blade_in.wav", "debuff", ACT_SIGNAL_FORWARD)

        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    else
        -- If no player is targeted, apply the effects to the owner
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        self:SetNextPrimaryFire(CurTime() + 2)  -- Small reload delay
        self:SetNextSecondaryFire(CurTime() + 2)
        self.NextReload = CurTime() + 2  -- 3-second cooldown before reloading again
    end
end

-- Function to get the target player (you may modify this based on how you want to determine the target)
function SWEP:GetTargetPlayer()
    local tr = self.Owner:GetEyeTrace()  -- Perform a trace to get the player being aimed at
    if tr.Entity and tr.Entity:IsPlayer() then
        return tr.Entity  -- Return the target player if the trace hits a player
    end
    return nil  -- No target found
end
