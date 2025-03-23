GM.ServerConnectIDs = { };

function GM:InitPostEntity()
	if self.containerData then
		for _, v in pairs(self.containerData) do
			local ent = ents.Create("cc_container")
			ent:SetPos(v[1])
			ent:SetAngles(v[2])
			ent.id = v[3]
			ent.containerType = v[4]
			ent.typeValue = v[5]
			ent:Spawn()
			ent:Activate()
		
	end
end
	
	local ent = ents.FindByClass( "func_dustmotes" );
	
	for k, v in pairs( ent ) do
		
		v:Remove();
		
	end
	
	if( self.EntNamesToRemove ) then
		
		for _, v in pairs( self.EntNamesToRemove ) do
			
			local tab = ents.FindByName( v );
			
			for _, e in pairs( tab ) do
				
				e:Remove();
				
			end
			
		end
		
	end
	
	if( self.EntPositionsToRemove ) then
		
		for _, v in pairs( self.EntPositionsToRemove ) do
			
			local tab = ents.FindInBox( v, v );
			
			for _, e in pairs( tab ) do
				
				if( !table.HasValue( GAMEMODE.MapProtectedClasses, e:GetClass() ) ) then
					
					e:Remove();
					
				end
				
			end
			
		end
		
	end
	
	if( self.MapInitPostEntity ) then
		
		self:MapInitPostEntity();
		
	end
	
	if( self.Microphones ) then
		
		for _, v in pairs( self.Microphones ) do
			
			local speaker = ents.Create( "info_target" );
			speaker:SetPos( v[1] );
			speaker:SetName( "speaker_" .. speaker:EntIndex() );
			speaker:Spawn();
			speaker:Activate();
			
			local mic = ents.Create( "env_microphone" );
			mic:SetPos( v[1] );
			mic:SetName( "cc_microphones" );
			mic:SetKeyValue( "MaxRange", "320" );
			mic:SetKeyValue( "Sensitivity", "3" );
			mic:SetKeyValue( "spawnflags", "0" );
			mic:SetKeyValue( "speaker_dsp_preset", tostring( v[2] ) );
			mic:SetKeyValue( "SpeakerName", "speaker_" .. speaker:EntIndex() );
			mic:SetKeyValue( "target", "cc_micsamplepoint" );
			mic:Spawn();
			mic:Activate();
			mic:Fire( "Enable" );
			
		end
		
	end
	
	if( self.MapChairs ) then
		
		for _, v in pairs( self.MapChairs ) do
			
			local chair = ents.Create( "prop_vehicle_prisoner_pod" );
			chair:SetPos( v[1] );
			chair:SetAngles( v[2] );
			chair:SetModel( "models/nova/airboat_seat.mdl" );
			chair:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" );
			chair:SetKeyValue( "limitview", "0" );
			chair:Spawn();
			chair:Activate();
			chair:SetNoDraw( true );
			chair:GetPhysicsObject():EnableMotion( false );
			chair:SetCollisionGroup( COLLISION_GROUP_DEBRIS );
			chair.Static = true;
			
		end
		
	end
	
	if( self.Stoves ) then
		
		for _, v in pairs( self.Stoves ) do
			
			local stove = ents.Create( "cc_stove" );
			stove:SetPos( v[1] );
			stove:SetAngles( v[2] );
			
			if( v[3] ) then
				
				stove:SetBuilding( v[3] );
				
			end
			
			if( v[5] ) then
				
				stove:SetModel( v[5] );
				
			end
			
			stove:Spawn();
			stove:Activate();
			stove:GetPhysicsObject():EnableMotion( false );
			stove.Static = true;
			
			if( !v[4] ) then
				
				stove:SetInvisible( true );
				
			end
			
		end
		
	end
	
	if( !self.EnableAreaportals ) then
		
		local ent = ents.FindByClass( "func_areaportalwindow" );
		
		for k, v in pairs( ent ) do
			
			v:Fire( "SetFadeStartDistance", "99999", 0 );
			v:Fire( "SetFadeEndDistance", "99999", 0 );
			
		end
		
		local ent = ents.FindByClass( "func_areaportal" );
		
		for k, v in pairs( ent ) do
			
			v:Fire( "Open" );
			v:SetKeyValue( "target", "" );
			v:SetSaveValue( "target", "" );
			
		end
		
	end
	
	if( self.DoorData ) then
		
		for _, v in pairs( self.DoorData ) do
			
			local ent;
			
			if( type( v[1] ) == "Vector" ) then
				
				local enttab = ents.FindInBox( v[1], v[1] );
				
				if( enttab[1] ) then
					
					ent = enttab[1];
					
				end
				
			elseif( type( v[1] ) == "string" ) then
				
				local enttab = ents.FindByName( v[1] );
				
				if( enttab[1] ) then
					
					ent = enttab[1];
					
				end
				
			else
				
				ent = ents.GetMapCreatedEntity( v[1] );
				
			end
			
			if( ent and ent:IsValid() ) then
				
				ent:SetDoorType( v[2] or DOOR_UNBUYABLE );
				ent:SetDoorOriginalName( v[3] or "" );
				ent:SetDoorName( v[3] or "" );
				ent:SetDoorPrice( v[4] or 0 );
				ent:SetDoorBuilding( v[5] or "" );
				
			end
			
		end
		
	end
	
	local ent = ents.FindByClass( "weapon_*" );
	
	for k, v in pairs( ent ) do
		
		v:Remove();
		
	end
	
