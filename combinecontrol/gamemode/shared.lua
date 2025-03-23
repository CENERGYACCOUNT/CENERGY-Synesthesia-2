-- 5/25/2013

DeriveGamemode( "sandbox" );

GM.Name = "CENERGY";
GM.Author = "Disseminate, edited by CENERGY Team";
GM.Website = "";
GM.Email = "disseminate@luaforfood.com/matyas.kopta@gmail.com";

function GM:GetGameDescription()
	
	return self.Name;
	
end

math.randomseed( os.time() );

local meta = FindMetaTable( "Player" );
local emeta = FindMetaTable( "Entity" );

function GM:CreateTeams()

-- OLD ROLES (We dont use those but keep them just incase for now)
	team.SetUp( TEAM_COMBINE, "Combine", Color( 33, 106, 196, 255 ), false );
	team.SetUp( TEAM_OFFCOMBINE, "Jobless", Color( 0, 120, 0, 255 ), false );
	team.SetUp( TEAM_STALKER, "Stalkers", Color( 86, 86, 86, 255 ), false );
	team.SetUp( TEAM_VORTIGAUNT, "Vortigaunts", Color( 65, 204, 118, 255 ), false );
	team.SetUp( TEAM_OVERWATCH, "Overwatch", Color( 200, 200, 200, 255 ), false );
	team.SetUp( TEAM_CITYADMINISTRATOR, "City Administrator", Color( 200, 200, 201, 255 ), false );
	team.SetUp( TEAM_ZOMBIES, "Administration", Color( 255, 0, 0, 0 ), false );

-- NEW ROLES
	team.SetUp( TEAM_CITIZEN, "Dead Men", Color( 190, 190, 190, 255 ), false );
	team.SetUp( TEAM_SECURITY, "Security Team", Color( 0, 120, 255, 255 ), false );
	team.SetUp( TEAM_COMMAND, "Command Deck", Color( 155, 155, 155, 155 ), false );
	team.SetUp( TEAM_MEDICAL, "Medical Staff", Color( 175, 0, 0, 255 ), false );
	team.SetUp( TEAM_ENGINEER, "Engineering Team", Color( 255, 95, 0, 255 ), false );
	team.SetUp( TEAM_MECHANIC, "Mechanic Team", Color( 0, 150, 205, 255 ), false );
	team.SetUp( TEAM_JANITOR, "Janitorial Duties", Color( 244, 244, 0, 255 ), false );
	team.SetUp( TEAM_KITCHEN, "Kitchen Staff", Color( 197, 0, 255, 255 ), false );
	team.SetUp( TEAM_BOTANIST, "Botanic Team", Color( 0, 125, 0, 255 ), false );
	team.SetUp( TEAM_STORAGE, "Storage Management", Color( 128, 95, 0, 255 ), false );

end

GM.ModelColors = { };

for _, v in pairs( GM.CitizenModels ) do
	GM.ModelColors[v] = Vector( 15, 71, 93 ) / 255;
end

for _, v in pairs( GM.RebelModels ) do
	GM.ModelColors[v] = Vector( 98, 112, 66 ) / 255;
end

GM.ModelColors["models/player/combine_soldier.mdl"] = Vector( 0, 0.8, 1 );
GM.ModelColors["models/player/combine_super_soldier.mdl"] = Vector( 0.4, 0, 0 );

GM.ModelFuncs = { };
GM.ModelFuncs["models/minic23/citizens/male_02_alyxcolorable.mdl"] = function( ply )
	
	ply:SetBodygroup( 2, 5 );
	
end

function meta:SetModelM( mdl )

	self:SetModel( mdl )
	
end

function meta:SetModelCC( mdl )
	
	self:SetModel( mdl );
	self:SetSkin( 0 );
	for i = 0,  20 do
		self:SetBodygroup( i, 0 );
		self:SetSubMaterial( i, "" );
	end
	
	if( GAMEMODE.ModelFuncs[mdl] ) then
		
		GAMEMODE.ModelFuncs[mdl]( self );
		
	end
	
	if( GAMEMODE.ModelColors[mdl] ) then
		
		self:SetPlayerColor( GAMEMODE.ModelColors[mdl] );
		
	end
	
	if( self:GetViewModel( 0 ) and self:GetViewModel( 0 ):IsValid() ) then
		
		self:SetupHands();
		
	end
	
end

function GM:TranslateModelToPlayer( mdl )
	
	for k, v in pairs( player_manager.AllValidModels() ) do
		
		if( string.lower( v ) == string.lower( mdl ) ) then
			
			return k;
			
		end
		
	end
	
	return "kleiner";
	
end

function XRES( x )
	
	return x * ( ScrW() / 640 );
	
end

function YRES( y )
	
	return y * ( ScrH() / 480 );
	
end

