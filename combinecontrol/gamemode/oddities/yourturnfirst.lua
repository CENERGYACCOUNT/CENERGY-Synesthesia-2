ODDITY.ID="yourturnfirst"
ODDITY.Name="Your First Turn"
ODDITY.Description="It's your first turn!!"
ODDITY.Obvious=true
ODDITY.Operable=false
ODDITY.RemoveOnTurnEnd          = false;
ODDITY.OnGiven=function(self,ply)
if(CLIENT)then
GAMEMODE:AddChat(Color(200,200,200,255),"CombineControl.ChatNormal","It's your first turn!",{CB_ALL,CB_IC},nil,guy)end
if(SERVER)then
local Muscle = ply:Muscle() or 0
local extraHealth = ply.BonusHealth and ply:BonusHealth() or 0
local baseHealth = 100 + extraHealth

-- Calculate the bonus health based on MuscleTemporary, rounding to the nearest multiple of 5
local bonusHealth = math.floor(Muscle / 5) * 5

-- Set the final maxHP
local maxHP = baseHealth + bonusHealth
ply:SetHealth(maxHP)

local extraMuscle=ply:Muscle()or 0
ply:SetMuscleTemporary(math.max(ply:MuscleTemporary()+0+extraMuscle,0,0))
local extraAgility=ply:Agility()or 0
ply:SetAgilityTemporary(math.max(ply:AgilityTemporary()+0+extraAgility,0,0))
local extraReflexes=ply:Reflexes()or 0
ply:SetReflexesTemporary(math.max(ply:ReflexesTemporary()+0+extraReflexes,0,0))
local extraSly=ply:Sly()or 0
ply:SetSlyTemporary(math.max(ply:SlyTemporary()+0+extraSly,0,0))
local extraCool=ply:Cool()or 0
ply:SetCoolTemporary(math.max(ply:CoolTemporary()+0+extraCool,0,0))
local extraSmarts=ply:Smarts()or 0
ply:SetSmartsTemporary(math.max(ply:SmartsTemporary()+0+extraSmarts,0,0))
local extraPersistence=ply:Persistence()or 0
ply:SetPersistenceTemporary(math.max(ply:PersistenceTemporary()+0+extraPersistence,0,0))
local extraAccuracy = ply:Accuracy() or 0
local reflexesAccuracyBonus = math.floor(ply:Reflexes() / 5) * 2.5  -- 2.5 Accuracy per 5 Reflexes
ply:SetAccuracyTemporary(math.max(ply:AccuracyTemporary() + extraAccuracy + reflexesAccuracyBonus, 0))
local extraBluntProficiency=ply:BluntProficiency()or 0
ply:SetBluntProficiencyTemporary(math.max(ply:BluntProficiencyTemporary()+0+extraBluntProficiency,0,0))
local extraSlashProficiency=ply:SlashProficiency()or 0
ply:SetSlashProficiencyTemporary(math.max(ply:SlashProficiencyTemporary()+0+extraSlashProficiency,0,0))
local extraMartialProficiency=ply:MartialProficiency()or 0
ply:SetMartialProficiencyTemporary(math.max(ply:MartialProficiencyTemporary()+0+extraMartialProficiency,0,0))
-- Threat (-0.5 Threat per 1 Sly)
local extraSly = ply:Sly() or 0
local slyThreatBonus = -0.5 * extraSly  -- -0.5 Threat per 1 Sly
local extraThreat = ply:Threat() or 0
ply:SetThreatTemporary(math.max(ply:ThreatTemporary() + extraThreat + slyThreatBonus, 0))

