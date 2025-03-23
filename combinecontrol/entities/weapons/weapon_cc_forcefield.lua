AddCSLuaFile()

SWEP.Base = "weapon_cc_base"
SWEP.PrintName = "Force Field - Stout & Williams"
SWEP.Slot = 1
SWEP.SlotPos = 77

SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_junk/PopCan01a.mdl"

SWEP.HoldType = "slam"
SWEP.HoldTypeHolster = "slam"

SWEP.InfoText = "Primary: Deploy a Synth Shield."

SWEP.Holsterable = false

SWEP.AimPos = Vector()
SWEP.AimAng = Vector()

SWEP.Itemize = true
SWEP.ItemDescription = "Deploys a forcefield shield to block incoming fire."
SWEP.ItemWeight = 5
SWEP.ItemFOV = 9
SWEP.ItemCamPos = Vector(50, 50, 50)
SWEP.ItemLookAt = Vector(0, 0, 0)

SWEP.ItemBulkPrice = 50
SWEP.ItemLicense = LICENSE_BLACK

function SWEP:PostDrawOpaqueRenderables()
   
   if( self.Owner == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() and !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, self.Owner ) ) then return end
   
   if( self.Owner:InVehicle() ) then return end
   if( self.Owner:GetNoDraw() ) then return end
   
   if( !self.Owner:Holstered() and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 ) then
      
      
      
   end
   
end
function SWEP:PrimaryAttack()
    if not SERVER then return end
    local owner = self.Owner
    
    -- Check if player has enough Special
    if owner:Special() < 5 then
        owner:EmitSound("common/wpn_denyselect.wav")
        return
    end
    
    -- Deduct Special points
    owner:SetSpecial(owner:Special() - 5)
    
    -- Spawn the shield entity
    local shield = ents.Create("cc_synthshield")
    if not IsValid(shield) then return end
    
    local forward = owner:GetForward()
    local pos = owner:GetPos() + forward * 50 + Vector(0, 0, 50)
    
    -- Set position and rotate the shield by 160 degrees
    shield:SetPos(pos)
    shield:SetAngles(owner:GetAngles() + Angle(0, 100, 0))  -- Rotate by 160 degrees on the Y-axis
    shield:Spawn()
    shield:Activate()

    -- If player has the "abilitydurable" oddity, set shield health to 200
    if owner:HasOddity("abilitydurable") then
        shield:SetHealth(200)
    else
        shield:SetHealth(100)  -- Default health if no oddity
    end
    
    owner:EmitSound("npc/roller/blade_in.wav")
    self.RemoveTime = CurTime();
    self:SetNextPrimaryFire(CurTime() + 5)
end

function SWEP:ThinkChild()
    
    if( SERVER ) then
        
        if( self.RemoveTime and CurTime() >= self.RemoveTime ) then
            
            self.RemoveTime = nil;
            self.Owner:RemoveItem( self.Owner:GetInventoryItem( self:GetClass() ) );
            
        end
        
    end
    
end