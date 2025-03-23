local meta = FindMetaTable( "Player" );

GM.Oddity = { };

local files = file.Find( GM.FolderName .. "/gamemode/oddities/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ODDITY = { };
		ODDITY.ID				= "";
		ODDITY.Name 			= "";
		ODDITY.Description		= "";
		ODDITY.BuyText			= nil;

		ODDITY.OnPlayerSpawn	= function() end;
		ODDITY.OnPlayerDeath	= function() end;
		ODDITY.OnRemoved		= function() end;
		ODDITY.OnGiven			= function() end;
		ODDITY.Think			= function() end;
		
		AddCSLuaFile( "oddities/" .. v );
		include( "oddities/" .. v );
		
		table.insert( GM.Oddity, ODDITY );
		
		if( !ODDITY.EasterEgg ) then
			
			MsgC( Color( 200, 200, 200, 255 ), "Oddity " .. v .. " loaded.\n" );
			
		end
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No oddities found.", true );
		
	end
	
end

function GM:GetOddityByID( id )
	
	for _, v in pairs( self.Oddity ) do
		
		if( v.ID == id ) then
			
			return v;
			
		end
		
	end
	
end

GM.PlayerAccessors = {
	{ "ToolTrust", 			false, 	"UInt", 	0, 4 },
	{ "PhysTrust", 			false, 	"UInt", 	1, 1 },
	{ "PropTrust", 			false, 	"UInt", 	1, 1 },
	{ "NewbieStatus", 		false, 	"UInt", 	NEWBIE_STATUS_NEW, 1 },
	{ "CustomMaxProps", 	true, 	"UInt", 	0, 16 },
	{ "CustomMaxRagdolls", 	true, 	"UInt", 	0, 16 },
	{ "CharID", 			false, 	"Int", 		-1, 32 },
	{ "RPName", 			false, 	"String", 	"Unconnected" },
	{ "Description",		false, 	"String", 	"" },
	{ "Holstered", 			false, 	"Bit", 		true },
	{ "CID", 				false, 	"UInt", 	0, 17 },
	{ "Money", 				true, 	"UInt", 	0, 32 },
	{ "Trait", 				false, 	"UInt", 	TRAIT_NONE, 32 },
	{ "CombineFlag", 		false, 	"String", 	"" },
	{ "CombineSquad",		false,	"String",	"" },
	{ "CombineSquadID",		false,	"UInt",		0, 8 },
	{ "ActiveFlag", 		false, 	"String", 	"" },
	{ "CharFlags", 			false, 	"String", 	"" },
	{ "Loan", 				false, 	"UInt", 	0, 32 },
	{ "Consciousness", 		true, 	"Float", 	100 },
	{ "PassedOut", 			false, 	"Bit", 		false },
	{ "RadioFreq", 			true, 	"Float", 	0 },

{ "Muscle",                false, "Float",  0 },
{ "MuscleTemporary",       false, "Float",  0 },
{ "Agility",               false, "Float",  0 },
{ "AgilityTemporary",      false, "Float",  0 },
{ "Reflexes",              false, "Float",  0 },
{ "ReflexesTemporary",     false, "Float",  0 },
{ "Sly",                   false, "Float",  0 },
{ "SlyTemporary",          false, "Float",  0 },
{ "Cool",                  false, "Float",  0 },
{ "CoolTemporary",         false, "Float",  0 },
{ "Smarts",                false, "Float",  0 },
{ "SmartsTemporary",       false, "Float",  0 },
{ "Persistence",           false, "Float",  0 },
{ "PersistenceTemporary",  false, "Float",  0 },
{ "Accuracy",              false, "Float",  0 },
{ "AccuracyTemporary",     false, "Float",  0 },
{ "BluntProficiency",      false, "Float",  0 },
{ "BluntProficiencyTemporary", false, "Float",  0 },
{ "SlashProficiency",      false, "Float",  0 },
{ "SlashProficiencyTemporary", false, "Float",  0 },
{ "MartialProficiency",    false, "Float",  0 },
{ "MartialProficiencyTemporary", false, "Float",  0 },
{ "BonusHealth",           false, "Float",  0 },
{ "BonusHealthRegeneration", false, "Float",  0 },
{ "ExtraCarryWeight",      false, "Float",  0 },
{ "Threat",                false, "Float",  0 },
{ "ThreatTemporary",       false, "Float",  0 },
{ "Parry",                 false, "Float",  0 },
{ "ParryTemporary",        false, "Float",  0 },
{ "Dodge",                 false, "Float",  0 },
{ "DodgeTemporary",        false, "Float",  0 },
{ "Movement",              false, "Float",  0 },
{ "Attack",                false, "Float",  0 },
{ "Special",               false, "Float",  0 },
{ "Ultimate",              false, "Float",  0 },
{ "Energy",                false, "Float",  0 },
{ "ExtraMovement",         false, "Float",  0 },
{ "ExtraAttack",           false, "Float",  0 },
{ "ExtraSpecial",          false, "Float",  0 },
{ "ExtraUltimate",         false, "Float",  0 },
{ "ExtraEnergy",           false, "Float",  0 },
{ "CriticalDamage",        false, "Float",  0 },
{ "CriticalDamageTemporary", false, "Float",  0 },
{ "CriticalChance",        false, "Float",  0 },
{ "CriticalChanceTemporary", false, "Float",  0 },
{ "Sneak",                 false, "Float",  0 },
{ "SneakTemporary",        false, "Float",  0 },
{ "BluntHeadDefense",      false, "Float",  0 },
{ "BluntHeadDefenseTemporary", false, "Float",  0 },
{ "BluntChestDefense",     false, "Float",  0 },
{ "BluntChestDefenseTemporary", false, "Float",  0 },
{ "BluntArmsDefense",      false, "Float",  0 },
{ "BluntArmsDefenseTemporary", false, "Float",  0 },
{ "BluntLegsDefense",      false, "Float",  0 },
{ "BluntLegsDefenseTemporary", false, "Float",  0 },
{ "SlashHeadDefense",      false, "Float",  0 },
{ "SlashHeadDefenseTemporary", false, "Float",  0 },
{ "SlashChestDefense",     false, "Float",  0 },
{ "SlashChestDefenseTemporary", false, "Float",  0 },
{ "SlashArmsDefense",      false, "Float",  0 },
{ "SlashArmsDefenseTemporary", false, "Float",  0 },
{ "SlashLegsDefense",      false, "Float",  0 },
{ "SlashLegsDefenseTemporary", false, "Float",  0 },
{ "BulletHeadDefense",     false, "Float",  0 },
{ "BulletHeadDefenseTemporary", false, "Float",  0 },
{ "BulletChestDefense",    false, "Float",  0 },
{ "BulletChestDefenseTemporary", false, "Float",  0 },
{ "BulletArmsDefense",     false, "Float",  0 },
{ "BulletArmsDefenseTemporary", false, "Float",  0 },
{ "BulletLegsDefense",     false, "Float",  0 },
{ "BulletLegsDefenseTemporary", false, "Float",  0 },
{ "HeatHeadDefense",       false, "Float",  0 },
{ "HeatHeadDefenseTemporary", false, "Float",  0 },
{ "HeatChestDefense",      false, "Float",  0 },
{ "HeatChestDefenseTemporary", false, "Float",  0 },
{ "HeatArmsDefense",       false, "Float",  0 },
{ "HeatArmsDefenseTemporary", false, "Float",  0 },
{ "HeatLegsDefense",       false, "Float",  0 },
{ "HeatLegsDefenseTemporary", false, "Float",  0 },
{ "Resistance",            false, "Float",  0 },


	{ "Tracked",				false,	"Bit",		false },
	{ "Revealed",				false,	"Bit",		false },

	{ "Targeted",				false,	"Bit",		false },
	{ "Supressed",				false,	"Bit",		false },
	{ "Stunned",				false,	"Bit",		false },
    { "CrippledArm",				false,	"Bit",		false },
	{ "CrippledLeg",				false,	"Bit",		false },

	{ "GoodGuy",				false,	"Bit",		false },
	{ "BadGuy",				false,	"Bit",		false },
	{ "ReadyUp",				false,	"Bit",		false },

	{ "PVT",				false,	"Bit",		false },
    { "PVTF",				false,	"Bit",		false },
    { "CORP",				false,	"Bit",		false },
    { "SARG",				false,	"Bit",		false },
    { "OFC",				false,	"Bit",		false },

	{ "Downed",				false,	"Bit",		false },

	{ "TiedUp",				false,	"Bit",		false },
	{ "CharCreationDate",	true,	"String",	"" },
	{ "LastLegShot",		false,	"Float",	-20 },
	{ "InAttack2",			false,	"Bit",		false },
	{ "BusinessLicenses",	false,	"Float",	0 },
	{ "Typing",				false,	"UInt",		0, 3 },
	{ "MountedGun",			false,	"Entity",	NULL },
	{ "PropProtection",		true,	"Table",	{ } },
	{ "Bottify",			false,	"Bit",		false },
	{ "RagdollIndex",		false,	"Int",		-1, 16 },
	{ "HideAdmin",			false,	"Bit",		false },
};

for k, v in pairs( GM.PlayerAccessors ) do
	
	meta["Set" .. v[1]] = function( self, val, force )
		
		if( val == nil ) then return end
		
		if( SERVER ) then
			
			if( self[v[1] .. "Val"] == val and v[3] != "Table" and !force ) then return end
			
			self[v[1] .. "Val"] = val;
			
			if( v[2] ) then -- private
				
				if( self:IsBot() ) then return end
				
				net.Start( "nSet" .. v[1] );
					if( v[3] == "UInt" or v[3] == "Int" ) then
						net["Write" .. v[3]]( val, v[5] );
					else
						net["Write" .. v[3]]( val );
					end
				net.Send( self );
				
			else
				
				net.Start( "nSet" .. v[1] );
					net.WriteEntity( self );
					if( v[3] == "UInt" or v[3] == "Int" ) then
						net["Write" .. v[3]]( val, v[5] );
					else
						net["Write" .. v[3]]( val );
					end
				net.Broadcast();
				
			end
			
		else -- We're going to ATTEMPT to predict this...
			
			self[v[1] .. "Val"] = val;
			
		end
		
	end
	
	meta[v[1]] = function( self )
		
		if( self[v[1] .. "Val"] == nil ) then
			return v[4];
		end
		
		if( self[v[1] .. "Val"] == false ) then
			
			return false;
			
		end
		
		return self[v[1] .. "Val"];
		
	end
	
	if( SERVER ) then
		
		util.AddNetworkString( "nSet" .. v[1] );
		
	else
		
		local function nRecvData( len )
			
			if( v[2] ) then -- private
				
				local val;
				if( v[3] == "UInt" or v[3] == "Int" ) then
					val = net["Read" .. v[3]]( v[5] );
				else
					val = net["Read" .. v[3]]();
				end
				
				if( v[3] == "Bit" ) then
					val = tobool( val );
				end
				
				LocalPlayer()[v[1] .. "Val"] = val;
				
			else
				
				local ply = net.ReadEntity();

				local val;
				if( v[3] == "UInt" or v[3] == "Int" ) then
					val = net["Read" .. v[3]]( v[5] );
				else
					val = net["Read" .. v[3]]();
				end
				
				if( v[3] == "Bit" ) then
					val = tobool( val );
				end
				
				ply[v[1] .. "Val"] = val;
				
			end
			
		end
		net.Receive( "nSet" .. v[1], nRecvData );
		
	end
	
end

function meta:SyncAllData( ply )
	
	for _, n in pairs( GAMEMODE.PlayerAccessors ) do
		
		if( !n[2] ) then
			
			net.Start( "nSet" .. n[1] );
				net.WriteEntity( self );
				if( n[3] == "UInt" or n[3] == "Int" ) then
					net["Write" .. n[3]]( self[n[1]]( self ), n[5] );
				else
					net["Write" .. n[3]]( self[n[1]]( self ) );
				end
			if( ply ) then
				net.Send( ply );
			else
				net.Broadcast();
			end
			
		end
		
	end
	
end

function meta:SyncAllOtherData()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v != self ) then
			
			for _, n in pairs( GAMEMODE.PlayerAccessors ) do
				
				if( !n[2] ) then
					
					net.Start( "nSet" .. n[1] );
						net.WriteEntity( v );
						if( n[3] == "UInt" or n[3] == "Int" ) then
							net["Write" .. n[3]]( v[n[1]]( v ), n[5] );
						else
							net["Write" .. n[3]]( v[n[1]]( v ) );
						end
					net.Send( self );
					
				end
				
			end
			
		end
		
	end
	
