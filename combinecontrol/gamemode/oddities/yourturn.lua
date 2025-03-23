ODDITY.ID				= "yourturn";
ODDITY.Name 			= "Your Turn";
ODDITY.Description		= "It's your turn!!";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;
ODDITY.RemoveOnTurnEnd          = false;
ODDITY.OnGiven = function(self, ply)
    if (CLIENT) then
        GAMEMODE:AddChat(Color(200, 200, 200, 255), "CombineControl.ChatNormal", "It's your turn!", { CB_ALL, CB_IC }, nil, guy);
    end

    if (SERVER) then
	local isNearBadGuy = false
        local maxRange = 250

        for _, ent in ipairs(ents.FindInSphere(ply:GetPos(), maxRange)) do
            if ent:IsPlayer() and ply:HasOddity("goodguy") and ent:HasOddity("badguy") or ent:IsPlayer() and ply:HasOddity("badguy") and ent:HasOddity("goodguy") then
                isNearBadGuy = true
                break
            end
        end

        -- Apply "statuspointer" if near an enemy and has "abilitypointer"
        if isNearBadGuy then
		    timer.Simple( 0.05, function()
            if (SERVER) then
        	if ply:HasOddity("abilitypointer") then
        	if ply:HasOddity("statuspointer") then else
            ply:GiveOddity("statuspointer") end end
       		end  end) end 

        if isNearBadGuy then else
        timer.Simple( 0.05, function()
        if (SERVER) then
        if ply:HasOddity("abilitykeepdistance") then
        if ply:HasOddity("statuskeepdistance") then else
        ply:GiveOddity("statuskeepdistance") end end
		end end) end


		end
        


    if (SERVER) then


        ply:SetReadyUp(false)
        ply:SetAttack(math.max(ply:Attack() - 1000, 0))
        ply:SetMovement(math.max(ply:Movement() - 1000, 0))
        if ply:HasOddity("abilitypatience") then else
        ply:SetSpecial(math.max(ply:Special() - 1000, 0)) end
  


        local extraMovement = ply:ExtraMovement() + math.floor(ply:Agility() / 20) or 0
        local extraAttack = ply:ExtraAttack() + math.floor(ply:Reflexes() / 20) or 0
        local extraSpecial = ply:ExtraSpecial() + math.floor(ply:Smarts() / 20) + math.floor(ply:Cool() / 20) or 0
        local MuscleTemporary = ply:MuscleTemporary() or 0

        if (ply:Downed()) then   if (ply:HasOddity ("abilitydeathwish") ) then  ply:SetAttack(math.max(ply:Attack() + 10 + extraAttack, 0)) ply:SetMovement(math.max(ply:Movement() + 3, 0)) end else
        ply:SetAttack(math.max(ply:Attack() + 10 + extraAttack, 0))
        ply:SetMovement(math.max(ply:Movement() + 10 + extraMovement, 0))
        ply:SetSpecial(math.max(ply:Special() + 10 + extraSpecial, 0))
        end
        local extraHealth = ply.BonusHealth and ply:BonusHealth() or 0
        local regenBonus = ply.BonusHealthRegeneration and ply:BonusHealthRegeneration() or 0

        -- Calculate max health
        local maxHP = 100 + extraHealth + math.floor(MuscleTemporary / 5) * 5

        -- Calculate healing amount based on stats and MuscleTemporary
        local baseHealingAmount = 5 + regenBonus
        local muscleHealingBonus = math.floor(MuscleTemporary / 10) * 2.5
        local totalHealingAmount = baseHealingAmount + muscleHealingBonus

if ply:HasOddity("injuryheavy5") then
    if math.random() < 0.5 then -- 50% chance
        ply:GiveOddity("statusstunned")
        ply:EmitSound ("brutal_deaths/male/deathcry (1032).ogg")
    end
end

if ply:HasOddity("injuryheavy4") then 
ply:EmitSound ("brutal_deaths/male/deathcry (114).ogg")
else
        -- Apply health regen (capped at maxHP)
        ply:SetHealth(math.min(ply:Health() + totalHealingAmount, maxHP))
end
if ply:HasOddity("injuryheavy4") then
    -- If out of Attack, damage the player instead
    local damageAmount = 5
    local newHealth = math.max(ply:Health() - damageAmount, 30) -- Stop at 30 HP
    local actualDamage = ply:Health() - newHealth -- Ensure only the necessary damage is applied

    if actualDamage > 0 then
        local dmg = DamageInfo()
        dmg:SetDamage(actualDamage)
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_NERVEGAS) -- Treat as overheating/burning damage
        ply:TakeDamageInfo(dmg)
    end
end


        -- Remove conflicting oddities

for k, oddityID in pairs(ply.Oddities) do
    local oddity = GAMEMODE:GetOddityByID(oddityID) -- Get the oddity data

    if oddity and oddity.RemoveOnTurnEnd then
        timer.Simple(0.00001, function()
            if IsValid(ply) then
                ply:RemoveOddity(ply:GetOddity(oddityID))
            end
        end)
    end
end
 end



end

ODDITY.OnRemoved = function(self, ply)
    if (CLIENT) then
        GAMEMODE:AddChat(Color(200, 200, 200, 255), "CombineControl.ChatNormal", "Your turn ended!", { CB_ALL, CB_IC }, nil, guy);
    end

    if (SERVER) then
             ply:SetReadyUp(false)
        ply:SetAttack(math.max(ply:Attack() - 1000, 0))
        ply:SetMovement(math.max(ply:Movement() - 1000, 0))
        if ply:HasOddity("abilitypatience") then else
        ply:SetSpecial(math.max(ply:Special() - 1000, 0)) end
        if ply:HasOddity("statusoverwatch") then  ply:SetAttack(math.max(ply:Attack() + 10, 0)) end
    end
end
