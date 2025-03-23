AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.Category = "Synth NPCS"

ENT.PrintName = "NPC Apexi"
ENT.Author = "Matt"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:PostEntityPaste(ply, ent, tab)
    GAMEMODE:LogSecurity(ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!")
    ent:Remove()
end

function ENT:SetupDataTables()
end

function ENT:Initialize()
    if CLIENT then return end

    -- New list of models
    local models = {
        "models/marauder/alliance/marines/players/male/alliance_marine_01.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_02.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_03.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_04.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_05.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_06.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_07.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_08.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_m_generic.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_goss.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_jeffrey.mdl",
        "models/marauder/alliance/marines/players/male/alliance_marine_louis.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_01.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_02.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_03.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_04.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_05.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_06.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_07.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_dixon.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_generic.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_hawke.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_natalie.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_nicole.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_rin.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_roch.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_steele.mdl",
        "models/marauder/alliance/marines/players/female/alliance_marine_zoe.mdl",
        "models/player/scifi_female_01.mdl",
        "models/player/scifi_female_02.mdl",
        "models/player/scifi_female_03.mdl",
        "models/player/scifi_female_04.mdl",
        "models/player/scifi_female_05.mdl",
        "models/player/scifi_female_06.mdl",
        "models/player/scifi_female_07.mdl",
        "models/player/scifi_male_01.mdl",
        "models/player/scifi_male_02.mdl",
        "models/player/scifi_male_03.mdl",
        "models/player/scifi_male_04.mdl",
        "models/player/scifi_male_05.mdl",
        "models/player/scifi_male_06.mdl",
        "models/player/scifi_male_07.mdl",
        "models/player/scifi_male_08.mdl",
        "models/player/scifi_male_09.mdl",
        "models/player/scifi_mp1.mdl",
        "models/player/scifi_mp3.mdl",
        "models/player/scifi_plr.mdl",
        "models/player/scifi_rochelle.mdl",
        "models/player/scifi_zoey.mdl",
        "models/player/scifi_wraith.mdl"
    }

    -- Randomly select a model from the list
    local randomModel = models[math.random(#models)]

    -- Set the selected model
    self:SetModel(randomModel)

    self:SetSolid(SOLID_BBOX)  -- Set to BBOX for NPC-like collision

    -- Replace SetHull with SetCollisionBounds
    self:SetCollisionBounds(Vector(-16, -16, 0), Vector(16, 16, 72))

    -- Enable physics
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
        phys:EnableMotion(true)
    end

    -- No collision with the world, but collides with players
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)  

    -- List of possible animations
    local animations = {
        "idle_all_01",
        "idle_all_02",
        "pose_ducking_02",
        "pose_standing_01",
        "pose_ducking_01",
        "pose_standing_02",
        "sit_ground",
        "sit_zen"
    }

    -- Randomly select an animation from the list
    local randomAnimation = animations[math.random(#animations)]

    -- Set the selected animation
    self:SetSequence(randomAnimation)
    self:ResetSequence(randomAnimation)

    -- Enable movement & NPC-like interactions
    self:SetMoveType(MOVETYPE_STEP)
end
