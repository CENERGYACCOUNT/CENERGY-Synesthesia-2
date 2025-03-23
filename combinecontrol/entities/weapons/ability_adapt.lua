AddCSLuaFile();

SWEP.Base         = "weapon_cc_base_synth";

SWEP.PrintName       = "Default Ability: Adapt";
SWEP.Slot         = 1;
SWEP.SlotPos      = 21;

SWEP.UseHands     = true;
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_lab/huladoll.mdl"

SWEP.Primary.Automatic     = true;

SWEP.HoldType = "knife";
SWEP.HoldTypeHolster = "normal";
SWEP.Holsterable = false;

SWEP.Itemize = true;
SWEP.ItemDescription = "Boost yourself depending on the situation. Primary attack to increase agility. Secondary attack to increase Muscles. Reload to increase Reflexes.";
SWEP.ItemWeight = 0;
SWEP.ItemFOV = 11;
SWEP.ItemCamPos = Vector( 50, -0.89, 50 );
SWEP.ItemLookAt = Vector( 0, 0, 0 );


function SWEP:PrimaryAttack()
    if (GAMEMODE:Combat() == 0) or (self.Owner:Special() > 5 - 0.1) then
if (self.Owner:HasOddity ("statusadaptreflexes")) then return end
if (self.Owner:HasOddity ("statusadaptagility")) then return end
if (self.Owner:HasOddity ("statusadaptmuscle")) then return end
            
        if SERVER then
            self.Owner:EmitSound("npc/roller/blade_in.wav")
            self.Owner:GiveOddity("statusadaptagility")

              self:CheckAndPlayVoice("boost")

            self.Owner:ViewPunch(Angle(3.5, 0, 0)) -- Small recoil effect
            self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))
        end
             self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    else
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(-1, 0, 0)) -- Small recoil effect
      self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    end
end

function SWEP:SecondaryAttack()
    if (GAMEMODE:Combat() == 0) or (self.Owner:Special() > 5 - 0.1) then

if (self.Owner:HasOddity ("statusadaptreflexes")) then return end
if (self.Owner:HasOddity ("statusadaptagility")) then return end
if (self.Owner:HasOddity ("statusadaptmuscle")) then return end

        if SERVER then
            self.Owner:EmitSound("npc/roller/blade_in.wav")
            self.Owner:GiveOddity("statusadaptmuscle")
                self:CheckAndPlayVoice("boost")
            self.Owner:ViewPunch(Angle(-3.5, 0, 0)) -- Reverse recoil effect
            self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))
        end
             self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    else
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0)) -- Small reverse recoil
       self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    end
end

function SWEP:Reload()
    if self.NextReload and CurTime() < self.NextReload then return end -- Cooldown check

    if (GAMEMODE:Combat() == 0) or (self.Owner:Special() > 5 - 0.1) then

if (self.Owner:HasOddity ("statusadaptreflexes")) then return end
if (self.Owner:HasOddity ("statusadaptagility")) then return end
if (self.Owner:HasOddity ("statusadaptmuscle")) then return end

        if SERVER then
            self.Owner:EmitSound("npc/roller/blade_in.wav")
            self:CheckAndPlayVoice("boost")
            self.Owner:GiveOddity("statusadaptreflexes")
            self.Owner:ViewPunch(Angle(-3.5, 0, 0)) -- Reverse recoil effect
            self.Owner:SetSpecial(math.Clamp(self.Owner:Special() - 5, 0, 100))
        end
            self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    else
        self.Owner:EmitSound("common/wpn_denyselect.wav")
        self.Owner:ViewPunch(Angle(1, 0, 0)) -- Small reverse recoil
       self:SetNextPrimaryFire(CurTime() + 2) -- Small reload delay
    self:SetNextSecondaryFire(CurTime() + 2)
    self.NextReload = CurTime() + 2 -- 3-second cooldown before reloading again
    end
end