local extraParry = ply:Parry() or 0
local reflexesParryBonus = math.floor(ply:Reflexes() / 5) * 3.3  -- 3.3% Parry per 5 Reflexes
ply:SetParryTemporary(math.max(ply:ParryTemporary() + extraParry + reflexesParryBonus, 0))
local extraDodge = ply:Dodge() or 0
local agilityDodgeBonus = 3.3 * (ply:Agility() / 5)  -- 3.3% Dodge per 5 Agility
ply:SetDodgeTemporary(math.max(ply:DodgeTemporary() + extraDodge + agilityDodgeBonus, 0))
-- Critical Damage (2.5 Crit Damage per 5 Sly)
local extraSly = ply:Sly() or 0
local slyCritDamageBonus = math.floor(extraSly / 5) * 2.5  -- 2.5 Crit Damage per 5 Sly
local extraCriticalDamage = ply:CriticalDamage() or 0
ply:SetCriticalDamageTemporary(math.max(ply:CriticalDamageTemporary() + slyCritDamageBonus + extraCriticalDamage, 0))
-- Critical Chance (2.5 Crit Chance per 5 Sly)
local extraSly = ply:Sly() or 0
local slyCritChanceBonus = math.floor(extraSly / 5) * 2.5  -- 2.5 Crit Chance per 5 Sly
local extraCriticalChance = ply:CriticalChance() or 0
ply:SetCriticalChanceTemporary(math.max(ply:CriticalChanceTemporary() + slyCritChanceBonus + extraCriticalChance, 0))
-- Sneak (2.5 Sneak per 5 Sly)
local extraSly = ply:Sly() or 0
local slySneakBonus = math.floor(extraSly / 5) * 2.5  -- 2.5 Sneak per 5 Sly
local extraSneak = ply:Sneak() or 0
ply:SetSneakTemporary(math.max(ply:SneakTemporary() + extraSneak + slySneakBonus, 0))
local extraBluntHeadDefense=ply:BluntHeadDefense()or 0
ply:SetBluntHeadDefenseTemporary(math.max(ply:BluntHeadDefenseTemporary()+0+extraBluntHeadDefense,0,0))
local extraBluntChestDefense=ply:BluntChestDefense()or 0
ply:SetBluntChestDefenseTemporary(math.max(ply:BluntChestDefenseTemporary()+0+extraBluntChestDefense,0,0))
local extraBluntArmsDefense=ply:BluntArmsDefense()or 0
ply:SetBluntArmsDefenseTemporary(math.max(ply:BluntArmsDefenseTemporary()+0+extraBluntArmsDefense,0,0))
local extraBluntLegsDefense=ply:BluntLegsDefense()or 0
ply:SetBluntLegsDefenseTemporary(math.max(ply:BluntLegsDefenseTemporary()+0+extraBluntLegsDefense,0,0))
local extraSlashHeadDefense=ply:SlashHeadDefense()or 0
ply:SetSlashHeadDefenseTemporary(math.max(ply:SlashHeadDefenseTemporary()+0+extraSlashHeadDefense,0,0))
local extraSlashChestDefense=ply:SlashChestDefense()or 0
ply:SetSlashChestDefenseTemporary(math.max(ply:SlashChestDefenseTemporary()+0+extraSlashChestDefense,0,0))
local extraSlashArmsDefense=ply:SlashArmsDefense()or 0
ply:SetSlashArmsDefenseTemporary(math.max(ply:SlashArmsDefenseTemporary()+0+extraSlashArmsDefense,0,0))
local extraSlashLegsDefense=ply:SlashLegsDefense()or 0
ply:SetSlashLegsDefenseTemporary(math.max(ply:SlashLegsDefenseTemporary()+0+extraSlashLegsDefense,0,0))
local extraBulletHeadDefense=ply:BulletHeadDefense()or 0
ply:SetBulletHeadDefenseTemporary(math.max(ply:BulletHeadDefenseTemporary()+0+extraBulletHeadDefense,0,0))
local extraBulletChestDefense=ply:BulletChestDefense()or 0
ply:SetBulletChestDefenseTemporary(math.max(ply:BulletChestDefenseTemporary()+0+extraBulletChestDefense,0,0))
local extraBulletArmsDefense=ply:BulletArmsDefense()or 0
ply:SetBulletArmsDefenseTemporary(math.max(ply:BulletArmsDefenseTemporary()+0+extraBulletArmsDefense,0,0))
local extraBulletLegsDefense=ply:BulletLegsDefense()or 0
ply:SetBulletLegsDefenseTemporary(math.max(ply:BulletLegsDefenseTemporary()+0+extraBulletLegsDefense,0,0))
local extraHeatHeadDefense=ply:HeatHeadDefense()or 0
ply:SetHeatHeadDefenseTemporary(math.max(ply:HeatHeadDefenseTemporary()+0+extraHeatHeadDefense,0,0))
local extraHeatChestDefense=ply:HeatChestDefense()or 0
ply:SetHeatChestDefenseTemporary(math.max(ply:HeatChestDefenseTemporary()+0+extraHeatChestDefense,0,0))
local extraHeatArmsDefense=ply:HeatArmsDefense()or 0
ply:SetHeatArmsDefenseTemporary(math.max(ply:HeatArmsDefenseTemporary()+0+extraHeatArmsDefense,0,0))
local extraHeatLegsDefense=ply:HeatLegsDefense()or 0
ply:SetHeatLegsDefenseTemporary(math.max(ply:HeatLegsDefenseTemporary()+0+extraHeatLegsDefense,0,0))
ply:SetResistance(math.max(ply:Resistance(),0,0))

