local PLAYER = { };

PLAYER.DisplayName			= "CENERGY - Synesthesia 2";
PLAYER.TeammateNoCollide	= false;
PLAYER.AvoidPlayers			= false;

function PLAYER:GetHandsModel()
	
	local cl_playermodel = GAMEMODE:TranslateModelToPlayer( self.Player:GetModel() );
	return player_manager.TranslatePlayerHands( cl_playermodel )

end

function PLAYER:StartMove( move )
end

function PLAYER:FinishMove( move )
end

player_manager.RegisterClass( "player_cc", PLAYER, "player_sandbox" );