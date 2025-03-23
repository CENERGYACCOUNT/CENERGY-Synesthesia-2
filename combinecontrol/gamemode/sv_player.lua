local meta = FindMetaTable( "Player" );

GM.CombineRadioFreq = 584; -- dick weed

function GM:PlayerInitialSpawn( ply )
	
	if( !self.FullyLoaded ) then
		
		self:LogBug( "ERROR: PlayerInitialSpawn on player " .. ply:Nick() .. " before gamemode fully loaded." );
		return;
		
	end
	
	self.BaseClass:PlayerInitialSpawn( ply );
	
	ply:SetCustomCollisionCheck( true );
	ply:SetCanZoom( false );
	ply:Freeze( true );


	ply.AFKTime = CurTime();
	
	if( ply:IsBot() ) then
		
		return;
		
	end
	
	ply.SQLPlayerData = { };
	ply.SQLCharData = { };
	
	ply:SetHolstered( true );
	
end

function GM:PlayerInitialSpawnSafe( ply )
	
	ply:SetModelCC( table.Random( { "models/crow.mdl", "models/pigeon.mdl", "models/seagull.mdl" } ) );
	ply:LoadPlayerInfo();
	ply:SetRadioFreq( math.random( 0, 999 ) );
	ply:SyncAllGlobalData();
	ply:SetNotSolid( true );
	ply:SetMoveType( MOVETYPE_NOCLIP );
	ply:requestContainers();
end