if( ply:IsBot() ) then
ply:SetHeatHeadDefenseTemporary(75)
ply:SetHeatChestDefenseTemporary(100)
ply:SetHeatArmsDefenseTemporary(50)
ply:SetHeatLegsDefenseTemporary(50)
ply:SetSlashHeadDefenseTemporary(30)
ply:SetSlashChestDefenseTemporary(50)
ply:SetSlashArmsDefenseTemporary(25)
ply:SetSlashLegsDefenseTemporary(25)
end


end
end
ODDITY.OnRemoved=function(self,ply)
if(CLIENT)then end
if(SERVER)then
ply:SetAttack(0)
ply:SetMovement(0)
ply:SetSpecial(0)
ply:SetMuscleTemporary(0)
ply:SetAgilityTemporary(0)
ply:SetReflexesTemporary(0)
ply:SetSlyTemporary(0)
ply:SetCoolTemporary(0)
ply:SetSmartsTemporary(0)
ply:SetPersistenceTemporary(0)
ply:SetAccuracyTemporary(0)
ply:SetBluntProficiencyTemporary(0)
ply:SetSlashProficiencyTemporary(0)
ply:SetMartialProficiencyTemporary(0)
ply:SetThreatTemporary(0)
ply:SetParryTemporary(0)
ply:SetDodgeTemporary(0)
ply:SetCriticalDamageTemporary(0)
ply:SetCriticalChanceTemporary(0)
ply:SetSneakTemporary(0)
ply:SetBluntHeadDefenseTemporary(0)
ply:SetBluntChestDefenseTemporary(0)
ply:SetBluntArmsDefenseTemporary(0)
ply:SetBluntLegsDefenseTemporary(0)
ply:SetSlashHeadDefenseTemporary(0)
ply:SetSlashChestDefenseTemporary(0)
ply:SetSlashArmsDefenseTemporary(0)
ply:SetSlashLegsDefenseTemporary(0)
ply:SetBulletHeadDefenseTemporary(0)
ply:SetBulletChestDefenseTemporary(0)
ply:SetBulletArmsDefenseTemporary(0)
ply:SetBulletLegsDefenseTemporary(0)
ply:SetHeatHeadDefenseTemporary(0)
ply:SetHeatChestDefenseTemporary(0)
ply:SetHeatArmsDefenseTemporary(0)
ply:SetHeatLegsDefenseTemporary(0)
ply:SetSneakTemporary(0)
ply:SetAgilityTemporary(0)
ply:SetReflexesTemporary(0)
ply:SetSlyTemporary(0)
ply:SetCoolTemporary(0)
ply:SetSmartsTemporary(0)
ply:SetPersistenceTemporary(0)
ply:SetAccuracyTemporary(0)
ply:SetResistance(0)
end
end