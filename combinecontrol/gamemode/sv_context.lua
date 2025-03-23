


function nCLockUnlock( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local ent = net.ReadEntity();
	
	if( ply:GetPos():Distance( ent:GetPos() ) > 128 ) then return end
	
	if( ent and ent:IsValid() and ent:IsDoor() and ply:CanLock( ent ) ) then
		
		if( ent:GetSaveTable().m_bLocked ) then
			
			ply:EmitSound( "doors/door_latch3.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Unlock" );
			
		else
			
			ply:EmitSound( "doors/door_locked2.wav", 100, math.random( 90, 110 ) );
			ent:Fire( "Lock" );
			
		end
		
	end
	
end
net.Receive( "nCLockUnlock", nCLockUnlock );

function nCGiveCredits( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local amt = net.ReadUInt( 32 );
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( ply:Money() >= amt ) then
		
		ply:AddMoney( -amt );
		targ:AddMoney( amt );
		
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		targ:UpdateCharacterField( "Money", tostring( targ:Money() ) );
		
		net.Start( "nCReceiveCredits" );
			net.WriteUInt( amt, 32 );
			net.WriteEntity( ply );
		net.Send( targ );
		
	end
	
end
net.Receive( "nCGiveCredits", nCGiveCredits );

function nCExamine( len, ply )
	
	if( !ply.NextExamine ) then ply.NextExamine = CurTime(); end
	
	if( CurTime() >= ply.NextExamine ) then
		
		ply.NextExamine = CurTime() + 1;
		
	end
	
end
net.Receive( "nCExamine", nCExamine );

function nCPatDownStart( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	local mul = 1;
	
	if( ply:HasTrait( TRAIT_SPEEDY ) or targ:HasTrait( TRAIT_SPEEDY ) ) then
		
		mul = 0.5;
		
	end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 5 * mul );
		net.WriteString( "Being pat down..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCPatDownStart", nCPatDownStart );

function nCPatDown( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 ) then
		
		local tab = { };
		
		for k, v in pairs( targ.Inventory ) do
			
			if( ( v == "radio" or v == "combineradio"  or v == "crdevice" ) and targ:HasTrait( TRAIT_SPY ) ) then
				
				if( !targ.NextTraitSpy ) then targ.NextTraitSpy = 0 end
				
				if( CurTime() >= targ.NextTraitSpy ) then
					
					targ.NextTraitSpy = CurTime() + 1200;
					
				else
					
					tab[k] = v;
					
				end
				
			else
				
				tab[k] = v;
				
			end
			
		end
		
		net.Start( "nCPattedDown" );
			net.WriteTable( tab );
		net.Send( ply );
		
	end
	
end
net.Receive( "nCPatDown", nCPatDown );

function nCTieUpStart( len, ply )
	
	if( !ply:HasItem( "zipties" ) ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 5 );
		net.WriteString( "Being tied up..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCTieUpStart", nCTieUpStart );

function nCTieUp( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 and ply:HasItem( "zipties" ) ) then
		
		targ:SetTiedUp( true );
		for _, v in pairs( GAMEMODE.HandsWeapons ) do
			
			if( targ:HasWeapon( v ) ) then
				
				targ:SelectWeapon( v );
				break;
				
			end
			
		end
		
	end
	
end
net.Receive( "nCTieUp", nCTieUp );

function nCUntieStart( len, ply )
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	net.Start( "nCreateTimedProgressBar" );
		net.WriteFloat( 2 );
		net.WriteString( "Being untied..." );
		net.WriteEntity( ply );
	net.Send( targ );
	
end
net.Receive( "nCUntieStart", nCUntieStart );

function nCUntie( len, ply )
	
	if( ply:TiedUp() ) then return end
	if( ply:PassedOut() ) then return end
	if( ply:APC() and ply:APC():IsValid() ) then return end
	
	local targ = net.ReadEntity();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetVelocity():Length2D() <= 5 ) then
		
		targ:SetTiedUp( false );
		
	end
	
end
net.Receive( "nCUntie", nCUntie );


function nCRadioChannel( len, ply )
	
	local targ = net.ReadEntity();
	local val = net.ReadFloat();
	
	if( ply:GetPos():Distance( targ:GetPos() ) > 128 ) then return end
	
	if( targ:GetClass() == "cc_radio" ) then
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
				
				targ:SetChannel( val );
				
			end
			
		end
		
	end
	
end
net.Receive( "nCRadioChannel", nCRadioChannel );
