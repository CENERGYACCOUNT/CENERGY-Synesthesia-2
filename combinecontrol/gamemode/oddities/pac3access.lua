ODDITY.ID				= "pac3access";
ODDITY.Name 			= "PAC3 Access";
ODDITY.Description		= "You have access to PAC3.";
ODDITY.Obvious			= true;
ODDITY.RemoveOnTurnEnd          = false;
ODDITY.OnGiven	= function( self, ply )

	if ( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You have received access to PAC3.", { CB_ALL, CB_IC }, nil, guy );
		
	end
	
end
