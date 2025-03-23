local meta = FindMetaTable( "Player" );

function GM:loadItemsFromString(str)
	local out = {}

	if string.len(str) > 0 then
		local expl = string.Explode("|", str)

		for _, v in pairs(expl) do
			local data = string.Explode(":", v)

			for i=1, tonumber(data[2]) do
				table.insert(out, data[1])
			end
		end
	end

	return out
end

function GM:saveItemsIntoString(tab)
	local out = ""

	local modified = {}

	for _, v in pairs(tab) do
		modified[v] = (modified[v] or 0) + 1
	end

	for k, v in pairs(modified) do
		out = out..k..":"..tostring(v).."|"
	end

	return string.sub(out, 1, -2)
end


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

function meta:GetOddityItem( itemid )
	
	if( !self.Oddities ) then return end
	
	for k, v in pairs( self.Oddities ) do
		
		if( v == itemid ) then
			
			return k;
			
		end
		
	end
	
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
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		if( self.Oddities[k] and GAMEMODE:GetOddityByID( self.Oddities[k] ) ) then
			
			GAMEMODE:GetOddityByID( self.Oddities[k] ).OnRemoved( self.Oddities[k], self );
			
			table.remove( self.Oddities, k );
			
		end
		
	else
		
		if( self.Oddities[k] ) then
			
			GAMEMODE:GetOddityByID( self.Oddities[k] ).OnRemoved( self.Oddities[k], self );
			GAMEMODE:LogItems( "[R] " .. self:VisibleRPName() .. "'s oddity " .. self.Oddities[k] .. " was removed.", self );
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

function meta:LoadItemsFromString( str )
	
	self.Inventory = { };
	
	if( string.len( str ) > 0 ) then
		
		local expl = string.Explode( "|", str );
		
		for _, v in pairs( expl ) do
			
			local data = string.Explode( ":", v );
			
			for i = 1, tonumber( data[2] ) do
				
				table.insert( self.Inventory, data[1] );
				
			end
			
		end
		
	end
	
	net.Start( "nLoadInventory" );
		net.WriteTable( self.Inventory );
	net.Send( self );
	
end

function meta:SaveInventory()
	
	local str = "";
	
	local modified = { };
	
	for _, v in pairs( self.Inventory ) do
		
		modified[v] = ( modified[v] or 0 ) + 1;
		
	end
	
	for k, v in pairs( modified ) do
		
		str = str .. k .. ":" .. tostring( v ) .. "|";
		
	end
	
	str = string.sub( str, 1, -2 );
	
	self:UpdateCharacterField( "Inventory", str );
	
end





if( CLIENT ) then
	
	local function nLoadInventory( len )
		
		local inv = net.ReadTable();
		
		LocalPlayer().Inventory = inv;
		
	end
	net.Receive( "nLoadInventory", nLoadInventory );
	
	local function nGiveItem( len )
		
		local item = net.ReadString();
		local n = net.ReadUInt( 8 );
		
		LocalPlayer():GiveItem( item, n );
		
	end
	net.Receive( "nGiveItem", nGiveItem );
	
	local function nRemoveItem( len )
		
		local k = net.ReadUInt( 24 );
		
		LocalPlayer():RemoveItem( k );
		
	end
	net.Receive( "nRemoveItem", nRemoveItem );
	
	local function nTooHeavy( len )
		
	

		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "That's too heavy for you to carry.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nTooHeavy", nTooHeavy );
	
else
	
	local function nUseItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		
		ply:UseItem( k );
		
	end
	net.Receive( "nUseItem", nUseItem );
	
	local function nRemoveItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		local s = net.ReadBit();
		
		ply:RemoveItem( k, s );
		
	end
	net.Receive( "nRemoveItem", nRemoveItem );
	
	local function nDropItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		
		local item = ply.Inventory[k];
		
		if( !k ) then return end
		
		GAMEMODE:LogItems( "[D] " .. ply:VisibleRPName() .. " dropped item " .. item .. ".", ply );
		if ( ply:HasItem( "flashlight1"  ) or  ply:HasItem( "flashlight2") or  ply:HasItem( "flashlight3") or  ply:HasItem( "flashlight4") or  ply:HasItem( "flashlight5") or  ply:HasItem( "flashlight6") or  ply:HasItem( "flashlight7") or  ply:HasItem( "flashlight8")  or  ply:HasItem( "flashlight9")  or  ply:HasItem( "flashlight10") 	) then
		ply:Flashlight( false );
		end
		ply:RemoveItem( k, 1 );

		GAMEMODE:CreateItem( ply, item );
		
	end
	net.Receive( "nDropItem", nDropItem );
	
end

function meta:GetNumItems( itemid )
	
	if( !self.Inventory ) then return 0 end
	
	local c = 0;
	
	for _, v in pairs( self.Inventory ) do
		
		if( v == itemid ) then
			
			c = c + 1;
			
		end
		
	end
	
	return c;
	