function GM:PlayerCheckFlag( ply, respawn )
	
	local CHANNEL = 1000
	-- Custom LOCAL's.
	local FLAG_CP = GAMEMODE:LookupCombineFlag( ply:ActiveFlag() )
	local FLAG_COTA = ply:HasCharFlag( "O" ) or ply:HasCharFlag( "P" )
	local FLAG_CIVIL = ply:HasCharFlag( "A" )
	local FLAG_DNA = ply:HasCharFlag( "C" )
	
	local OKAY = FLAG_CP or FLAG_COTA or FLAG_CIVIL or FLAG_DNA
	local CHAR_FLAGS = FLAG_CIVIL or FLAG_DNA
	
	-- Default LOCAL's.
	local flagtab = self:LookupCharFlag( ply:CharFlags() );
	local flag = self:LookupCombineFlag( ply:ActiveFlag() );
	local hasany = ply:HasAnyCombineFlag();
	local owe = ply:HasCharFlag( "O" ) or ply:HasCharFlag( "P" )
		
	if( #flagtab > 0 ) then
		
		ply:SetRadioFreq( math.random( 0, 999 ) );
		
		for _, v in pairs( flagtab ) do
			
			if( !v.Additive ) then
				
				ply:SetPlayerColor( Vector( v.Color.r, v.Color.g, v.Color.b ) / 255 );
				
				if( v.Team ) then
					
					ply:SetTeam( v.Team );
					
				end
				
				ply:SetModelCC( v.ModelFunc( ply ) );
				if( v.SetupModel ) then
					v.SetupModel( ply );
				end
				
			else
				
				ply:SetModelCC( ply.CharModel );
				
			end
			
			v.OnSpawn( ply );
			
		end
		
	elseif( flag ) then
		
		ply:SetModelCC( flag.ModelFunc( ply ) );
		if( flag.SetupModel ) then
			flag.SetupModel( ply );
		end
		
		ply:SetPlayerColor( Vector( flag.Color.r, flag.Color.g, flag.Color.b ) / 255 );
		
		ply:SetRadioFreq( self.CombineRadioFreq );

	elseif( ply.CharModel ) then
		
		ply:SetRadioFreq( math.random( 0, 999 ) );
		
		ply:SetModelCC( ply.CharModel );
end
	
	self:RefreshNPCRelationships();
	
	if( ply.EntryPort and self.EntryPortSpawns[ply.EntryPort] ) then
		
		ply:SetPos( table.Random( self.EntryPortSpawns[ply.EntryPort] ) );
		return;
		
	end end

function GM:PlayerCheckInventory( ply )
	
	for _, v in pairs( ply.Inventory ) do
		
		if( !GAMEMODE:GetItemByID( v ) ) then continue end
		
		GAMEMODE:GetItemByID( v ).OnPlayerSpawn( v, ply );
		
	end
	
end

function GM:PlayerConnect( name, ip )
	

end

function GM:PlayerSpawn( ply )
	
	self.BaseClass:PlayerSpawn( ply );
	
	player_manager.SetPlayerClass( ply, "player_cc" );
	
	ply:SetNoCollideWithTeammates( false );
	ply:SetAvoidPlayers( false );
	
	ply:SetDuckSpeed( 0.3 );
	ply:SetUnDuckSpeed( 0.3 );
    ply:SetGravity( 1 )
	ply:SetHolstered( true );
	ply:SetDowned( false );
	ply:SetTiedUp( false );
		
	ply:AllowFlashlight( true );
	ply:SetConsciousness( 100 );
    ply:GiveOddityWeapons()  -- Give weapons from oddities
	
	ply.DrownDamage = 0;
	
	ply.Uniform = nil;


	
	ply:SetNotSolid( false );
	ply:SetMoveType( MOVETYPE_WALK );
	
	if( ply:Ragdoll() and ply:Ragdoll():IsValid() ) then
		
		ply:Ragdoll():Remove();
		
	end

          

	
	if( ply:IsBot() ) then
		
		if( !ply.CharCreateCompleted ) then
			
		local data = { };
			data.Date = os.date( "!%m/%d/%y %H:%M:%S" );
			data.RPName = ply:Nick();
			data.Model = table.Random( self.CitizenModels );
			data.CID = math.random( 1, 99999 );
			data.Money = 200;
			data.Loan = 500;
			data.CombineFlag = "";
			data.CharFlags = "";
			data.CombineSquad = "";
			data.CombineSquadID = 0;
			data.Inventory = "";
			data.Oddities = "";
			data.BulletChestDefense = 0;
			data.BulletHeadDefense = 0;
			data.BulletArmtDefense = 0;
			data.BulletLegsDefense = 0;
			data.SlashChestDefense = 0;
			data.SlashHeadDefense = 0;
			data.SlashArmtDefense = 0;
			data.SlashLegsDefense = 0;
			data.BusinessLicenses = 0;
			data.CombineAppStatus = 0;
			data.CombineAppDate = "";
			data.CriminalRecord = "";
	
	

			data.Title = "This bot, named " .. ply:Nick() .. ", was born today out of a Xen portal anomaly. They don't remember much, as they have no memories, and their motor functions are extremely hindered by the fact that they have no brain. They cannot speak, simply existing as a shell, forever doomed to wander around Garry's Mod roleplay servers, fruitlessly.";
			
			ply:LoadCharacter( data );
			
		end
		
		self:PlayerCheckFlag( ply );
		self:PlayerCheckInventory( ply, true );
		
		return;
		
	end
	
	if( !ply.InitialSafeSpawn ) then
		
		ply.InitialSafeSpawn = true;
		self:PlayerInitialSpawnSafe( ply );
		
	end
	
	if( !ply.CharCreateCompleted ) then return end
	
	self:PlayerCheckFlag( ply, true );
	self:PlayerCheckInventory( ply );
	
end

function GM:PlayerFlagLoadout( ply )
	
	local flagtab = self:LookupCharFlag( ply:CharFlags() );
	
	if( #flagtab > 0 ) then
		
		for _, v in pairs( flagtab ) do
			
			for _, n in pairs( v.Loadout ) do
				
				ply:Give( n );
				
			end
			
			for _, n in pairs( v.ItemLoadout ) do
				
				if( !ply:HasItem( n ) ) then
					
					ply:GiveItem( n, 1 );
					
				end
				
			end
			
			if( v.Additive ) then
				
				ply:Give( "weapon_cc_hands" );
				ply:Give( "ability_push" );
				ply:Give( "ability_rally" );
				ply:Give( "ability_readyup" );
				ply:Give( "ability_dash" );

			end
			
		end
		
	else
		
		local flag = self:LookupCombineFlag( ply:ActiveFlag() );
		
		if( flag ) then
			
			for _, n in pairs( flag.Loadout ) do
				
				if( !ply:HasItem( n ) ) then
					
					ply:GiveItem( n, 1 );
					
				end
				
			end
			
		end
		
		ply:Give( "weapon_cc_hands" );
		ply:Give( "ability_push" );
		ply:Give( "ability_rally" );
		ply:Give( "ability_readyup" );
		ply:Give( "ability_dash" );
		
	end
	
end

function GM:PlayerLoadout( ply )
	
	if( !ply.CharCreateCompleted ) then return end
	
	GAMEMODE:PlayerFlagLoadout( ply );
	
		ply:Give( "weapon_cc_hands" );
		ply:Give( "ability_push" );
		ply:Give( "ability_readyup" );
		ply:Give( "ability_rally" );
		ply:Give( "ability_dash" );
		ply:Give( "weapon_physgun" );
		ply:Give( "gmod_tool" );
		
	
end

function meta:LoadPlayer( data )
	
	self:SetToolTrust( tonumber( data.ToolTrust ), true );
	self:SetPhysTrust( tonumber( data.PhysTrust ), true );
	self:SetPropTrust( tonumber( data.PropTrust ), true );
	self:SetNewbieStatus( tonumber( data.NewbieStatus ), true );
	self:SetCustomMaxProps( tonumber( data.CustomMaxProps ), true );
	self:SetCustomMaxRagdolls( tonumber( data.CustomMaxRagdolls ), true );
	
end

function nRequestPData( len, ply )
	
	if( !ply.RequestedPData ) then
		
		ply:LoadPlayer( ply.SQLPlayerData );
		ply.RequestedPData = true;
		
	end
	
end
net.Receive( "nRequestPData", nRequestPData );

function meta:LoadCharacter( data )
	
	self.CharCreateCompleted = true;
	self:Freeze( false );
	
	self:StripWeapons();
	self:ClearDrug();
	
	self:SetTeam( TEAM_CITIZEN );
	self:SetActiveFlag( "" );
	
	self:SetCharCreationDate( data.Date );
	
	self:SetCharID( tonumber( data.id ) );
	
	self:SetRPName( data.RPName );
	self:SetDescription( data.Title );
	
	self.CharModel = data.Model;
	
	self:SetTrait( tonumber( data.Trait ) );
	
if(( self:HasItem "rankpvt" )) then   self:SetPVT(true) end

	self:SetCID( data.CID );
	self:SetMoney( tonumber( data.Money ) );
	self:SetMuscle(tonumber(data.StatMuscle));
	
self:SetMuscle(tonumber(data.StatMuscle));
self:SetAgility(tonumber(data.StatAgility));
self:SetReflexes(tonumber(data.StatReflexes));
self:SetSly(tonumber(data.StatSly));
self:SetCool(tonumber(data.StatCool));
self:SetSmarts(tonumber(data.StatSmarts));
self:SetPersistence(tonumber(data.StatPersistence));
self:SetAccuracy(tonumber(data.StatAccuracy));
self:SetBluntProficiency(tonumber(data.StatBluntProficiency));
self:SetSlashProficiency(tonumber(data.StatSlashProficiency));
self:SetMartialProficiency(tonumber(data.StatMartialProficiency));
self:SetBonusHealth(tonumber(data.StatBonusHealth));
self:SetBonusHealthRegeneration(tonumber(data.StatBonusHealthRegeneration));
self:SetExtraCarryWeight(tonumber(data.StatExtraCarryWeight));
self:SetThreat(tonumber(data.StatThreat));
self:SetParry(tonumber(data.StatParry));
self:SetDodge(tonumber(data.StatDodge));
self:SetMovement(tonumber(data.StatMovement));
self:SetAttack(tonumber(data.StatAttack));
self:SetSpecial(tonumber(data.StatSpecial));
self:SetUltimate(tonumber(data.StatUltimate));
self:SetEnergy(tonumber(data.StatEnergy));
self:SetExtraMovement(tonumber(data.StatExtraMovement));
self:SetExtraAttack(tonumber(data.StatExtraAttack));
self:SetExtraSpecial(tonumber(data.StatExtraSpecial));
self:SetExtraUltimate(tonumber(data.StatExtraUltimate));
self:SetExtraEnergy(tonumber(data.StatExtraEnergy));
self:SetCriticalDamage(tonumber(data.StatCriticalDamage));
self:SetCriticalChance(tonumber(data.StatCriticalChance));
self:SetSneak(tonumber(data.StatSneak));
self:SetBluntHeadDefense(tonumber(data.StatBluntHeadDefense));
self:SetBluntChestDefense(tonumber(data.StatBluntChestDefense));
self:SetBluntArmsDefense(tonumber(data.StatBluntArmsDefense));
self:SetBluntLegsDefense(tonumber(data.StatBluntLegsDefense));
self:SetSlashHeadDefense(tonumber(data.StatSlashHeadDefense));
self:SetSlashChestDefense(tonumber(data.StatSlashChestDefense));
self:SetSlashArmsDefense(tonumber(data.StatSlashArmsDefense));
self:SetSlashLegsDefense(tonumber(data.StatSlashLegsDefense));
self:SetBulletHeadDefense(tonumber(data.StatBulletHeadDefense));
self:SetBulletChestDefense(tonumber(data.StatBulletChestDefense));
self:SetBulletArmsDefense(tonumber(data.StatBulletArmsDefense));
self:SetBulletLegsDefense(tonumber(data.StatBulletLegsDefense));
self:SetHeatHeadDefense(tonumber(data.StatHeatHeadDefense));
self:SetHeatChestDefense(tonumber(data.StatHeatChestDefense));
self:SetHeatArmsDefense(tonumber(data.StatHeatArmsDefense));
self:SetHeatLegsDefense(tonumber(data.StatHeatLegsDefense));

	self:SetLoan( tonumber( data.Loan ) );
	self:SetBusinessLicenses( tonumber( data.BusinessLicenses ) );
	self:LoadItemsFromString( data.Inventory );
    self:LoadOdditiesFromString( data.Oddities );

	

	self.EntryPort = tonumber( data.EntryPort );
	
	self:UpdateCharacterField( "LastOnline", os.date( "!%m/%d/%y %H:%M:%S" ) );
	
	if( self:IsBot() ) then return end
	
	self:SyncAllOtherData();
	
	self:PostLoadCharacter();
	
	self:Spawn();
	
end

function meta:PostLoadCharacter()
	
end

function GM:SpeedThink(ply)
    local walk, run, jump, crouch = ply:GetSpeeds()


hook.Add("StartCommand", "ForceCrouch", function(ply, cmd)
    if ply:IsValid() and ply:Downed() then
        cmd:RemoveKey(IN_JUMP)  -- Prevent them from jumping
        cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK)) -- Force crouch
    end
end)

    -- Update player speeds if they don't match the desired values
    if ply:GetRunSpeed() ~= run then
        ply:SetRunSpeed(run)
    end

    if ply:GetWalkSpeed() ~= walk then
        ply:SetWalkSpeed(walk)
    end

    if ply:GetJumpPower() ~= jump then
        ply:SetJumpPower(jump)
    end

    if ply:GetCrouchedWalkSpeed() ~= math.floor(crouch / walk) then
        ply:SetCrouchedWalkSpeed(math.floor(crouch / walk))
    end

    -- Deduct Movement for each step
    if ply:OnGround() then
        if not ply.LastPosition then
            ply.LastPosition = ply:GetPos() -- Initialize last position
        end

        local distanceMoved = ply:GetPos():Distance(ply.LastPosition)

        if distanceMoved >= 20 then -- Adjust threshold for "step" detection
            if not ply.NextStepStat or CurTime() >= ply.NextStepStat then
                ply.NextStepStat = CurTime() + 0.5 -- Rate limit Movement deduction
                ply:SetMovement(math.Clamp(ply:Movement() - 1, 0, 1000)) -- Movement can't go below 0
            end

            ply.LastPosition = ply:GetPos() -- Update last position
        end
    else
        ply.LastPosition = nil -- Reset last position if the player is not on the ground
    end

    -- Deduct Movement for jumping and prevent jumping if no Movement
    if ply:OnGround() == false and ply:KeyPressed(IN_JUMP) then
        if ply:Movement() > 0 then
            if not ply.NextJumpStat or CurTime() >= ply.NextJumpStat then
                ply.NextJumpStat = CurTime() + 0.5 -- Rate limit Movement deduction for jumping
                ply:SetMovement(math.Clamp(ply:Movement() - 1, 0, 1000)) -- Deduct 1 Movement on jump
            end
       
        end
    end
