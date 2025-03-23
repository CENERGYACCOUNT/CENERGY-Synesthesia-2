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

function ENT:Init( data )
	
	local o = data:GetOrigin();
	local v = data:GetStart();
	
	self.StartTime = CurTime();
	self.Size = math.random( 2, 10 );
	
	if( GAMEMODE.Emitter2D ) then
		

		local p = GAMEMODE.Emitter2D:Add( "sprites/orangeflare1", o );
		p:SetRoll( math.Rand( 0, 360 ) );
		p:SetRollDelta( math.Rand( 1, 4 ) );
		p:SetDieTime( 10 );
		p:SetStartAlpha( 255 );
		p:SetStartSize( self.Size );
		p:SetEndSize( self.Size );
		p:SetColor( 255, 255, 255 );
		p:SetVelocity( v );
		p:SetAirResistance( 5 );
		p:SetGravity( Vector( 0, 0, -400 ) );
		p:SetCollide( true );
		p:SetBounce( 0.0 );
		
		timer.Create( "FlareTimer" .. CurTime(), 0.01, 250, function()
			
		
		
		end )
		
	end
	
end

	function ENT:Touch( hitEnt )
 	if ( hitEnt:IsValid() and hitEnt:IsPlayer() ) then

     tr.Entity:TakeDamage(  55  ); 
	end
 end

function ENT:Think()
	
	return false;
	
end

function ENT:Render()
	
	
	
end
