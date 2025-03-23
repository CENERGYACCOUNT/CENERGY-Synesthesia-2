AddCSLuaFile()

SWEP.Base = "weapon_cc_base_synth"

SWEP.PrintName = "Ability: Armor Repair"
SWEP.Slot = 1
SWEP.SlotPos = 20

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"
SWEP.Holsterable = false

SWEP.Itemize = true
SWEP.ItemDescription = "Repairs temporary armor by 50, up to the maximum armor."
SWEP.ItemWeight = 0
SWEP.ItemFOV = 11
SWEP.ItemCamPos = Vector(50, -0.89, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.RepairCooldown = 5  -- Cooldown time in seconds
SWEP.LastRepairTime = 0  -- Track the last time repair was used

-- Primary Attack function
function SWEP:PrimaryAttack()
    if not SERVER then return end
    local owner = self.Owner
    
    -- Check if player has enough Special
    if owner:Special() < 5 then
        owner:EmitSound("common/wpn_denyselect.wav")
        owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
        return
    end
    
    -- Deduct Special points
    owner:SetSpecial(owner:Special() - 5)
    
    -- Perform armor repair
    local repaired = false

    -- Loop through each armor type and repair temporary armor
    local armorTypes = {
        "BluntHeadDefense",
        "BluntChestDefense",
        "BluntArmsDefense",
        "BluntLegsDefense",
        "SlashHeadDefense",
        "SlashChestDefense",
        "SlashArmsDefense",
        "SlashLegsDefense",
        "BulletHeadDefense",
        "BulletChestDefense",
        "BulletArmsDefense",
        "BulletLegsDefense",
        "HeatHeadDefense",
        "HeatChestDefense",
        "HeatArmsDefense",
        "HeatLegsDefense"
    }

    for _, armor in ipairs(armorTypes) do
        -- Use GetNWFloat for temporary armor (ensure these are properly set on the player)
        local tempArmor = owner:GetNWFloat(armor .. "Temporary", 0)
        local maxArmor = owner:GetNWFloat(armor, 0)

        -- Check if the temporary armor is less than the maximum armor
        if tempArmor < maxArmor then
            local newTempArmor = math.min(tempArmor + 50, maxArmor)  -- Increase by 50, but do not exceed max value
            owner:SetNWFloat(armor .. "Temporary", newTempArmor)  -- Update the temporary armor
            repaired = true
        end
    end

    -- If any armor was repaired, emit sound and apply cooldown
    if repaired then
        owner:EmitSound("npc/roller/blade_in.wav")
        owner:ViewPunch(Angle(2, 0, 0))  -- Small recoil effect
        self:SetNextPrimaryFire(CurTime() + self.RepairCooldown)  -- Apply cooldown
    else
        owner:EmitSound("common/wpn_denyselect.wav")
        owner:ViewPunch(Angle(-2, 0, 0))  -- Small recoil effect
    end
end

-- Secondary Attack function (can be customized if needed)
function SWEP:SecondaryAttack()
    self:PrimaryAttack()  -- For now, the secondary attack does the same as primary
end

-- Reload function (same as primary, can be customized if needed)
function SWEP:Reload()
    self:PrimaryAttack()  -- For now, the reload also triggers the primary attack
end