end


function GM:FindUseEntity( ply, ent )
	
	if( ply:PassedOut() ) then return; end
	if( ply:TiedUp() and !( ent and ent:IsValid() and ent:IsVehicle() ) ) then return; end
	if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return ply:MountedGun() end

		
	



	
	return self.BaseClass:FindUseEntity( ply, ent );
	
end

function GM:PlayerUse( ply, ent )
	
	return self.BaseClass:PlayerUse( ply, ent );
	
end

function GM:KeyPress( ply, key )
	
	if( key == IN_USE ) then
		
		if( ply:HasAnyCombineFlag() ) then
			
			local tr = self:GetHandTrace( ply, 100 );
			
			if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsDoor() and tr.Entity:DoorType() == DOOR_COMBINEOPEN ) then
				
				tr.Entity:Fire( "Open" );
				
			end
			
		end
		
	end
	
end

function GM:PlayerSay( ply, text, t )
	
	return "";
	
end

function ccCSay( ply, cmd, args )
	
	if( ply:EntIndex() != 0 ) then return end
	
	local text = "";
	
	for i = 1, #args do
		
		text = text .. args[i] .. " ";
		
	end
	
	text = string.Trim( text );
	
	net.Start( "nConSay" );
		net.WriteString( text );
	net.Broadcast();
	