end

function nRequestPlayerData( len, ply )
	
	if( CLIENT ) then return end
	
	local ent = net.ReadEntity();
	
	ent:SyncAllData( ply );
	
end
net.Receive( "nRequestPlayerData", nRequestPlayerData );

function nRequestAllPlayerData( len, ply )
	
	if( CLIENT ) then return end
	
	if( !ply.NextSyncPlayerData ) then ply.NextSyncPlayerData = 0 end
	
	if( CurTime() < ply.NextSyncPlayerData ) then return end
	
	ply.NextSyncPlayerData = CurTime() + 1;
	
	ply:SyncAllOtherData();
	
end
net.Receive( "nRequestAllPlayerData", nRequestAllPlayerData );

function GM:FormatCID( cid )
	
	local l = string.len( cid );
	
	if( l <= 0 ) then
		
		return "00000";
		
	elseif( l == 1 ) then
		
		return "0000" .. cid;
		
	elseif( l == 2 ) then
		
		return "000" .. cid;
		
	elseif( l == 3 ) then
		
		return "00" .. cid;
		
	elseif( l == 4 ) then
		
		return "0" .. cid;
		
	end
	
	return cid;
	
end

function meta:FormattedCID()
	
	local cid = tostring( self:CID() );
	return GAMEMODE:FormatCID( cid );
	
