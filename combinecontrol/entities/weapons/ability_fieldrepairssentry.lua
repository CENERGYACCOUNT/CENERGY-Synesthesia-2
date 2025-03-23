AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Field Sentry Repairs"
SWEP.Slot = 1
SWEP.SlotPos = 29

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Repair your force sentry."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.RepairCooldown = 5  -- Cooldown time in seconds
SWEP.LastRepairTime = 0  -- Track the last time repair was used

-- Function to perform the action on the 'synthshield' entity
function SWEP:PerformActionOnTarget(target)
    -- Check if the target is a valid synthshield entity and if it's broken
    if not IsValid(target) or target:GetClass() ~= "cc_synthsentry" then
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        return
    end

    if target:GetBroken() == false then  -- If the shield is not broken, can't repair
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        return
    end

    -- Perform the action to set the synthshield as not broken (repair it)
    target:SetBroken(false)
    self.Owner:EmitSound("npc/roller/blade_in.wav")    if SERVER then  -- Success sound 
    self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))  -- Deduct Special cost
end
    -- Apply small recoil effect to the owner
    self.Owner:ViewPunch(Angle(3.5, 0, 0))
end

-- Primary attack function (with cooldown and broken shield check)
function SWEP:PrimaryAttack()
    local target = self:GetTargetEntity()  -- Get the targeted entity

    -- Check if we have a valid target (synthshield), if the player has enough Special, and if it's off cooldown
    if target and IsValid(target) and self.Owner:Special() >= 5 then
        -- Check if cooldown has passed
        if CurTime() < self.LastRepairTime + self.RepairCooldown then
            -- If the cooldown hasn't passed, deny the action
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
            return
        end

        -- Perform the action on the target (repair the shield)
        self:PerformActionOnTarget(target)

        -- Update the last repair time and set the cooldown
        self.LastRepairTime = CurTime()

        -- Set the next primary fire time (cooldown)
        self:SetNextPrimaryFire(CurTime() + self.RepairCooldown)  -- Apply cooldown delay
    else
        -- If no valid target or not enough Special, deny the action
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0))  -- Small reverse recoil for owner
        self:SetNextPrimaryFire(CurTime() + 2)  -- Short delay
    end
end

-- Secondary attack function (same as primary, can be customized if needed)
function SWEP:SecondaryAttack()
    self:PrimaryAttack()  -- For now, the secondary attack does the same as primary
end

-- Reload function (same as primary, can be customized if needed)
function SWEP:Reload()
    self:PrimaryAttack()  -- For now, the reload also triggers the primary attack
end

-- Function to get the target entity (can be modified based on your target logic)
function SWEP:GetTargetEntity()
    local tr = self.Owner:GetEyeTrace()  -- Perform a trace to get the entity being aimed at
    if tr.Entity and tr.Entity:GetClass() == "cc_synthsentry" then
        return tr.Entity  -- Return the synthshield entity if the trace hits it
    end
    return nil  -- No target found
end
