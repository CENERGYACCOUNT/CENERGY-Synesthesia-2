AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Synth Sentry"
ENT.Author = "MaTcz"
ENT.Category = "Synth Entities"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 2, "Broken")
end

if SERVER then
    -- Initialize the entity
    function ENT:Initialize()
        self:SetModel("models/mw2_sentry/mw2_sentry_gun/sentry_minigun.mdl")
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetBroken(false)  -- Set initial state as not broken
        self:SetHealth(100)    -- Set the health to 100
        self:CreateSentryAttachment()  -- Create the force sentry

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end

        -- Start the Think function to check every 5 seconds
        self:NextThink(CurTime())  -- Set the first Think to run immediately
    end

    -- Create the sentry attachment
    function ENT:CreateSentryAttachment()
        if IsValid(self.SentryAttachment) then
            self.SentryAttachment:Remove()  -- Remove any existing sentry
        end

        -- Create a new sentry attachment
        local sentry = ents.Create("prop_dynamic")
        if not IsValid(sentry) then return end

        sentry:SetModel("models/maxofs2d/light_tubular.mdl")
        sentry:SetPos(self:GetPos() + Vector(0, 0, -225))  -- Adjust position above the main entity
        sentry:SetAngles(self:GetAngles())
        sentry:SetParent(self)  -- Attach the sentry to the main entity
        sentry:SetSolid(SOLID_VPHYSICS)

        sentry:SetCollisionGroup(COLLISION_GROUP_WORLD)  -- Block bullets, but allow players through
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)    -- Same for the main entity

        sentry:SetColor(Color(0, 255, 0))  -- Blue sentry color

        -- Apply physics to the sentry
        local phys = sentry:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end

        sentry:Spawn()

        self.SentryAttachment = sentry
    end

    -- Handle entity removal
    function ENT:OnRemove()
        if IsValid(self.SentryAttachment) then
            self.SentryAttachment:Remove()  -- Clean up sentry when entity is removed
        end
    end

    -- Handle damage and health reduction
    function ENT:OnTakeDamage(dmg)
        -- Reduce health
        self:SetHealth(self:Health() - dmg:GetDamage())

        -- If health goes below 0 and sentry is still active, mark as broken and remove sentry
        if self:Health() <= 0 and not self:GetBroken() then
            self:SetBroken(true)
            self:RemoveSentry()
            self:CreateSparksEffect()  -- Trigger spark effect when broken
        end
    end

    -- Remove the sentry (force sentry) when broken
    function ENT:RemoveSentry()
        if IsValid(self.SentryAttachment) then
            self.SentryAttachment:Remove()
        end
    end

    -- Repair the sentry and reset health when setbroken is set to false
    function ENT:SetBroken(state)
        self:SetNWBool("Broken", state)  -- Update broken state

        if state == true then
            -- Sentry is broken, remove it
            self:RemoveSentry()
            self:SetHealth(0)  -- Set health to 0 when broken
        elseif state == false then
            -- Sentry is repaired, create a new sentry and reset health
            self:CreateSentryAttachment()
            self:SetHealth(100)  -- Reset health back to full
        end
    end

    -- Create sparks effect when broken
    function ENT:CreateSparksEffect()
        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())  -- Set the origin of the effect at the sentry's position
        util.Effect("Sparks", effectdata)  -- Create the sparks effect
    end

    -- Create the animation and sparks effect every 4 seconds when sentry is not broken
    function ENT:Think()
        if self:GetBroken() then
            -- If the sentry is broken, repeatedly trigger sparks every 2 seconds
            self:CreateSparksEffect()
            self:EmitSound("ambient/energy/zap7.wav")
            self:EmitSound("npc/scanner/combat_scan1.wav")
            self:NextThink(CurTime() + 2)  -- Set next think to 2 seconds

        else
            
            -- If the sentry is not broken, play animation every 4 seconds
            self:EmitSound("npc/scanner/combat_scan5.wav")
            self:NextThink(CurTime() + 4)  -- Set next think to 4 seconds
        end
        return true
    end

    -- Play the sentry's animation
    function ENT:PlaySentryAnimation()
        if IsValid(self.SentryAttachment) then
            -- Here, you can define the actual animation, assuming "scan" is the animation
            self.SentryAttachment:ResetSequence(self.SentryAttachment:LookupSequence("scan"))
            self.SentryAttachment:SetPlaybackRate(1)  -- You can adjust the speed of the animation here
        end
    end
end
