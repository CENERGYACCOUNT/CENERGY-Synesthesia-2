function GM:SteamIDIsBanned( sid )
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	for k, v in pairs( self.BanTable ) do
		
		if( v.SteamID == sid ) then
			
			if( tonumber( v.Length ) == 0 ) then
				
				return 0, v.Reason, true;
				
			else
				
				local t = util.TimeSinceDate( v.Date );
				
				if( t < tonumber( v.Length ) ) then
					
					return v.Length - t, v.Reason, false;
					
				else
					
					table.remove( self.BanTable, k );
					self:RemoveBan( sid, "time's up" );
					
				end
				
			end
			
		end
		
	end
	
end

function GM:CheckPassword( steamid, networkid, svpass, pass, name )
	
	if( self.NoMySQL ) then
		
		if( steamid != "STEAM_0:1:34365300" ) then
			
			return false, "The server's MySQL is down for some reason - we're working on it! Check back later.";
			
		end
		
	end
	
	local t, r, p = self:SteamIDIsBanned( util.SteamIDFrom64( steamid ) );
	
	if( t ) then
		
		if( p ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Permabanned." );
			
			local reason = ".";
			
			if( r and string.len( r ) > 0 ) then
				
				reason = " (" .. r .. ").";
				
			end
			
			return false, "You're permabanned" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. ".";
			
		else
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Banned for " .. t .. " more minutes." );
			
			local reason = ".";
			
			if( r and string.len( r ) > 0 ) then
				
				reason = " (" .. r .. ").";
				
			end
			
			return false, "You're banned for " .. t .. " more minutes" .. reason .. " Apply for an unban at " .. self.WebsiteURL .. ".";
			
		end
		
	end
	
	if( self.PrivateMode ) then
		
		if( !table.HasValue( self.PrivateSteamIDs, util.SteamIDFrom64( steamid ) ) ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Blocked during private mode." );
			return false, self.TestingClosedMessage;
			
		end
		
	end
	
	if( svpass != "" ) then
		
		if( pass != svpass ) then
			
			self:LogSecurity( util.SteamIDFrom64( steamid ), networkid, name, "Failed password check: Their password, \"" .. pass .. "\", did not match server password, \"" .. svpass .. "\"." );
			return false, "#GameUI_ServerRejectBadPassword";
			
		end
		
	end
	
	return true;
	
end