end

GM.MapProtectedClasses = {
	"move_rope",
	"keyframe_rope",
}

function GM:EntityKeyValue( ent, key, value )
	
	if( key == "cc_static" and value == "1" ) then
		
		ent.Static = true;
		
	end
	
	return self.BaseClass:EntityKeyValue( ent, key, value );
	
end

function GM:MultiplyMicrophone( name, n )
	
	for _, v in pairs( ents.FindByName( name ) ) do
		
		for i = 1, n do
			
			local mic = ents.Create( "env_microphone" );
			mic:SetPos( v:GetPos() );
			mic:SetName( v:GetName() );
			mic:SetKeyValue( "MaxRange", v:GetSaveTable().MaxRange );
			mic:SetKeyValue( "Sensitivity", v:GetSaveTable().Sensitivity );
			mic:SetKeyValue( "spawnflags", v:GetSaveTable().spawnflags );
			mic:SetKeyValue( "speaker_dsp_preset", v:GetSaveTable().speaker_dsp_preset );
			mic:SetKeyValue( "SpeakerName", v:GetSaveTable().SpeakerName );
			mic:SetKeyValue( "target", v:GetSaveTable().target );
			mic:Spawn();
			mic:Activate();
			
		end
		
	end
	
end




function GM:SetupPlayerVisibility( ply, viewent )
	
	if( self.GetHL2CamPos ) then
		
		AddOriginToPVS( self:GetHL2CamPos()[1] );
		
	end
	
	if( self.GetCACamPos ) then
		
		AddOriginToPVS( self:GetCACamPos() );
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		AddOriginToPVS( self.CombineCameraView:GetPos() );
		
	end
	
end

function nSetCombat( len, ply )
	

	local b = net.ReadBit();
	
	GAMEMODE:LogCombine( "[J] " .. ply:VisibleRPName() .. " turned Combat " .. ( b == 1 and "on" or "off" ) .. ".", ply );
	
	GAMEMODE:SetCombat( b );
	
	if( GAMEMODE:Combat() == 1 ) then
		
		if( GAMEMODE.OnCombatOn ) then GAMEMODE:OnCombatOn() end
		
	else
		
		if( GAMEMODE.OnCombatOff ) then GAMEMODE:OnCombatOff() end
		
	end
	
end
net.Receive( "nSetCombat", nSetCombat );


function nSetTurnGood( len, ply )
	

	local b = net.ReadBit();
	
	GAMEMODE:LogCombine( "[J] " .. ply:VisibleRPName() .. " turned TurnGood " .. ( b == 1 and "on" or "off" ) .. ".", ply );
	
	GAMEMODE:SetTurnGood( b );
	
	if( GAMEMODE:TurnGood() == 1 ) then
		
		if( GAMEMODE.OnTurnGoodOn ) then GAMEMODE:OnTurnGoodOn() end
		
	else
		
		if( GAMEMODE.OnTurnGoodOff ) then GAMEMODE:OnTurnGoodOff() end
		
	end
	
end
net.Receive( "nSetTurnGood", nSetTurnGood );



function nSetTurnBad( len, ply )
	

	local b = net.ReadBit();
	
	GAMEMODE:LogCombine( "[J] " .. ply:VisibleRPName() .. " turned TurnBad " .. ( b == 1 and "on" or "off" ) .. ".", ply );
	
	GAMEMODE:SetTurnBad( b );
	
	if( GAMEMODE:TurnBad() == 1 ) then
		
		if( GAMEMODE.OnTurnBadOn ) then GAMEMODE:OnTurnBadOn() end
		
	else
		
		if( GAMEMODE.OnTurnBadOff ) then GAMEMODE:OnTurnBadOff() end
		
	end
	
end
net.Receive( "nSetTurnBad", nSetTurnBad );




GM.ConnectMessages = { };
GM.EntryPortSpawns = { };

local files = file.Find( GM.FolderName .. "/gamemode/maps/" .. game.GetMap() .. ".lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		include( "maps/" .. v );
		AddCSLuaFile( "maps/" .. v );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Serverside map lua file for " .. game.GetMap() .. " loaded.\n" );
	
else
	
	MsgC( Color( 200, 200, 200, 255 ), "Warning: No serverside map lua file for " .. game.GetMap() .. ".\n" );
	
end