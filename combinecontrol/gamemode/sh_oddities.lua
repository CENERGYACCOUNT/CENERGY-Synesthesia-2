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