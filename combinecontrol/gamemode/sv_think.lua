function GM:Think()
	
	for _, v in pairs( player.GetAll() ) do
		
		self:SpeedThink( v );

		
		if( v.Inventory ) then
			
			for _, n in pairs( v.Inventory ) do
				
				if( GAMEMODE:GetItemByID( n ) and GAMEMODE:GetItemByID( n ).Think ) then
					
					GAMEMODE:GetItemByID( n ).Think( n, v );
					
				end
				
			end
			
		end
		
	end

		for _, v in pairs( player.GetAll() ) do
	
		if( v.Oddities ) then	
		for _, n in pairs( v.Oddities ) do			
			if( GAMEMODE:GetOddityByID( n ) and GAMEMODE:GetOddityByID( n ).Think ) then				
				GAMEMODE:GetOddityByID( n ).Think( n, v );				
			end	
		end		
	end
	end 

	self:SQLThink();
	self:SpawnerThink();
	

	
end

