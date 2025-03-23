ODDITY.ID				= "badguy";
ODDITY.Name 			= "Bad Guy";
ODDITY.Description		= "You are on the bad guys team!";
ODDITY.Obvious			= true;
ODDITY.Operable			= false;
ODDITY.RespawnWeapon 	= ""
ODDITY.RemoveOnTurnEnd          = false;

ODDITY.Think	= function( self, ply )
	
	

	if( GAMEMODE:Combat() == 0 ) then
	if ( SERVER ) then
    ply:RemoveOddity( ply:GetOddity( "yourturnfirst" ) );
    ply:RemoveOddity( ply:GetOddity( "yourturn" ) );
	end end

	if( GAMEMODE:Combat() == 1 ) then
	if ( SERVER ) then
    if (ply:HasOddity ("yourturnfirst")) then else
    ply:GiveOddity("yourturnfirst" ); 
    ply:SetBadGuy( true );  end end

	if( GAMEMODE:TurnBad() == 0 ) then
	if ( SERVER ) then
    ply:RemoveOddity( ply:GetOddity( "yourturn" ) );  end end  

	if( GAMEMODE:TurnBad() == 1 ) then
	if ( SERVER ) then

    if (ply:HasOddity ("yourturn")) then else
    ply:GiveOddity("yourturn" ); end end  end 
    end end


ODDITY.OnGiven	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are now part of the enemy team.", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetBadGuy( true );
ply:RemoveOddity( ply:GetOddity( "goodguy" ) );
    end end

ODDITY.OnRemoved	= function( self, ply )
if ( CLIENT ) then
GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You are no longer part of the enemy team", { CB_ALL, CB_IC }, nil, guy ); end

if ( SERVER ) then
ply:SetBadGuy( false );
    end end