end

function meta:AddMoney( money )
	
	if( CLIENT ) then return end
	
	self:SetMoney( math.floor( self:Money() + money ) );
	
end

function GM:FreezePlayer( ply, time )
	
	ply.FreezeTime = math.max( ply.FreezeTime or 0, CurTime() + time );
	
end
function GM:Move( ply, move )
	
	if( ply.FreezeTime and CurTime() < ply.FreezeTime ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( GAMEMODE:Combat() == 1 ) then

		if( ply:Movement() < 1 ) then
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
	
	
 end end
	
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	
	return self.BaseClass:Move( ply, move );
	
end
function GM:SetupMove( ply, move )

	if( ply.FreezeTime and CurTime() < ply.FreezeTime ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:PassedOut() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then
		
		move:SetMaxSpeed( 0 );
		move:SetMaxClientSpeed( 0 );
		move:SetVelocity( Vector() );
		
	end
	
	
end

GM.BotDeadRemarks = {
	"",

};

GM.BotTargetedSounds = {
	"",
	
};

function meta:Ragdoll()
	
	if( self:RagdollIndex() == -1 ) then return NULL end
	
	return ents.GetByIndex( self:RagdollIndex() );
	
end

function meta:SetRagdoll( ent )
	
	self:SetRagdollIndex( ent:EntIndex() );
	
end

GM.BotIdleSounds = {
	"",

}

function GM:StartCommand( bot, cmd )
	
	if( !bot:IsBot() and !bot:Bottify() ) then return end
	
	if( !bot.AI ) then bot.AI = { } end
	
	if( !bot.AI.Next ) then bot.AI.Next = CurTime() end
	
	cmd:ClearButtons();
	cmd:ClearMovement();
	cmd:SetViewAngles( bot:EyeAngles() );
	
	if( !bot:Alive() ) then
		
		cmd:SetButtons( IN_JUMP );
		bot.AI.Next = CurTime() + 3;
		bot.AI.Target = nil;
		return;
		
	end
	
	if( bot:PassedOut() ) then
		
		bot.AI.Next = CurTime() + 3;
		bot.AI.Target = nil;
		return;
		
	end
	
	if( bot.AI.Target and bot.AI.Target:IsValid() ) then
		
		if( !bot.AI.Target:Alive() ) then
			
			bot.AI.Target = nil;
			bot.AI.Next = CurTime() + 4;
			
			local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
			local remark = table.Random( self.BotDeadRemarks );
			bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );
			
			return;
			
		end
		
		if( bot.AI.Target:IsBot() or bot.AI.Target:GetNoDraw() ) then
			
			bot.AI.Target = nil;
			return;
			
		end
		
	end
	
	if( !bot.AI.Target or !bot.AI.Target:IsValid() ) then
		
		local dist =400;
		local closest = nil;
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != bot and v:Alive() and !v:InVehicle() and !v:GetNoDraw() ) then
				
				if( bot:CanSee( v ) ) then
					
					local d = v:GetPos():Distance( bot:GetPos() );
					
					if( d < dist ) then
						
						dist = d;
						closest = v;
						
					end
					
				end
				
			end
			
		end
		
		if( closest and closest:IsValid() ) then
			
			bot.AI.Target = closest;
			
			local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
			local remark = table.Random( self.BotTargetedSounds );

				if( bot.AI.Target:IsBot() ) then

				else
			bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );

		end
			return;
			
		end
		
	end
	
	if( !bot.AI.Target or !bot.AI.Target:IsValid() ) then return end
	
	local eyeang = ( bot.AI.Target:EyePos() - bot:EyePos() ):GetNormal():Angle();
	
	eyeang.p = math.NormalizeAngle( eyeang.p );
	eyeang.y = math.NormalizeAngle( eyeang.y );
	eyeang.r = math.NormalizeAngle( eyeang.r );
	
	local dist = bot:GetPos():Distance( bot.AI.Target:GetPos() );


		if( bot.AI.Target:IsAdmin() ) then
	

		if dist < 50 then
					cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_SPEED))
						cmd:SetForwardMove(bot:GetMaxSpeed())
			cmd:SetForwardMove(bot:GetMaxSpeed())
		
	end