function meta:Gender()
	
	local mdl = string.lower( self.CharModel or self:GetModel() );
	
	if( string.find( mdl, "female" ) ) then return GENDER_FEMALE end
	if( mdl == "models/player/alyx.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/mossman_arctic.mdl" ) then return GENDER_FEMALE end
	if( mdl == "models/player/p2_chell.mdl" ) then return GENDER_FEMALE end
	
	if ( string.find( mdl, "metropolice" ) ) then return GENDER_CP end
	if ( GAMEMODE:LookupCombineFlag( self:ActiveFlag() ) ) then return GENDER_CP end
	
	if( mdl == "models/vortigaunt.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_slave.mdl" ) then return GENDER_VORT end
	if( mdl == "models/vortigaunt_doctor.mdl" ) then return GENDER_VORT end
	
	if( mdl == "models/zombie/zombie_soldier.mdl") then return GENDER_ZOMBINE end
	
	return GENDER_MALE;
	
end

function GM:FindPlayer( name, caller )
	
	name = string.lower( name );
	
	if( name == "^" ) then
		
		return caller;
		
	end
	
	if( name == "-" ) then
		
		local tr = caller:GetEyeTrace();
		
		if( tr.Entity and tr.Entity:IsValid() and tr.Entity:IsPlayer() ) then
			
			return tr.Entity;
			
		end
		
	end
	
	for k, v in pairs( player.GetAll() ) do
		
		if( tonumber( name ) == v:CID() or tonumber( name ) == v:FormattedCID() ) then
			return v;
		end
		
		if( string.find( string.lower( v:VisibleRPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:RPName() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.find( string.lower( v:Nick() ), name, nil, true ) ) then
			return v;
		end
		
		if( string.lower( v:SteamID() ) == name ) then
			return v;
		end
		
	end

end

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -";

function GM:CheckCharacterValidity( name, desc, model, sum, trait )
	
	if( string.len( name ) < self.MinNameLength ) then
		return false, "Name must be longer than " .. self.MinNameLength .. " characters.";
	end
	
	if( string.len( name ) > self.MaxNameLength ) then
		return false, "Name must be shorter than " .. self.MaxNameLength .. " characters.";
	end
	
	if( string.len( desc ) > self.MaxDescLength ) then
		return false, "Description must be shorter than " .. self.MaxDescLength .. " characters.";
	end
	
	if( !table.HasValue( self.CitizenModels, string.lower( model ) ) ) then
		return false, "Invalid model.";
	end
	
	if( string.find( name, "#", nil, true ) or string.find( name, "~", nil, true ) or string.find( name, "%", nil, true ) ) then
		return false, "Invalid name.";
	end
	
	if( sum < 0 or sum > GAMEMODE.StatsAvailable ) then
		return false, "Too many stats allocated.";
	end
	
	if( !self.Traits[trait] ) then
		return false, "Invalid trait.";
	end
	
	if( string.find( allowedChars, name, 1, true ) ) then
		return false, "Invalid characters in name.";
	end
	
	return true;
	
end

function GM:FormatLine( str, font, size )
	
	if( string.len( str ) == 1 ) then return str, 0 end
	
	local start = 1;
	local c = 1;
	
	surface.SetFont( font );
	
	local endstr = "";
	local n = 0;
	local lastspace = 0;
	local lastspacemade = 0;
	
	while( string.len( str or "" ) > c ) do
	
		local sub = string.sub( str, start, c );
	
		if( string.sub( str, c, c ) == " " ) then
			lastspace = c;
		end
		
		if( surface.GetTextSize( sub ) >= size and lastspace ~= lastspacemade ) then
			
			local sub2;
			
			if( lastspace == 0 ) then
				lastspace = c;
				lastspacemade = c;
			end
			
			if( lastspace > 1 ) then
				sub2 = string.sub( str, start, lastspace - 1 );
				c = lastspace;
			else
				sub2 = string.sub( str, start, c );
			end
			
			endstr = endstr .. sub2 .. "\n";
			
			lastspace = c + 1;
			lastspacemade = lastspace;
			
			start = c + 1;
			n = n + 1;
		
		end
	
		c = c + 1;
	
	end
	
	if( start < string.len( str or "" ) ) then
	
		endstr = endstr .. string.sub( str or "", start );
	
	end
	
	return endstr, n;

end

function GM:CanSeePos( pos1, pos2, filter )
	
	local trace = { };
	trace.start = pos1;
	trace.endpos = pos2;
	trace.filter = filter;
	trace.mask = MASK_SOLID + CONTENTS_WINDOW + CONTENTS_GRATE;
	local tr = util.TraceLine( trace );
	
	if( tr.Fraction == 1.0 ) then
		
		return true;
		
	end
	
	return false;
	
end

function meta:CanSee( ent )
	
	return GAMEMODE:CanSeePos( self:EyePos(), ent:EyePos(), { self, ent } );
	
end

function meta:CanHear( ent )
	
	local trace = { };
	trace.start = self:EyePos();
	trace.endpos = ent:EyePos();
	trace.filter = self;
	trace.mask = MASK_SOLID;
	local tr = util.TraceLine( trace );
	
	if( IsValid( tr.Entity ) and tr.Entity:EntIndex() == ent:EntIndex() ) then
		
		return true;
		
	end
	
	return false;
	
end

function GM:ShouldCollide( e1, e2 )
	
	return true;
	
end

function GM:GetHandTrace( ply, len )
	
	local trace = { };
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * ( len or 50 );
	trace.filter = ply;
	
	return util.TraceLine( trace );
	
end

function util.TimeSinceDate( d )
	
	if( !d or d == "" ) then return 0 end
	
	local c = os.date( "!*t" );
	
	local sides = string.Explode( " ", d );
	local d2 = string.Explode( "/", sides[1] );
	local t2 = string.Explode( ":", sides[2] );
	
	local cmonth = tonumber( d2[1] );
	local cday = tonumber( d2[2] );
	local cyear = tonumber( d2[3] );
	local chour = tonumber( t2[1] );
	local cmin = tonumber( t2[2] );
	local csec = tonumber( t2[3] );
	
	c.year = c.year - 2000;
	
	local count = ( c.year - cyear ) * 525600;
	count = count + ( c.month - cmonth ) * 43200;
	count = count + ( c.day - cday ) * 1440;
	count = count + ( c.hour - chour ) * 60;
	count = count + ( c.min - cmin );
	count = count + math.ceil( ( c.sec - csec ) / 60 );
	
	return count;
	
end

GM.Stats = {
"Muscle",
"Agility",
"Reflexes",
"Sly",
"Cool",
"Smarts",
"Persistence",
"Accuracy",
"BluntProficiency",
"SlashProficiency",
"MartialProficiency",
"BonusHealth",
"BonusHealthRegeneration",
"ExtraCarryWeight",
"Threat",
"Parry",
"Dodge",
"Movement",
"Attack",
"Special",
"Ultimate",
"Energy",
"ExtraMovement",
"ExtraAttack",
"ExtraSpecial",
"ExtraUltimate",
"ExtraEnergy",
"CriticalDamage",
"CriticalChance",
"Sneak",
"BluntHeadDefense",
"BluntChestDefense",
"BluntArmsDefense",
"BluntLegsDefense",
"SlashHeadDefense",
"SlashChestDefense",
"SlashArmsDefense",
"SlashLegsDefense",
"BulletHeadDefense",
"BulletChestDefense",
"BulletArmsDefense",
"BulletLegsDefense",
"HeatHeadDefense",
"HeatChestDefense",
"HeatArmsDefense",
"HeatLegsDefense"

};

function GM:ScaledStatIncrease( ply, lvl )
	
	local rawmul = ( 15 - 1.025 ^ lvl ) / 25;
	
	rawmul = rawmul * ( 1 - math.Clamp( ply:Hunger() / 60, 0, 1 ) );
	
	return ( 15 - 1.025 ^ lvl ) / 25;
	
end

GM.Music = {

};

GM.EP2Music = {
	
};

function GM:GetSongList( e )
	
	local tab = { };
	
	for _, v in pairs( self.Music ) do
		
		if( v[3] == e ) then
			
			table.insert( tab, v[1] );
			
		end
		
	end
	
	return tab;
	
end

GM.OverwatchLines = {
	{ "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav", "Attention, ground units. Anticitizen reported in this community. Code: lock, cauterize, stabilize." },
	{ "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav", "You are charged with anticivil activity level one. Protection units: prosecution code duty, sword, operate." },
	{ "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav", "Protection team alert: Evidence of anticivil activity in this community. Code: assemble, clamp, contain." },
	{ "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav", "Individual: you are charged with capital malcompliance. Anticitizen status approved." },
	{ "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav", "Individual: you are now charged with socioendangerment level five. Cease evasion immediately; receive your verdict." },
	{ "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav", "Individual: you are convicted of multi anticivil violations. Implicit citizenship revoked. Status: malignant." },
	{ "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav", "Attention please: unidentified person of interest, confirm your civil status with local protection team immediately." },
	{ "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav", "Attention please: evasion behavior consistant with malcompliant defendant. Ground protection team: alert. Code: isolate, expose, administer." },
	{ "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav", "Citizen reminder: inaction is conspiracy. Report counterbehavior to a civil protection team immediately." },
	{ "npc/overwatch/cityvoice/f_localunrest_spkr.wav", "Alert, community ground protection units: local unrest structure detected. Assemble, administer, pacify." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav", "Attention protection team: status evasion in progress in this community. Respond, isolate, inquire." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav", "Attention all ground protection teams: autonomous judgement is now in effect. Sentencing is now discretionary. Code: amputate, zero, confirm." },
	{ "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav", "Attention all ground protection teams: Judgement waiver now in effect. Capital prosecution is discretionary." },
	{ "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav", "Attention occupants: your block is now charged with permissive inactive coersion. Five ration units deducted." },
	{ "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav", "Individual: you are charged with socioendangerment level one. Protection units, prosecution code: duty, sword, midnight." },
	{ "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav", "Citizen notice: priority identification check in progress. Please assemble in your designated inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav", "Attention, please. All citizens in local residential block, assume your inspection positions." },
	{ "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav", "Attention, residents. Miscount detected in your block. Cooperation with your civil protection team permits full ration reward." },
	{ "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav", "Attention, residents. This block contains potential civil infection. Inform, cooperate, assemble." },
	{ "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav", "Citizen notice: failure to cooperate will result in permanent offworld relocation." },
	{ "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav", "Attention, community: unrest procedure code is now in effect. Inoculate, shield, pacify. Code: pressure, sword, sterilize." },
};

GM.BusinessLicenses = { };
GM.BusinessLicenses[LICENSE_FOOD] = { "Food/Drink", 500 };
GM.BusinessLicenses[LICENSE_ALCOHOL] = { "Alcohol", 700 };
GM.BusinessLicenses[LICENSE_ELECTRONICS] = { "Electronics", 1000 };
GM.BusinessLicenses[LICENSE_MISC] = { "Misc.", 400 };
GM.BusinessLicenses[LICENSE_BLACK] = { "Black Market Dealer" };

GM.Traits = { };
GM.Traits[TRAIT_NONE] = { "None", "Only English." };
GM.Traits[TRAIT_CONDUCTOR] = { "Turkish", "Can speak Turkish /tur." };
GM.Traits[TRAIT_ROCKY] = { "Bengali", "Can speak Bengali /ben." };
GM.Traits[TRAIT_LOYALIST] = { "Portugese", "Can speak Portugese /por." };
GM.Traits[TRAIT_GLUTTON] = { "Arabic", "Can speak Arabic /ara." };
GM.Traits[TRAIT_LUCKY] = { "Hindi", "Can speak in Hindi /hin." };
GM.Traits[TRAIT_MULE] = { "Czech", "Can speak Czech /cze." };
GM.Traits[TRAIT_SPY] = { "Sign Language", "Can speak in Sign Language /sig." };
GM.Traits[TRAIT_SPEEDY] = { "Vortigese", "Can speak Vortigese /vor (OBVIOUSLY FOR VORTIGAUNTS ONLY)" };
GM.Traits[TRAIT_GREASE] = { "Polish", "Can speak Polish with /pol." };
GM.Traits[TRAIT_RUSSIAN] = { "Russian", "Can speak Russian with /rus." };
GM.Traits[TRAIT_CHINESE] = { "Chinese", "Can speak Chinese with /chi." };
GM.Traits[TRAIT_JAPANESE] = { "Japanese", "Can speak Japanese with /jap." };
GM.Traits[TRAIT_SPANISH] = { "Spanish", "Can speak Spanish with /spa." };
GM.Traits[TRAIT_FRENCH] = { "French", "Can speak French with /fre." };
GM.Traits[TRAIT_GERMAN] = { "German", "Can speak German with /ger." };
GM.Traits[TRAIT_ITALIAN] = { "Italian", "Can speak Italian with /ita." };

GM.TraitsList = {
	TRAIT_CONDUCTOR,
	TRAIT_ROCKY,
	TRAIT_LOYALIST,
	TRAIT_GLUTTON,
	TRAIT_LUCKY,
	TRAIT_MULE,
	TRAIT_SPY,
	TRAIT_SPEEDY,
	TRAIT_GREASE,
	TRAIT_RUSSIAN,
	TRAIT_CHINESE,
	TRAIT_JAPANESE,
	TRAIT_SPANISH,
	TRAIT_FRENCH,
	TRAIT_GERMAN,
	TRAIT_ITALIAN
};

function meta:HasTrait( trait )
	
	if( bit.band( self:Trait(), trait ) == trait ) then return true; end
	return false;
	
end

function meta:IsEventCoordinator()
	
	return self:GetUserGroup() == "cake";
	
end

function game.GetIP()
	
	local hostip = tonumber( GetConVarString( "hostip" ) );
	
	local ip = { };
	ip[1] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 );
	ip[2] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 );
	ip[3] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 );
	ip[4] = bit.band( hostip, 0x000000FF );

	return table.concat( ip, "." );
	
end

function game.GetPort()
	
	return tonumber( GetConVarString( "hostport" ) );
	
end