end
concommand.Add( "csay", ccCSay );

function GM:PlayerDeathSound()
	
	return true;
	
end

function GM:EntityTakeDamage(ent, dmg)
    if ent:GetClass() == "prop_ragdoll" then
        if dmg:GetDamageType() == DMG_SLASH then return end
        local pdmg = DamageInfo()
        pdmg:SetAttacker(dmg:GetAttacker())
        pdmg:SetDamage(dmg:GetDamage())
        pdmg:SetDamageForce(dmg:GetDamageForce())
        pdmg:SetDamagePosition(ent:GetPos())
        pdmg:SetInflictor(dmg:GetInflictor())
    end

    if ent:IsVehicle() and ent:GetDriver() and ent:GetDriver():IsValid() then
        if dmg:GetDamageType() == DMG_CRUSH then return end
        local pdmg = DamageInfo()
        pdmg:SetAttacker(dmg:GetAttacker())
        pdmg:SetDamage(dmg:GetDamage())
        pdmg:SetDamageForce(dmg:GetDamageForce())
        pdmg:SetDamagePosition(ent:GetPos())
        pdmg:SetInflictor(dmg:GetInflictor())

        ent:GetDriver():TakeDamageInfo(pdmg)
    end

    if ent:IsPlayer() then
        if dmg:IsDamageType(DMG_BURN) or dmg:IsDamageType(DMG_BLAST) then
            -- Get defense values dynamically
            local armDef = (ent.HeatArmsDefenseTemporary and ent:HeatArmsDefenseTemporary()) or 0
            local headDef = (ent.HeatHeadDefenseTemporary and ent:HeatHeadDefenseTemporary()) or 0
            local legDef = (ent.HeatLegsDefenseTemporary and ent:HeatLegsDefenseTemporary()) or 0
            local chestDef = (ent.HeatChestDefenseTemporary and ent:HeatChestDefenseTemporary()) or 0

            -- Calculate average resistance
            local resistance = (armDef + headDef + legDef + chestDef) / 4
            resistance = math.Clamp(resistance, 0, 100) -- Ensure within bounds

            -- Apply resistance to damage
            local finalDamage = dmg:GetDamage() * (1 - (resistance / 100))
            dmg:ScaleDamage(finalDamage / dmg:GetDamage())

            -- Reduce defense stats based on 33% of final damage taken
            local damageReduction = finalDamage * 0.33 -- 33% of damage

            -- Reduce each defense stat, ensuring they don't go below 0
            if ent.SetHeatArmsDefenseTemporary then
                ent:SetHeatArmsDefenseTemporary(math.max(armDef - damageReduction, 0))
            end
            if ent.SetHeatHeadDefenseTemporary then
                ent:SetHeatHeadDefenseTemporary(math.max(headDef - damageReduction, 0))
            end
            if ent.SetHeatLegsDefenseTemporary then
                ent:SetHeatLegsDefenseTemporary(math.max(legDef - damageReduction, 0))
            end
            if ent.SetHeatChestDefenseTemporary then
                ent:SetHeatChestDefenseTemporary(math.max(chestDef - damageReduction, 0))
            end
        end
    end

