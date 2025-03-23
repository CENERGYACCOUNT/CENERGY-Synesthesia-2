AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Default Ability: Order"
SWEP.Slot = 1
SWEP.SlotPos = 8

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Order your troops! Primary attack to give your ally Attack bonus. Secondary attack to give them Defensive bonus. Reload to mgive them Movement bonus."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

-- Function to perform the action on the target player instead of the owner
function SWEP:PerformActionOnTarget(target, oddity, recoilAngle, sound, voiceType, gesture)
    -- Check if target is valid
    if not IsValid(target) then return end  -- Skip if no valid target

    -- Only apply status if the target does not already have the status
    if target:HasOddity("statusordermoveup") or
       target:HasOddity("statusorderattack") or
       target:HasOddity("statusordernostep") then
        return
    end

    -- Ensure the target is within 500 units range
    if self.Owner:GetPos():Distance(target:GetPos()) > 500 then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        return
    end

    -- Ensure that both owner and target have the same "goodguy" or "badguy" oddity
    local ownerOddity = self.Owner:HasOddity("goodguy") and "goodguy" or "badguy"
    local targetOddity = target:HasOddity("goodguy") and "goodguy" or "badguy"

    if ownerOddity ~= targetOddity then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
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

        -- Decrease special stat of the owner (not the target)
        self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))  

        -- Ensure the gesture is played correctly
        if gesture and IsValid(self.Owner) then
            -- Add a small delay to ensure the animation event is properly processed
            timer.Simple(0.1, function()
                if IsValid(self.Owner) then
                    self.Owner:DoAnimationEvent(gesture)
                end
            end)
        end
    end
end

-- Primary attack function
function SWEP:PrimaryAttack()
    local target = self:GetTargetPlayer()  -- Function to determine the target player

    -- Check if we have a target player or not
    if target and IsValid(target) and (GAMEMODE:Combat() == 0 or self.Owner:Special() > 5 - 0.1) then
        -- Perform action on target and make the owner do the group signal gesture
        self:PerformActionOnTarget(target, "statusorderattack", Angle(3.5, 0, 0), "npc/roller/blade_in.wav", "order", ACT_SIGNAL_GROUP)
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
        self:PerformActionOnTarget(target, "statusordernostep", Angle(-3.5, 0, 0), "npc/roller/blade_in.wav", "order", ACT_SIGNAL_HALT)
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
        self:PerformActionOnTarget(target, "statusordermoveup", Angle(-3.5, 0, 0), "npc/roller/blade_in.wav", "order", ACT_SIGNAL_FORWARD)

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
