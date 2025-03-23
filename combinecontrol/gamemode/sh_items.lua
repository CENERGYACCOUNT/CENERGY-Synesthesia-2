GM.Items = { };

local files = file.Find( GM.FolderName .. "/gamemode/items/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		ITEM.Bodygroup		= 0;

		ITEM.Usable			= false;
		ITEM.Droppable		= true;
		ITEM.Throwable		= true;
		ITEM.UseText		= nil;
		ITEM.DeleteOnUse	= false;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		
		AddCSLuaFile( "items/" .. v );
		include( "items/" .. v );
		
		if( ITEM.Clothes ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Wear";
			ITEM.DeleteOnUse	= true;
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local cur = ply:TranslatePlayerModel();
				
				if( !cur ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You can't wear these with what you're wearing right now.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( cur == GAMEMODE:GetItemByID( self ).Clothes ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You're already wearing those.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( CLIENT ) then
					
					GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change clothes.", { CB_ALL, CB_IC } );
					
				else
					
					ply:SetModelCC( string.gsub( ply:GetModel(), cur, GAMEMODE:GetItemByID( self ).Clothes ) );
					ply:UpdateCharacterField( "Model", ply:GetModel() );
					ply.CharModel = ply:GetModel();
					
					if( cur == "group01" ) then
						
						ply:GiveItem( "citizenclothes", nil, true );
						
					end
					
					if( cur == "group03" ) then
						
						ply:GiveItem( "rebelclothes", nil, true );
						
					end
					
					if( cur == "group03m" ) then
						
						ply:GiveItem( "medicclothes", nil, true );
						
					end
					
				end
				
			end
			
		end
		
		if( ITEM.Uniform ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Wear";
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local new = GAMEMODE:GetItemByID( self ).Uniform( self, ply );
				
				if( !new and !ply.Uniform ) then
					
					return;
					
				end
				
				if( SERVER ) then
					
					if( ply.Uniform ) then
						
						ply:SetModelCC( ply.CharModel );
						ply.Uniform = nil;
						
					else
						
						ply:SetModelCC( new );
						ply.Uniform = new;
						
						if( GAMEMODE:GetItemByID( self ).UniformColor ) then
							
							local c = GAMEMODE:GetItemByID( self ).UniformColor;
							ply:SetPlayerColor( Vector( c.r / 255, c.g / 255, c.b / 255 ) );
							
						end
						
					end
					
				end
				
			end
			
		end
		
		
		table.insert( GM.Items, ITEM );
		
	
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No items found.", true );
		
	end
	
end

function GM:LoadWeaponItems()

	for _, v in pairs( weapons.GetList() ) do
		
		if( v.Itemize ) then
			
			ITEM = { };
			ITEM.ID				= v.ClassName;
			ITEM.Name 			= v.PrintName;
			ITEM.Description	= v.ItemDescription or "";
			ITEM.Model			= v.WorldModel;
			ITEM.Weight			= v.ItemWeight or 1;
			ITEM.Bodygroup		= v.ItemBodygroup or 1;

			ITEM.EasterEgg		= v.ItemEasterEgg;
			
			ITEM.FOV			= v.ItemFOV;
			ITEM.CamPos			= v.ItemCamPos;
			ITEM.LookAt			= v.ItemLookAt;
			
			ITEM.ProcessEntity	= v.ItemProcessEntity;
			ITEM.PProcessEntity	= v.ItemPProcessEntity;
			ITEM.IconMaterial	= v.ItemIconMaterial;
			ITEM.IconColor		= v.ItemIconColor;
			
			ITEM.BulkPrice		= v.ItemBulkPrice;
			ITEM.SinglePrice	= v.ItemSinglePrice;
			ITEM.License		= v.ItemLicense;
			
			ITEM.Droppable		= true;
			ITEM.Throwable		= true;
			ITEM.Usable			= v.ItemUsable;
			ITEM.UseText		= v.ItemUseText;
			
        ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;



			function ITEM.OnPlayerSpawn( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnPlayerPickup( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnRemoved( item, ply )
				
				if( SERVER and ply:GetNumItems( item ) < 2 ) then
					
					ply:StripWeapon( item );
					
				end
				
			end;
			
			table.insert( self.Items, ITEM );
			
			if( !ITEM.EasterEgg ) then
				
				MsgC( Color( 200, 200, 200, 255 ), "Weapon item " .. v.ClassName .. " loaded.\n" );
				
			end
			
		end
		
	end
	
end

function GM:GetItemByID( id )
	
	for _, v in pairs( self.Items ) do
		
		if( v.ID == id ) then
			
			return v;
			
		end
		
	end
	
end

function GM:CreateItem( ply, item )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local ent = self:CreatePhysicalItem( item, tr.HitPos + tr.HitNormal * 10, Angle() );
	

	
	return ent;
	
end

function GM:CreatePhysicalItem( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	
	e:SetItem( item );
	
	e:SetModel( GAMEMODE:GetItemByID( item ).Model );
	e:SetBodygroup(1, GAMEMODE:GetItemByID( item ).Bodygroup)
	e:SetPos( pos );
	e:SetAngles( ang );
	
	if( GAMEMODE:GetItemByID( item ).ProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).ProcessEntity( item, e );
		
	end
	
	e:Spawn();
	e:Activate();
	
	if( GAMEMODE:GetItemByID( item ).PProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).PProcessEntity( item, e );
		
	end
	
	if( e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() ) then
		
		e:GetPhysicsObject():Wake();
		
	end
	
	return e;
	
end