if ent:IsPlayer() then
    if ent:IsBot() then return end
    
    if ent:Downed() then
        dmg:ScaleDamage(0.25)
        

  
    else
        if dmg:GetDamage() > ent:Health() then
            dmg:ScaleDamage(0.0)
            ent:SetHealth(25)
            if not ent:HasOddity("abilitydeathwish") then
                ent:SetTiedUp(true)
            end
            
            -- Add injury mechanism right before SetDowned
            -- If the player doesn't have any injury light oddity, give them a random light injury (1-5)
            if not (ent:HasOddity("injurylight1") or ent:HasOddity("injurylight2") or ent:HasOddity("injurylight3") or ent:HasOddity("injurylight4") or ent:HasOddity("injurylight5")) then
                local injuryLight = "injurylight" .. math.random(1, 5)  -- Randomly pick a light injury
                ent:GiveOddity(injuryLight)
            else

        -- After going down, check if the player has a heavy injury and kill them if so
        if ent:HasOddity("injuryheavy1") or ent:HasOddity("injuryheavy2") or ent:HasOddity("injuryheavy3") or ent:HasOddity("injuryheavy4") or ent:HasOddity("injuryheavy5") then
            ent:Kill()  -- Kill the player if they have a heavy injury
            return
        end
            	
                -- If the player has a light injury, randomly assign a heavy injury (1-5)
                if ent:HasOddity("injurylight1") then
                    ent:GiveOddity("injuryheavy" .. math.random(1, 5))  -- Randomly pick a heavy injury (1-5)
                elseif ent:HasOddity("injurylight2") then
                    ent:GiveOddity("injuryheavy" .. math.random(1, 5))
                elseif ent:HasOddity("injurylight3") then
                    ent:GiveOddity("injuryheavy" .. math.random(1, 5))
                elseif ent:HasOddity("injurylight4") then
                    ent:GiveOddity("injuryheavy" .. math.random(1, 5))
                elseif ent:HasOddity("injurylight5") then
                    ent:GiveOddity("injuryheavy" .. math.random(1, 5))
                end
            end

            -- Set the player as downed
            ent:SetDowned(true)
            return
        end
    end
