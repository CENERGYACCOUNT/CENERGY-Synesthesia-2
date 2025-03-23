AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Trash Pile";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;


function ENT:SetupDataTables()
	
	self:NetworkVar( "String", 0, "Text" );
	
end



function GAMEMODE:CreatePhysicalItem( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	
	e:SetItem( item );
	
	e:SetModel( GAMEMODE:GetItemByID( item ).Model );
	
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

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetModel( "models/foliage/rosesbushes/roses_bush4.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );

	self:SetMoveType( MOVETYPE_NONE );

	self:SetSolid( SOLID_VPHYSICS );
	self:SetUseType( SIMPLE_USE );
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();

	end
	
	local phys = self:GetPhysicsObject();

	if( phys and phys:IsValid() ) then
		
		phys:EnableCollisions( true ); -- only for other model collisions?? player colisions are on eitherway
	
	end

	self.Cooldown = CurTime() + 5;

end




function ENT:Use( ply, item ) 
		
		

	if( CurTime() > self.Cooldown ) then
ply:EmitSound( Sound( "jump_begin.wav" ) );
ply:EmitSound( Sound( "quest_completed.wav" ) );


		self.Cooldown = CurTime() + 5;



		local trace = { };
			trace.start = ply:GetShootPos();
			trace.endpos = trace.start + ply:GetAimVector() * 50;
			trace.filter = ply;
	
		local tr = util.TraceLine( trace );

		local trashpool = {"blackberry","greenberry","redberry","redberry"}

		local randt = trashpool[ math.random( #trashpool )]

		local ent = GAMEMODE:CreatePhysicalItem( randt, tr.HitPos + tr.HitNormal * 10, Angle() );


net.Start( "nGetBerryYes" );
			net.Send( ply );

else 


net.Start( "nGetBerry" );
			net.Send( ply );
			ply:EmitSound( Sound( "jump_end.wav" ) );
end end 


function nGetBerry( len )

	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatSmall", "There's nothing to harvest. Someone already picked all the berries up. You will need to wait for awhile.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nGetBerry", nGetBerry );


function nGetBerryYes( len )

	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatSmall", "You found and harvested some berries!", { CB_ALL, CB_IC } );
	
end
net.Receive( "nGetBerryYes", nGetBerryYes );


