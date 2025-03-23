local meta = FindMetaTable( "Player" );

function meta:LoadOdditiesFromString( str )
	
	self.Oddities = { };
	
	if( string.len( str ) > 0 ) then
		
		local expl = string.Explode( "|", str );
		
		for _, v in pairs( expl ) do
			
			local data = string.Explode( ":", v );
			
			for i = 1, tonumber( data[2] ) do
				
				table.insert( self.Oddities, data[1] );
				
			end
			
		end
		
	end
	
	net.Start( "nLoadOddities" );
		net.WriteTable( self.Oddities );
	net.Send( self );
	
end

function meta:GiveOddityWeapons()
    if not self.Oddities then return end

    for _, oddityID in pairs(self.Oddities) do
        local oddity = GAMEMODE:GetOddityByID(oddityID)
        if oddity and oddity.RespawnWeapon then
            self:Give(oddity.RespawnWeapon)
        end
    end
end

function meta:SaveOddities()
	
	local str = "";
	
	local modified = { };
	
	for _, v in pairs( self.Oddities ) do
		
		modified[v] = ( modified[v] or 0 ) + 1;
		
	end
	
	for k, v in pairs( modified ) do
		
		str = str .. k .. ":" .. tostring( v ) .. "|";
		
	end
	
	str = string.sub( str, 1, -2 );
	
	self:UpdateCharacterField( "Oddities", str );
	
end

if( CLIENT ) then
	
	local function nLoadOddities( len )
		
		local inv = net.ReadTable();
		
		LocalPlayer().Oddities = inv;
		
	end
	net.Receive( "nLoadOddities", nLoadOddities );
	
	local function nGiveOddity( len )
		
		local item = net.ReadString();
		local n = net.ReadUInt( 8 );
		
		LocalPlayer():GiveOddity( item, n );
		
	end
	net.Receive( "nGiveOddity", nGiveOddity );
	
	local function nRemoveOddity( len )
		
		local k = net.ReadUInt( 24 );
		
		LocalPlayer():RemoveOddity( k );
		
	end
	net.Receive( "nRemoveOddity", nRemoveOddity );
	
else
	
	local function nRemoveOddity( len, ply )
		
		local k = net.ReadUInt( 24 );
		local s = net.ReadBit();
		
		ply:RemoveOddity( k, s );
		
	end
	net.Receive( "nRemoveOddity", nRemoveOddity );
	
end

function meta:GetNumOddities( itemid )
	
	if( !self.Oddities ) then return 0 end
	
	local c = 0;
	
	for _, v in pairs( self.Oddities ) do
		
		if( v == itemid ) then
			
			c = c + 1;
			
		end
		
	end
	
	return c;
	
end

function meta:HasOddity( itemid )
	
	if( self:GetNumOddities( itemid ) > 0 ) then return true; end
	
	return false;
	
end

function meta:GetOddity( itemid )
	
	if( !self.Oddities ) then return end
	
	for k, v in pairs( self.Oddities ) do
		
		if( v == itemid ) then
			
			return k;
			
		end
		
	end
	
end

function meta:GiveOddity( item, n, nosave )
	
	n = n or 1;
	
	if( CLIENT ) then
		
		for i = 1, n do
			
			table.insert( self.Oddities, item );
			
			GAMEMODE:GetOddityByID( item ).OnGiven( item, self );
			
		end
		
	else
		
		for i = 1, n do
			
			table.insert( self.Oddities, item );
			
			GAMEMODE:GetOddityByID( item ).OnGiven( item, self );
			
		end
		
		GAMEMODE:LogItems( "[G] " .. self:VisibleRPName() .. " was granted the '" .. item .. "' oddity.", self );
		
		net.Start( "nGiveOddity" );
			net.WriteString( item );
			net.WriteUInt( n, 8 );
		net.Send( self );
		
		if( !nosave ) then
			
			self:SaveOddities();
			
		end
		
	end
	
end

function meta:RemoveOddity( k, s )
	
	if( CLIENT ) then
		
		if( self.Oddities[k] and GAMEMODE:GetOddityByID( self.Oddities[k] ) ) then
			
			GAMEMODE:GetOddityByID( self.Oddities[k] ).OnRemoved( self.Oddities[k], self );
			
			table.remove( self.Oddities, k );
			
		end
		
	else
		
		if( self.Oddities[k] ) then
			
			GAMEMODE:GetOddityByID( self.Oddities[k] ).OnRemoved( self.Oddities[k], self );
			table.remove( self.Oddities, k );
			
		else
			
			return;
			
		end
		
		if( s != 1 ) then
			
			
			net.Start( "nRemoveOddity" );
				net.WriteUInt( k, 24 );
			net.Send( self );
			
		end
		
		self:SaveOddities();
		
	end
	
end