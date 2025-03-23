AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/sire/workingjoe_nolod.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 20
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CYBORG"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"meleeattack01"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 15 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.3 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 5, 6 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.FollowPlayer = false
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {"SCHED_FLINCH_PHYSICS"} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"step/stepping1.wav"}
ENT.SoundTbl_Idle = {"joe/idle10.wav", "joe/idle12.wav", "joe/idle14.wav", "joe/idle17.wav", "joe/idle19.wav", "joe/idle25.wav", "joe/idle26.wav", "joe/idle31.wav", "joe/idle51.wav", "joe/idle61.wav", "joe/idle9.wav", "joe/idle83.wav"}
ENT.SoundTbl_Alert = {"joe/playersight2.wav", "joe/playersight7.wav", "joe/playersight9.wav", "joe/follow1.wav", "joe/follow2.wav", "joe/follow3.wav", "joe/follow4.wav", "joe/follow5.wav"}
ENT.SoundTbl_MeleeAttack = {"joe/combatidle9.wav", "joe/combatidle8.wav", "joe/combatidle11.wav", "joe/combatidle17.wav", "joe/combatidle1.wav", "joe/combatidle6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"joe/combatidle9.wav", "joe/combatidle8.wav", "joe/combatidle11.wav", "joe/combatidle17.wav", "joe/combatidle1.wav", "joe/combatidle6.wav"}
ENT.SoundTbl_Pain = {"joe/pain1.wav", "joe/pain24.wav", "joe/pain8.wav", "joe/pain20.wav"}
ENT.SoundTbl_Death = {"joe/death12.wav"}

function ENT:CustomOnThink_AIEnabled()
	self:SetMovementActivity(ACT_WALK)
end