end



    if ent:IsPlayer() then
        if ent:IsEFlagSet(EFL_NOCLIP_ACTIVE) or ent:Team() == TEAM_UNASSIGNED then
            dmg:ScaleDamage(0)
            return
        end    
    end

    if ent:IsNPC() then
        ent:AddEntityRelationship(dmg:GetAttacker(), D_HT, 99)
    end
end



function GM:DoPlayerDeath( ply, attacker, dmg )
	
	if( ply.Inventory ) then
		
		for _, v in pairs( ply.Inventory ) do
			
			if( GAMEMODE:GetItemByID( v ) and GAMEMODE:GetItemByID( v ).OnPlayerDeath ) then
				
				GAMEMODE:GetItemByID( v ).OnPlayerDeath( v, ply );
				
			end
			
		end
		
	end
	
	if( self:LookupCombineFlag( ply:ActiveFlag() ) ) then

	else
	
	end
	
	if( self.UntieOnDeath ) then
		ply:SetDowned( false );
		ply:SetTiedUp( false );
		
	end
	
	if( !ply:PassedOut() ) then
		
		ply:CreateRagdoll();
		
	end
	
end

function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
    -- Check if player is in noclip or unassigned team

    if ply:IsEFlagSet(EFL_NOCLIP_ACTIVE) or ply:Team() == TEAM_UNASSIGNED then
        dmginfo:ScaleDamage(0)
        return
    end
