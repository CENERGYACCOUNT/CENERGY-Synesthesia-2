AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Bunk Bed"
ENT.Author = "MaTcz"
ENT.Category = "Synth Entities"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_phx/construct/metal_plate1.mdl")
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end
    end

    function ENT:Use(activator, caller)
                  local extraEnergy = caller:ExtraEnergy() or 0
        if IsValid(caller) and caller:IsPlayer() then
            if caller:Energy() > (4 + extraEnergy) then
                return
            end

            -- Set player's Energy
  
            caller:SetEnergy(5 + extraEnergy)
            caller:UpdateCharacterField( "StatEnergy", tostring( caller:Energy() ), true ); -- special
            caller:EmitSound("items/medshot4.wav") -- Success sound
 end
     local extraUltimate = caller:ExtraUltimate() or 0
        if IsValid(caller) and caller:IsPlayer() then
            if caller:Ultimate() > (0 + extraUltimate) then
                return
            end

            -- Set player's Ultimate
  
            caller:SetUltimate(1 + extraUltimate)
            caller:UpdateCharacterField( "StatUltimate", tostring( caller:Ultimate() ), true ); -- special
            caller:EmitSound("items/medshot4.wav") -- Success sound


        end
    end
end