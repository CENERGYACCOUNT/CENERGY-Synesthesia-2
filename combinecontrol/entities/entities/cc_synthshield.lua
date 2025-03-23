AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Synth Shield"
ENT.Author = "MaTcz"
ENT.Category = "Synth Entities"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 2, "Broken")
end

if SERVER then
    -- Initialize the entity
    function ENT:Initialize()
        self:SetModel("models/props_equipment/portablebattery01.mdl")
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetBroken(false)  -- Set initial state as not broken
        self:SetHealth(100)    -- Set the health to 100
        self:CreateShieldAttachment()  -- Create the force shield

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end

        -- Start the Think function to check every 5 seconds
        self:NextThink(CurTime())  -- Set the first Think to run immediately
    end

    -- Create the shield attachment
    function ENT:CreateShieldAttachment()
        if IsValid(self.ShieldAttachment) then
            self.ShieldAttachment:Remove()  -- Remove any existing shield
        end

        -- Create a new shield attachment
        local shield = ents.Create("prop_dynamic")
        if not IsValid(shield) then return end

        shield:SetModel("models/ovr_load/force_shield.mdl")
        shield:SetPos(self:GetPos() + Vector(0, 0, -10))  -- Adjust position above the main entity
        shield:SetAngles(self:GetAngles())
        shield:SetParent(self)  -- Attach the shield to the main entity
        shield:SetSolid(SOLID_VPHYSICS)

        shield:SetCollisionGroup(COLLISION_GROUP_WORLD)  -- Block bullets, but allow players through
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)    -- Same for the main entity

        shield:SetColor(Color(0, 0, 255))  -- Blue shield color

        -- Apply physics to the shield
        local phys = shield:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end

        shield:Spawn()

        self.ShieldAttachment = shield
    end

    -- Handle entity removal
    function ENT:OnRemove()
        if IsValid(self.ShieldAttachment) then
            self.ShieldAttachment:Remove()  -- Clean up shield when entity is removed
        end
    end

    -- Handle damage and health reduction
    function ENT:OnTakeDamage(dmg)
        -- Reduce health
        self:SetHealth(self:Health() - dmg:GetDamage())

        -- If health goes below 0 and shield is still active, mark as broken and remove shield
        if self:Health() <= 0 and not self:GetBroken() then
            self:SetBroken(true)
            self:RemoveShield()
        end
    end

    -- Remove the shield (force shield) when broken
    function ENT:RemoveShield()
        if IsValid(self.ShieldAttachment) then
            self.ShieldAttachment:Remove()
        end
    end

    -- Repair the shield and reset health when setbroken is set to false
    function ENT:SetBroken(state)
        self:SetNWBool("Broken", state)  -- Update broken state

        if state == true then
            -- Shield is broken, remove it
            self:RemoveShield()
            self:SetHealth(0)  -- Set health to 0 when broken
        elseif state == false then
            -- Shield is repaired, create a new shield and reset health
            self:CreateShieldAttachment()
            self:SetHealth(100)  -- Reset health back to full
        end
    end

    -- Think function that runs every 5 seconds
    function ENT:Think()
        if not self:GetBroken() then
            -- If the shield is repaired and the broken state is false, regenerate the shield
            if not IsValid(self.ShieldAttachment) then
                self:CreateShieldAttachment()
                    self:SetHealth(100)    -- Set the health to 100
            end
        end
        
        -- Set the next think time
        self:NextThink(CurTime() + 5)  -- Run this function again after 5 seconds
        return true
    end
end
