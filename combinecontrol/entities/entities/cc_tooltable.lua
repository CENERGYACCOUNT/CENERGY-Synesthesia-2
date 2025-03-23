AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	
	self:NetworkVar( "Bool", 0, "StoveOn" );
	self:NetworkVar( "Bool", 1, "Invisible" );
	self:NetworkVar( "Bool", 2, "Broken" );
	self:NetworkVar( "String", 0, "Building" );
	self:NetworkVar( "Int", 0, "Deployer" );
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	
	self:SetStoveOn( false );
	self:SetBroken( false );
	
	self:SetModel( "models/toussaint_table9.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetUseType( SIMPLE_USE );
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
	
	if( self:GetStoveOn() ) then
		
		local omin = self:OBBMins();
		local omax = self:OBBMaxs();
		
		omin.z = 20;
		omax.z = 30;
		
		local min, max = self:GetRotatedAABB( omin, omax );
		
		if( self:GetModel() == "models/toussaint_table9.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -17, 5, 40 ), Vector( 17, 33, 50 ) );
			
		end
		
		if( self:GetModel() == "models/toussaint_table9.mdl" ) then
			
			min, max = self:GetRotatedAABB( Vector( -20, -20, -8 ), Vector( 20, 20, 32 ) );
			
		end
		
		local enttab = ents.FindInBox( self:GetPos() + min, self:GetPos() + max );
		
		local bleach = nil;
		local drugbreen = nil;
		local smallmedkit = nil;
		local water = nil;
		local vodka = nil;
		
		local items = { };
		
		for _, v in pairs( enttab ) do
			
			if( v:GetClass() == "cc_item" ) then
				
				if( !items[v:GetItem()] ) then
					
					items[v:GetItem()] = v;
					
				end
				
			end
			
		end
		
		for _, v in pairs( GAMEMODE.RecipesTT ) do
			
			local good = true;
			
			for k, n in pairs( v[1] ) do
				
				if( !items[n] ) then good = false; end
				
			end
			
			if( good ) then
				
				local pos = nil;
				
				for _, n in pairs( items ) do
					
					if( v[1][1] == n:GetItem() ) then
						
						pos = n:GetPos();
						
					end
					
				end
				
				if( pos ) then
					
					for k, n in pairs( items ) do
						self:SetStoveOn( false );
						if( table.HasValue( v[1], k ) ) then
							
							n:Remove();
							



						end
						
					end
					
					if( v[3] ) then
						
						if( math.random( 1, 1 / v[4] ) == 1 ) then
							self:SetStoveOn( false );
							for k, n in pairs( v[3] ) do
								
								timer.Simple( ( k - 1 ) / 2, function()
									
									GAMEMODE:CreatePhysicalItem( n, pos, Angle(120) );
									
								end );
								
							end
							
						else
							
							for k, n in pairs( v[2] ) do
								self:SetStoveOn( false );
								timer.Simple( ( k - 1 ) / 2, function()
									
									GAMEMODE:CreatePhysicalItem( n, pos, Angle() );
									
								end );
								
							end
							
						end
						
					else
						
						for k, n in pairs( v[2] ) do
							self:SetStoveOn( false );
							timer.Simple( ( k - 1 ) / 2, function()
								
								GAMEMODE:CreatePhysicalItem( n, pos, Angle() );
								
self:EmitSound( Sound( "physics/wood/wood_box_impact_bullet1.wav" ) );
						self:EmitSound( Sound( "quest_succeeded.wav" ) );		




							end );
							
						end
						
					end
					
				end
				
			end
			
		end
		end end 


function ENT:Use( ply )
	

			

	if( self:GetBroken() ) then return end
	
	if( SERVER ) then
		
		if( self:GetBuilding() != "" and !table.HasValue( ply:OwnedBuildings(), self:GetBuilding() ) and !table.HasValue( ply:AssignedBuildings(), self:GetBuilding() ) ) then
			
			net.Start( "nUnownedStove" );
			net.Send( ply );
			return;
			
		end
		

				

		self:EmitSound( Sound( "physics/wood/wood_box_impact_soft2.wav" ) );
		
		self:SetStoveOn( !self:GetStoveOn() );
		
		if( ( !self.SteamEnt or !self.SteamEnt:IsValid() ) and self:GetModel() != "models/toussaint_table9.mdl" ) then
			
			local pos = self:GetPos();
			if( string.lower( self:GetModel() ) == "models/toussaint_table9.mdl" ) then
				
				pos = self:GetPos() + self:GetRight() * -20 + self:GetUp() * 18;
				
			end

end end end




function ENT:nAnvilFinish( ply )
	

	if( SERVER ) then
		
		if( self:GetBuilding() != "" and !table.HasValue( ply:OwnedBuildings(), self:GetBuilding() ) and !table.HasValue( ply:AssignedBuildings(), self:GetBuilding() ) ) then
			
			net.Start( "nUnownedAnvil" );
			net.Send( ply );
			return;
			
		end
		
		
		
		self:SetStoveOn( !self:GetStoveOn() );
		
		if( ( !self.SteamEnt or !self.SteamEnt:IsValid() ) and self:GetModel() != "models/toussaint_table9.mdl" ) then
			
			local pos = self:GetPos();
			if( string.lower( self:GetModel() ) == "models/toussaint_table9.mdl" ) then
				
				pos = self:GetPos() + self:GetRight() * -20 + self:GetUp() * 18;
				
			end
			
			
	
net.Receive( "nAnvilFinish", nAnvilFinish );

function ENT:CanPhysgun()
	
	return self:GetDeployer() > 1;
	
end

ENT.LightMat = Material( "particle/fire" );

function ENT:Draw()
	
	if( !self:GetInvisible() ) then
		
		self:DrawModel();
		self:DrawShadow( true );
		
		if( self:GetStoveOn() and self:GetModel() == "models/toussaint_table9.mdl" ) then
			
			render.SetMaterial( self.LightMat );
			render.DrawSprite( self:GetPos() + self:GetForward() * 9 + self:GetRight() * -8 + self:GetUp() * 4, 8, 8, Color( 255, 255, 200, 255 ), false );
			
		end
		
	else
		
		self:DrawShadow( false );
		
	end end end end 
	
end

function nAnvilSmithing( len )
	
	local time = net.ReadFloat();
	local ent = net.ReadEntity();
	
	GAMEMODE:CreateTimedProgressBar( time, "Smithing...", ent, function()
		
		if( !ent or !ent:IsValid() ) then return end
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Smithing complete!", { CB_ALL, CB_IC } );
		
		net.Start( "nAnvilFinish" );
			net.WriteEntity( ent );
		net.SendToServer();
		
	end );
	
end
net.Receive( "nAnvilSmithing", nAnvilSmithing );




function nUnownedAnvil( len )
	
	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't own this stove! It's rude to mess with other people's stuff.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nUnownedAnvil", nUnownedAnvil );



function nForgeXP( len, ply )
	

		
		ply:SetCrafting( math.Clamp( ply:Crafting() + GAMEMODE:ScaledStatIncrease( ply, ply:Crafting() ) * 5, 0, 100 ) );
				ply:UpdateCharacterField( "StatCrafting", tostring( ply:Crafting() ), true );
		
net.Start( "CraftingUP" );
				net.Send( ply );

	end
	

net.Receive( "nForgeXP", nForgeXP );


function nStartAnvil( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_anvil" and targ:GetBroken() and ply:HasItem( "hammer" ) ) then
		
		local perc = math.Clamp( ( ply:Crafting() + ply:DrugPerceptionMod() ) / 100, 0, 100 );
		
		if( perc >= 0.2 ) then
			
			if( ply:HasTrait( TRAIT_GREASE ) ) then
				
				perc = perc / 2;
					
			end
			
			net.Start( "nAnvilSmithing" );
				net.WriteFloat( ( 1 - perc ) * 60 + 5 );
				net.WriteEntity( targ );
			net.Send( ply );
			ply:EmitSound( Sound( "d_blacksmith2.wav") ); 
		else
			
			net.Start( "nCPercLevel" );
			net.Send( ply );
			
		end
		
	end
	
end

net.Receive( "nStartAnvil", nStartAnvil );

function nTakeAnvil( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_anvil" and ply:CanTakeItem( "microwave" ) and ply:CharID() == targ:GetDeployer() ) then
		
		targ:Remove();
		ply:GiveItem( "microwave" );
		
	end
	
end
net.Receive( "nTakeAnvil", nTakeAnvil );

