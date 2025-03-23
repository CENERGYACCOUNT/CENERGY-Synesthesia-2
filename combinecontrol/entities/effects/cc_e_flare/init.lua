function EFFECT:Init( data )
	
	local o = data:GetOrigin();
	local v = data:GetStart();
	
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
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
		p:SetBounce( 0.1 );
		
		timer.Create( "FlareTimer" .. CurTime(), 0.01, 250, function()
			
		
		
		end )
		
	end
	
end

	function EFFECT:Touch( hitEnt )
 	if ( hitEnt:IsValid() and hitEnt:IsPlayer() ) then


	end
 end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
