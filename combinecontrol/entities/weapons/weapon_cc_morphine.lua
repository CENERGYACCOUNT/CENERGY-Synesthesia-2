AddCSLuaFile()

SWEP.Base = "weapon_cc_base"

SWEP.PrintName = "Adrenaline Injector"
SWEP.Slot = 2
SWEP.SlotPos = 99

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/darky_m/c_syringe_v2.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_syringe_v2.mdl"

SWEP.Firearm = false
SWEP.Melee = true

SWEP.HoldType = "knife"
SWEP.HoldTypeHolster = "normal"

SWEP.DrawAnim = "deploy"
SWEP.HolsterAnim = "deploy"

SWEP.Holsterable = false
SWEP.HolsterUseAnim = true

SWEP.Itemize = true
SWEP.ItemDescription = "Adrenaline injector, ready for use. May cause overdose and addiction."
SWEP.ItemWeight = 0.5
SWEP.ItemFOV = 9
SWEP.ItemCamPos = Vector(0, 0, 0)
SWEP.ItemLookAt = Vector(0, 0, 0)
SWEP.HolsterPos = Vector( 0, 0, 0 );
SWEP.HolsterAng = Vector( 0, 0, 0 );
SWEP.AimPos = Vector( 0, 0, 0 );
SWEP.AimAng = Vector( 0, 0, 0 );

SWEP.ItemBulkPrice = 1000
SWEP.ItemLicense = LICENSE_STOUTANDWILLIAMS

SWEP.InfoText = [[Brand - Stout & Williams
Cost - 5S
Left Click - Use on Self
Right Click - Use on Others
]]

SWEP.PrimaryCooldown = 2  -- Updated cooldown to 2 seconds
SWEP.SecondaryCooldown = 2  -- Updated cooldown to 2 seconds

function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      
      
   end
   
end

function SWEP:ShootEffects()

end

-- Helper function to check if the target is a valid player
local function isValidTarget(target)
    return target and target:IsPlayer() and target:Alive()
end

-- Primary attack (Inject self)
-- Primary attack (Inject self)
function SWEP:PrimaryAttack()
    -- Check if the cooldown has passed
    if self:GetNextPrimaryFire() > CurTime() then
        return
    end

    if SERVER then 
        -- Check if the player has enough Special
        local specialCost = 5
        if self.Owner:HasOddity("abilitypatcher") then
            specialCost = 0  -- Reduce the cost to 0 if the player has the "abilitypatcher" oddity
        end

        if self.Owner:Special() < specialCost then
            self.Owner:EmitSound("common/wpn_denyselect.wav")
            return
        end

        -- Deduct the Special cost for the injection
        self.Owner:SetSpecial(self.Owner:Special() - specialCost)

        self.Owner:EmitSound("weapons/rust_mp3/syringe-inject-friend.mp3")
        -- Check and apply adrenaline status effects to the owner (self)
        if self.Owner:HasOddity("statusadrenaline3") then
            self.Owner:TakeDamage(1000)
            return
        end

        if self.Owner:HasOddity("statusadrenaline2") then
            self.Owner:GiveOddity("statusadrenaline3")
        elseif self.Owner:HasOddity("statusadrenaline1") then
            self.Owner:GiveOddity("statusadrenaline2")
        else
            self.Owner:GiveOddity("statusadrenaline1")
        end

        -- Handle item removal based on "abilityprofessional"
        if not self.Owner:HasOddity("abilityprofessional") or math.random() > 0.5 then
            timer.Simple(0.5, function()
                self.Owner:RemoveItem(self.Owner:GetInventoryItem(self:GetClass()))
            end)
        end
    end

    local vm = self.Owner:GetViewModel()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    vm:SendViewModelMatchingSequence(vm:LookupSequence("inject"))

    self:SetNextPrimaryFire(CurTime() + self.PrimaryCooldown)
end

-- Secondary attack (Inject a targeted player)
function SWEP:SecondaryAttack()
    -- Check if the cooldown has passed
    if self:GetNextSecondaryFire() > CurTime() then
        return
    end

    -- Get the player's view direction (what they're looking at)
    local trace = self.Owner:GetEyeTrace()

    -- Ensure the target is a valid player and within range (250 units)
    if isValidTarget(trace.Entity) and self.Owner:GetPos():Distance(trace.Entity:GetPos()) <= 550 then
        local targetPlayer = trace.Entity
        if SERVER then
            -- Check if the target player has enough Special
            local specialCost = 5
            if self.Owner:HasOddity("abilitypatcher") then
                specialCost = 0  -- Reduce the cost to 0 if the player has the "abilitypatcher" oddity
            end

            if self.Owner:Special() < specialCost then
                self.Owner:EmitSound("common/wpn_denyselect.wav")
                return
            end

            -- Deduct the Special cost for the injection
            self.Owner:SetSpecial(self.Owner:Special() - specialCost)
            self.Owner:EmitSound("weapons/rust_mp3/syringe-inject-friend.mp3")

            -- Check and apply adrenaline status effects to the target player
            if targetPlayer:HasOddity("statusadrenaline3") then
                targetPlayer:TakeDamage(1000)
                return
            end

            if targetPlayer:HasOddity("statusadrenaline2") then
                targetPlayer:GiveOddity("statusadrenaline3")
            elseif targetPlayer:HasOddity("statusadrenaline1") then
                targetPlayer:GiveOddity("statusadrenaline2")
            else
                targetPlayer:GiveOddity("statusadrenaline1")
            end

            -- Handle item removal based on "abilityprofessional"
            if not self.Owner:HasOddity("abilityprofessional") or math.random() > 0.5 then
                timer.Simple(0.5, function()
                    self.Owner:RemoveItem(self.Owner:GetInventoryItem(self:GetClass()))
                end)
            end
        end

        self:SendWeaponAnimShared(ACT_VM_SECONDARYATTACK)
        self:SetNextSecondaryFire(CurTime() + self.SecondaryCooldown)
    else
        -- If no valid player was targeted, emit a sound
        self.Owner:EmitSound("common/wpn_denyselect.wav")
    end
end