end

function meta:HasItem( itemid )
	
	if( self:GetNumItems( itemid ) > 0 ) then return true; end
	
	return false;
	
end



function meta:GetInventoryItem( itemid )
	
	if( !self.Inventory ) then return end
	
	for k, v in pairs( self.Inventory ) do
		
		if( v == itemid ) then
			
			return k;
			
		end
		
	end
	
end

function meta:InventoryWeight()
	
	if( !self.Inventory ) then return 0 end
	
	local w = 0;
	
	for _, v in pairs( self.Inventory ) do
		
		if( GAMEMODE:GetItemByID( v ) and GAMEMODE:GetItemByID( v ).Weight ) then
			
			w = w + GAMEMODE:GetItemByID( v ).Weight;
			
		end
		
	end
	
	return w;
	
end

function meta:InventoryMaxWeight()
	
	local w = 10 + math.Round( self:ExtraCarryWeight() * 0.2 );
	
	if( self:HasCombineModel() ) then
		
		w = 60 + math.Round( self:ExtraCarryWeight() * 0.2 );
		
	end
	
	if( self.Inventory ) then
		
		local tab = { };
		
		for _, n in pairs( self.Inventory ) do
			
			if( !table.HasValue( tab, n ) and GAMEMODE:GetItemByID( n ) and GAMEMODE:GetItemByID( n ).CarryAdd ) then
				
				w = w + GAMEMODE:GetItemByID( n ).CarryAdd;
				table.insert( tab, n );
				
			end
			
		end
		
	end
	

	
	return w;
	
end

function meta:CanTakeItem( item )

	if( GAMEMODE:GetItemByID( item ).Weight > 0 and self:InventoryWeight() + GAMEMODE:GetItemByID( item ).Weight > self:InventoryMaxWeight() ) then return false end
	
	return true;
	
end

function meta:GiveItem( item, n, nosave )
	
	n = n or 1;
	
	if( CLIENT ) then
		
		for i = 1, n do
			
			table.insert( self.Inventory, item );
			
		end
		
		GAMEMODE:GetItemByID( item ).OnPlayerPickup( item, self );
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		for i = 1, n do
			
			table.insert( self.Inventory, item );
			
		end
		
	
		
		GAMEMODE:GetItemByID( item ).OnPlayerPickup( item, self );
		
		net.Start( "nGiveItem" );
			net.WriteString( item );
			net.WriteUInt( n, 8 );
		net.Send( self );
		
		if( !nosave ) then
			
			self:SaveInventory();
			
		end
		
	end
	
end

function meta:RemoveItem( k, s )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		if( self.Inventory[k] and GAMEMODE:GetItemByID( self.Inventory[k] ) and GAMEMODE:GetItemByID( self.Inventory[k] ).OnRemoved ) then
			
			GAMEMODE:GetItemByID( self.Inventory[k] ).OnRemoved( self.Inventory[k], self );
			
			table.remove( self.Inventory, k );
			
		end
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		if( self.Inventory[k] ) then
			
			GAMEMODE:GetItemByID( self.Inventory[k] ).OnRemoved( self.Inventory[k], self );

			table.remove( self.Inventory, k );
			
		else
			
			return;
			
		end
		
		if( s != 1 ) then
			
			net.Start( "nRemoveItem" );
				net.WriteUInt( k, 24 );
			net.Send( self );
			
		end
		
		self:SaveInventory();
		
	end
	
end

function meta:UseItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		local ret = GAMEMODE:GetItemByID( self.Inventory[k] ).OnPlayerUse( self.Inventory[k], self );
		
		net.Start( "nUseItem" );
			net.WriteUInt( k, 24 );
		net.SendToServer();
		
		if( GAMEMODE:GetItemByID( self.Inventory[k] ).DeleteOnUse and !ret ) then
			
			self:RemoveItem( k, 1 );
			GAMEMODE:PMResetText();
			
		end
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		if( !self.Inventory[k] ) then
			
			return;
			
		end
		
		GAMEMODE:LogItems( "[U] " .. self:VisibleRPName() .. " used item " .. self.Inventory[k] .. ".", self );
		local ret = GAMEMODE:GetItemByID( self.Inventory[k] ).OnPlayerUse( self.Inventory[k], self );
		
		if( GAMEMODE:GetItemByID( self.Inventory[k] ).DeleteOnUse and !ret ) then
			
			self:RemoveItem( k, 1 );
			
		end
		
	end
	
end

function meta:ThrowOutItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		table.remove( self.Inventory, k );
		
		net.Start( "nRemoveItem" );
			net.WriteUInt( k, 32 );
			net.WriteBit( true );
		net.SendToServer();
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
end

function meta:DropItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		table.remove( self.Inventory, k );
		
		net.Start( "nDropItem" );
			net.WriteUInt( k, 24 );
		net.SendToServer();
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
end