end


	if( CurTime() >= bot.AI.Next ) then
		
		if( dist <= 50 ) then
			
			if( bot:Gender() != GENDER_FEMALE and bot.AI.Target:Gender() == GENDER_FEMALE ) then
				
				bot:EmitSound( Sound( "vo/npc/male01/hi0" .. math.random( 1, 2 ) .. ".wav" ), 80 );
				bot.AI.Next = CurTime() + 0.2;
				
			else
				
				if( math.random( 1, 3 ) == 1 ) then
					
					local gender = ( bot:Gender() == GENDER_FEMALE ) and "female" or "male";
					local remark = table.Random( self.BotIdleSounds );
					bot:EmitSound( Sound( "*vo/npc/" .. gender .. "01/" .. remark .. ".wav" ), 80 );
					
				end
				
				bot.AI.Next = CurTime() + math.random( 20, 30 );
				
			end
			
			return;
			
		end
		
		bot.AI.Next = CurTime() + 0.1;
		
	end
	
	cmd:SetViewAngles( eyeang );
	bot:SetEyeAngles( eyeang );
	
end

function meta:HasPlayerModel()
	
	if( string.find( string.lower( self:GetModel() ), "/player/" ) ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:HasVortigauntModel()
	
	if( self:GetModel() == "models/vortigaunt.mdl" or self:GetModel() == "models/vortigaunt_slave.mdl" or self:GetModel() == "models/vortigaunt_doctor.mdl" ) then
		
		return true;
		
	end
	
	return false;
	
end


function GM:PlayerFootstep( ply, pos, foot, s, vol, rf )
	
	if( ply:GetModel() == "models/player/stanmcg/enforcer/enforcer_custom_clean_playermodel.mdl" or ply:GetModel() == "models/dpfilms/metropolice/playermodels/pm_hdpolice.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_female_police2.mdl" or ply:GetModel() == "models/dpfilms/metropolice/playermodels/pm_hl2concept.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_eliteshockcp_v2.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_eliteshockcp.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_leet_police_v2.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_leet_police.mdl" or ply:GetModel() == "models/metropolice/playermodels/pm_cmd_police_v2.mdll" or ply:GetModel() == "models/metropolice/playermodels/pm_cmd_police.mdl" or ply:GetModel() == "models/dpfilms/metropolice/playermodels/pm_phoenix_police.mdl" ) then
		
		if( ply:GetVelocity():Length2D() > 150 ) then
			if( foot == 0 ) then
				ply:EmitSound( "npc/dog/dog_footstep_run1.wav", 75, 100, 0.15 );
			else
				ply:EmitSound( "npc/dog/dog_footstep_run2.wav", 75, 100, 0.15 );
			end
		else
			if( foot == 0 ) then
				ply:EmitSound( "npc/dog/dog_footstep3.wav", 75, 100, 0.15  );
			else
				ply:EmitSound( "npc/dog/dog_footstep4.wav", 75, 100, 0.15  );
			end
		end
		
		return;
		
	end
	
	if( ply:HasVortigauntModel() ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_Vortigaunt.FootstepLeft" );
		else
			ply:EmitSound( "NPC_Vortigaunt.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/stalker.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_Stalker.FootstepLeft" );
		else
			ply:EmitSound( "NPC_Stalker.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/classic.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "Zombie.FootstepLeft" );
		else
			ply:EmitSound( "Zombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/fast.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_FastZombie.FootstepLeft" );
		else
			ply:EmitSound( "NPC_FastZombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/poison.mdl" ) then
		
		if( foot == 0 ) then
			ply:EmitSound( "NPC_PoisonZombie.FootstepLeft" );
		else
			ply:EmitSound( "NPC_PoisonZombie.FootstepRight" );
		end
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrabclassic.mdl" or ply:GetModel() == "models/lamarr.mdl" ) then
		
		ply:EmitSound( "NPC_Headcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrab.mdl" ) then
		
		ply:EmitSound( "NPC_FastHeadcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/headcrabblack.mdl" ) then
		
		ply:EmitSound( "NPC_BlackHeadcrab.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/antlion.mdl" ) then
		
		ply:EmitSound( "NPC_Antlion.Footstep" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/antlion_guard.mdl" ) then
		
		ply:EmitSound( "NPC_AntlionGuard.StepHeavy" );
		
		return;
		
	end
	
	if( ply:GetModel() == "models/zombie/zombie_soldier.mdl" ) then
	
		if( ply:GetVelocity():Length2D() > 150 ) then
			if( foot == 0 ) then
				ply:EmitSound( "Zombine.ScuffRight" );
			else
				ply:EmitSound( "Zombine.ScuffLeft" );
			end
		else
			if( foot == 0 ) then
				ply:EmitSound( "Zombine.ScuffRight" );
			else
				ply:EmitSound( "Zombine.ScuffLeft" );
			end
		end
		
		return;
		
	end
	
	self.BaseClass:PlayerFootstep( ply, pos, foot, s, vol, rf );
	
end

function meta:GetSpeeds()
	



	local w = 90;
	local r = 150 
	local j = 160 + self:Agility() * 0.5;
	local c = 90;
	if( GAMEMODE:Combat() == 1 ) then
	if  self:Movement() < 1 then
j = 0
	end end
	
	if( self:InventoryWeight() > self:InventoryMaxWeight() ) then
		
		w = 40;
		r = 40;
		c = 40;
		
	end
	
	return w, r, j, c;
	
end

function player.GetCombine()
	
	local tab = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:HasAnyCombineFlag() ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

function player.GetActiveCombine()
	
	local tab = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( GAMEMODE:LookupCombineFlag( v:ActiveFlag() ) ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

function player.GetByCharID( id )
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:CharID() == id ) then
			
			return v;
			
		end
		
	end
	
end

function meta:HasCombineModel()
	
	if( string.find( string.lower( self:GetModel() ), "police" ) ) then return true end
	return false;
	
end

function meta:VisibleRPName()
	
	local flag = GAMEMODE:LookupCombineFlag( self:ActiveFlag() );
	
	if( flag ) then
		
		return GAMEMODE:CPName( self:RPName(), self:CombineSquad(), self:CombineSquadID(), self:FormattedCID(), flag );
		
	end
	
	return self:RPName();
	
end

function GM:CPName( name, squad, squadid, cid, flag )
	
	local nameformat = "$CID";
	if( flag and flag.CharName ) then
		nameformat = flag.CharName;
	end
	
	if( squad == "" ) then squad = "UNASSIGNED"; end
	
	nameformat = string.gsub( nameformat, "$SQUAD", squad );
	nameformat = string.gsub( nameformat, "$ID", squadid );
	nameformat = string.gsub( nameformat, "$CID", cid );
	
	return nameformat;
	
end