end

function GM:GetFallDamage( ply, speed )
	
	local b = 15



if (ply:HasOddity ("rolemonkey") ) then
else

		ply:EmitSound( "Flesh.Break" );
		
	return self.BaseClass:GetFallDamage( ply, speed );
	end end
	



function GM:CanPlayerSuicide( ply )

return true
	
end

function GM:PlayerShouldTakeDamage( ply, attacker )
	
	if( attacker:GetClass() == "prop_physics" or attacker:GetClass() == "prop_ragdoll" or attacker:GetClass() == "cc_item" ) then return false end
	
	return true;
	
end

function GM:EntityRemoved( ent )
	
	if( ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:RagdollIndex() == ent:EntIndex() ) then
				
				v:SetRagdollIndex( -1 );
				
			end
			
		end
		
	end
	


end

function GM:PlayerDisconnected( ply )

end
function GM:ShutDown()
	
	for _, ply in pairs( player.GetAll() ) do
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( table.HasValue( v:DoorOwners(), ply:CharID() ) ) then
				
				if( table.Count( v:DoorOwners() ) == 1 ) then
					
					ply:SellDoor( v );
					
				else
					
					ply:RemoveDoorOwner( v );
					
				end
				
			end
			
			if( table.HasValue( v:DoorAssignedOwners(), ply ) ) then
				
				ply:RemoveDoorAssignedOwner( v );
				
			end
			
		end
		
	end
	
end

function GM:PlayerSpray( ply )
	
	return game.IsDedicated();
	
end

function GM:PlayerCanHearPlayersVoice( targ, ply )
	
	return !game.IsDedicated();
	
end

function GM:PlayerShouldTaunt( ply, act )
	
	return false;
	
end



function nSetTyping( len, ply )
	
	local val = net.ReadUInt( 2 );
	ply:SetTyping( val );
	
end
net.Receive( "nSetTyping", nSetTyping );


function nCPPK( len, ply )
	
	local cid = net.ReadUInt( 32 );
	local name = net.ReadString();
	
	if( GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditCPs ) then
		
		GAMEMODE:DeleteCharacter( cid, ply:RPName(), name );
		
	end
	
end
net.Receive( "nCPPK", nCPPK );

function GM:PlayerButtonDown( ply, btn )
	
	if( SERVER ) then
		
		ply.AFKTime = CurTime();
		
	end
	
	self.BaseClass:PlayerButtonDown( ply, btn );
	
end
