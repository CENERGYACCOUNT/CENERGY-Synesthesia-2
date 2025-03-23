GM.TimedProgressBars = { };

function GM:CreateTimedProgressBar( time, text, ply, cb )
	
	table.insert( self.TimedProgressBars, {
		Start = CurTime(),
		End = CurTime() + time,
		Text = text,
		Player = ply,
		CB = cb
	} );
	
end

function nCreateTimedProgressBar( len )
	
	local t = net.ReadFloat();
	local text = net.ReadString();
	local targ = net.ReadEntity();
	
	GAMEMODE:CreateTimedProgressBar( t, text, targ, function() end );
	
end
net.Receive( "nCreateTimedProgressBar", nCreateTimedProgressBar );

function nCReceiveCredits( len )
	
	local amt = net.ReadUInt( 32 );
	local ply = net.ReadEntity();
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", ply:VisibleRPName() .. " gave you " .. amt .. " credits.", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nCReceiveCredits", nCReceiveCredits );

function nCPattedDown( len )
	
	local inv = net.ReadTable();
	
	local panel = vgui.Create( "DFrame" );
	panel:SetSize( 800, 426 );
	panel:Center();
	panel:SetTitle( "Inventory" );
	panel.lblTitle:SetFont( "CombineControl.Window" );
	panel:MakePopup();
	panel.PerformLayout = CCFramePerformLayout;
	panel:PerformLayout();
	
	local model = vgui.Create( "DModelPanel", panel );
	model:SetPos( 420, 34 );
	model:SetModel( "" );
	model:SetSize( panel:GetWide() - 430, 200 );
	model:SetFOV( 20 );
	model:SetCamPos( Vector( 50, 50, 50 ) );
	model:SetLookAt( Vector( 0, 0, 0 ) );
	
	function model:LayoutEntity() end
	
	local p = model.Paint;
	
	function model:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	local title = vgui.Create( "DLabel", panel );
	title:SetText( "" );
	title:SetPos( 420, 244 );
	title:SetFont( "CombineControl.LabelGiant" );
	title:SetSize( panel:GetWide() - 430 - 110, 22 );
	title:PerformLayout();
	
	local desc = vgui.Create( "DLabel", panel );
	desc:SetText( "No item selected." );
	desc:SetPos( 420, 274 );
	desc:SetFont( "CombineControl.LabelSmall" );
	desc:SetSize( panel:GetWide() - 430, 14 );
	desc:SetAutoStretchVertical( true );
	desc:SetWrap( true );
	desc:PerformLayout();
	
	if( #inv == 0 ) then
		
		desc:SetText( "They don't have any items." );
		
	end
	
	local scroll = vgui.Create( "DScrollPanel", panel );
	scroll:SetPos( 10, 34 );
	scroll:SetSize( 400, panel:GetTall() - 50 );
	function scroll:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( inv ) do
		
		local icon = vgui.Create( "DModelPanel", scroll );
		icon.Item = v;
		icon.InventoryID = k;
		
		icon:SetPos( x, y );
		icon:SetModel( GAMEMODE:GetItemByID( icon.Item ).Model );
		icon:SetSize( 48, 48 );
		
		if( GAMEMODE:GetItemByID( icon.Item ).LookAt ) then
			
			icon:SetFOV( GAMEMODE:GetItemByID( icon.Item ).FOV );
			icon:SetCamPos( GAMEMODE:GetItemByID( icon.Item ).CamPos );
			icon:SetLookAt( GAMEMODE:GetItemByID( icon.Item ).LookAt );
			
		else
			
			local a, b = icon.Entity:GetModelBounds();
			
			icon:SetFOV( 20 );
			icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
			icon:SetLookAt( ( a + b ) / 2 );
			
		end
		
		if( GAMEMODE:GetItemByID( icon.Item ).IconMaterial ) then icon.Entity:SetMaterial( GAMEMODE:GetItemByID( icon.Item ).IconMaterial ) end
		if( GAMEMODE:GetItemByID( icon.Item ).IconColor ) then icon.Entity:SetColor( GAMEMODE:GetItemByID( icon.Item ).IconColor ) end
		
		function icon:LayoutEntity() end
		
		x = x + 48 + 10;
		
		if( x > scroll:GetWide() - 48 ) then
			
			x = 0;
			y = y + 48 + 10;
			
		end
		
		local p = icon.Paint;
		
		function icon:Paint( w, h )
			
			local pnl = self:GetParent():GetParent();
			local x2, y2 = pnl:LocalToScreen( 0, 0 );
			local w2, h2 = pnl:GetSize();
			render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
			
			p( self, w, h );
			
			render.SetScissorRect( 0, 0, 0, 0, false );
			
		end
		
		function icon:DoClick()
			
			if( model.Entity and model.Entity:IsValid() ) then
				
				model.Entity:SetMaterial( "" );
				model.Entity:SetColor( Color( 255, 255, 255, 255 ) );
				
			end
			
			model:SetModel( GAMEMODE:GetItemByID( self.Item ).Model );
			title:SetText( GAMEMODE:GetItemByID( self.Item ).Name );
			desc:SetText( GAMEMODE:GetItemByID( self.Item ).Description );
			
			if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
				
				model:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
				model:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
				model:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
				
			else
				
				local a, b = model.Entity:GetModelBounds();
				
				model:SetFOV( 20 );
				model:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				model:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then model.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
			if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then model.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
			
		end
		
	end
	
end
net.Receive( "nCPattedDown", nCPattedDown );

function GM:GetCCOptions( ent, dist )
	
	local tab = { };
	
	if( ent and ent:IsValid() and ent:GetClass() == "prop_ragdoll" ) then
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:Ragdoll() and v:Ragdoll():IsValid() and v:Ragdoll() == ent ) then
				
				ent = v;
				CCSelectedEnt = ent;
				
			end
			
		end
		
	end
	
	if( ent and ent:IsValid() ) then
		
		if( ent:IsPlayer() ) then
			
			local option = { "Examine", function()
				
				self:CCCreatePlayerViewer( CCSelectedEnt );
				
				net.Start( "nCExamine" );
				net.SendToServer();
				
			end, nil, self:GetPlayerSight() };
			
			table.insert( tab, option );
			
			if( LocalPlayer():TiedUp() ) then return tab end
			if( LocalPlayer():PassedOut() ) then return tab end
			
			local option = { "Give Credits", function()
				
				self:CCCreateGiveCredits();
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
			local option = { "Pat Down", function()
				
				net.Start( "nCPatDownStart" );
					net.WriteEntity( ent );
				net.SendToServer();
				
				local mul = 1;
				
				if( LocalPlayer():HasTrait( TRAIT_SPEEDY ) or ent:HasTrait( TRAIT_SPEEDY ) ) then
					
					mul = 0.5;
					
				end
				
				GAMEMODE:CreateTimedProgressBar( 5 * mul, "Patting Down...", ent, function()
					
					net.Start( "nCPatDown" );
						net.WriteEntity( ent );
					net.SendToServer();
					
				end );
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
			if( ent:TiedUp() ) then
				
				local option = { "Untie", function()
					
					net.Start( "nCUntieStart" );
						net.WriteEntity( ent );
					net.SendToServer();
					
					GAMEMODE:CreateTimedProgressBar( 2, "Untying...", ent, function()
						
						net.Start( "nCUntie" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			elseif( LocalPlayer():HasItem( "zipties" ) ) then
				
				local option = { "Tie Up", function()
				
	
					net.Start( "nCTieUpStart" );
						net.WriteEntity( ent );
					net.SendToServer();
					
					GAMEMODE:CreateTimedProgressBar( 5, "Tying...", ent, function()
						
						net.Start( "nCTieUp" );
							net.WriteEntity( ent );
						net.SendToServer();
						
					end );
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
			
		elseif( ent:GetClass() == "cc_item" ) then
			
			if( string.len( GAMEMODE:GetItemByID( ent:GetItem() ).Description ) > 0 ) then
				
				local option = { "Examine", function()
					
					self:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", GAMEMODE:GetItemByID( ent:GetItem() ).Description, { CB_ALL, CB_IC } );
					
					net.Start( "nCExamine" );
					net.SendToServer();
					
				end, nil, 100 };
				
				table.insert( tab, option );
				
			end
			
		elseif( ent:GetClass() == "cc_paper" ) then
			
			local option = { "Read", function()
				
				net.Start( "nCExamine" );
				net.SendToServer();
				
				local paper = vgui.Create( "DFrame" );
				paper:SetSize( 400, 600 );
				paper:Center();
				paper:SetTitle( "" );
				paper:MakePopup();
				paper.PerformLayout = CCFramePerformLayout;
				paper:PerformLayout();
				paper.Paint = function( panel, w, h )
					
					surface.SetDrawColor( 255, 255, 255, 255 );
					surface.DrawRect( 0, 0, w, h );
					
				end
				
				local entry = vgui.Create( "DTextEntry", paper );
				entry:SetFont( "CombineControl.Written" );
				entry:SetPos( 10, 34 );
				entry:SetSize( 380, 526 );
				entry:SetMultiline( true );
				entry:PerformLayout();
				entry:SetTextColor( Color( 0, 0, 0, 255 ) )
				entry:SetDrawBackground( false );
				entry:SetValue( ent:GetText() );
				entry:SetEditable( false );
				
			end, nil, 100 };
			
			table.insert( tab, option );
			
		end
		
	end
	
	if( GAMEMODE.VoicesEnabled and GAMEMODE.Voices[LocalPlayer():Gender()] ) then
		
		for k, v in pairs( GAMEMODE.Voices[LocalPlayer():Gender()] ) do
			
			local option = { "Voice: " .. v[1], function()
				
				net.Start( "nSayVoice" );
					net.WriteUInt( k, 8 );
				net.SendToServer();
				
			end, true };
			
			table.insert( tab, option );
			
		end
		
	end
	
	for k, v in pairs( self:GetValidGestures( LocalPlayer() ) ) do
		
		local option = { k, function()
			
			LocalPlayer():PlaySignal( v );
			
		end, true };
		
		table.insert( tab, option );
		
	end
	
	for k, v in pairs( self:GetValidExpressions( LocalPlayer() ) ) do
		
		local option = { k, function()
			
			net.Start( "nPlayExpression" );
				net.WriteString( v );
			net.SendToServer();
			
		end, true };
		
		table.insert( tab, option );
		
	end
	
	return tab;
	
end


function GM:CCCreateGiveCredits()
	
	CCP.GiveCredits = vgui.Create( "DFrame" );
	CCP.GiveCredits:SetSize( 250, 114 );
	CCP.GiveCredits:Center();
	CCP.GiveCredits:SetTitle( "Give Credits" );
	CCP.GiveCredits.lblTitle:SetFont( "CombineControl.Window" );
	CCP.GiveCredits:MakePopup();
	CCP.GiveCredits.PerformLayout = CCFramePerformLayout;
	CCP.GiveCredits:PerformLayout();
	
	CCP.GiveCredits.Entry = vgui.Create( "DTextEntry", CCP.GiveCredits );
	CCP.GiveCredits.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Entry:SetPos( 10, 34 );
	CCP.GiveCredits.Entry:SetSize( 100, 30 );
	CCP.GiveCredits.Entry:PerformLayout();
	CCP.GiveCredits.Entry:RequestFocus();
	CCP.GiveCredits.Entry:SetNumeric( true );
	CCP.GiveCredits.Entry:SetCaretPos( string.len( CCP.GiveCredits.Entry:GetValue() ) );
	
	CCP.GiveCredits.Label = vgui.Create( "DLabel", CCP.GiveCredits );
	CCP.GiveCredits.Label:SetText( "Credits" );
	CCP.GiveCredits.Label:SetPos( 120, 34 );
	CCP.GiveCredits.Label:SetSize( 130, 30 );
	CCP.GiveCredits.Label:SetFont( "CombineControl.LabelBig" );
	CCP.GiveCredits.Label:PerformLayout();
	
	CCP.GiveCredits.OK = vgui.Create( "DButton", CCP.GiveCredits );
	CCP.GiveCredits.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.GiveCredits.OK:SetText( "OK" );
	CCP.GiveCredits.OK:SetPos( 190, 74 );
	CCP.GiveCredits.OK:SetSize( 50, 30 );
	function CCP.GiveCredits.OK:DoClick()
		
		if( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) then return end
		
		local val = tonumber( CCP.GiveCredits.Entry:GetValue() );
		
		if( !val or math.floor( val ) < 1 ) then
			
			CCP.GiveCredits:Remove();
			return;
			
		end
		
		if( LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > 100 ) then
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "They're too far away.", { CB_ALL, CB_OOC } );
			return;
			
		end
		
		val = math.floor( val );
		
		if( LocalPlayer():Money() >= val ) then
			
			CCP.GiveCredits:Remove();
			
			net.Start( "nCGiveCredits" );
				net.WriteUInt( val, 32 );
				net.WriteEntity( CCSelectedEnt );
			net.SendToServer();
			
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You gave " .. CCSelectedEnt:VisibleRPName() .. " " .. val .. " credits.", { CB_ALL, CB_OOC } );
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't have this many credits!", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.GiveCredits.OK:PerformLayout();
	
	CCP.GiveCredits.Entry.OnEnter = CCP.GiveCredits.OK.DoClick;
	
end

function GM:CCCreatePlayerViewer( ent )
	
	if( !ent or !ent:IsValid() ) then return end
	
	CCP.PlayerViewer = vgui.Create( "DFrame" );
	CCP.PlayerViewer:SetSize( 800, 426 );
	CCP.PlayerViewer:Center();
	CCP.PlayerViewer:SetTitle( ent:VisibleRPName() );
	CCP.PlayerViewer.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerViewer:MakePopup();
	CCP.PlayerViewer.PerformLayout = CCFramePerformLayout;
	CCP.PlayerViewer:PerformLayout();
	
	CCP.PlayerViewer.CharacterModel = vgui.Create( "DModelPanel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterModel:SetPos( 10, 34 );
	CCP.PlayerViewer.CharacterModel:SetModel( ent:GetModel() );
	CCP.PlayerViewer.CharacterModel.Entity:SetSkin( ent:GetSkin() );
	for i = 0,  20 do
		CCP.PlayerViewer.CharacterModel.Entity:SetBodygroup( i, ent:GetBodygroup( i ) );
		CCP.PlayerViewer.CharacterModel.Entity:SetSubMaterial( i, ent:GetSubMaterial( i ) );
	end
	
	CCP.PlayerViewer.CharacterModel:SetSize( 200, 382 );
	CCP.PlayerViewer.CharacterModel:SetFOV( 20 );
	CCP.PlayerViewer.CharacterModel:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.PlayerViewer.CharacterModel:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.PlayerViewer.CharacterModel:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.PlayerViewer.CharacterModel.Entity:GetPlayerColor()
		
		if( !ent or !ent:IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return ent:GetPlayerColor();
		
	end
	
	CCP.PlayerViewer.CharacterName = vgui.Create( "DLabel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterName:SetText( ent:RPName() );
	CCP.PlayerViewer.CharacterName:SetPos( 220, 34 );
	CCP.PlayerViewer.CharacterName:SetSize( 540, 22 );
	CCP.PlayerViewer.CharacterName:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerViewer.CharacterName:PerformLayout();
	
	CCP.PlayerViewer.CharacterDescScroll = vgui.Create( "DScrollPanel", CCP.PlayerViewer );
	CCP.PlayerViewer.CharacterDescScroll:SetPos( 220, 64 );
	CCP.PlayerViewer.CharacterDescScroll:SetSize( 540, 352 );
	function CCP.PlayerViewer.CharacterDescScroll:Paint( w, h ) end
	
	CCP.PlayerViewer.CharacterDesc = vgui.Create( "CCLabel" );
	CCP.PlayerViewer.CharacterDesc:SetPos( 0, 0 );
	CCP.PlayerViewer.CharacterDesc:SetSize( 530, 10 );
	CCP.PlayerViewer.CharacterDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerViewer.CharacterDesc:SetText( ent:Description() );
	CCP.PlayerViewer.CharacterDesc:PerformLayout();
	
	CCP.PlayerViewer.CharacterDescScroll:AddItem( CCP.PlayerViewer.CharacterDesc );
	
end

function GM:CreateCCContext( ent )
	
	CloseDermaMenus();
	
	CCSelectedEnt = ent;
	local dist = 0;
	
	if( ent and ent:IsValid() ) then
		
		dist = LocalPlayer():GetPos():Distance( ent:GetPos() );
		
	end
	
	local options = self:GetCCOptions( CCSelectedEnt, dist );
	
	gui.EnableScreenClicker( true );
	
	local menu = DermaMenu();
	menu:SetPos( gui.MousePos() );
	
	for _, v in pairs( options ) do
		
		if( !v[4] or ( v[4] and dist <= v[4] ) ) then
			
			menu:AddOption( v[1], function()
				
				gui.EnableScreenClicker( false );
				
				if( ( !CCSelectedEnt or !CCSelectedEnt:IsValid() ) and !v[3] ) then return end
				
				if( !v[3] and CCSelectedEnt and CCSelectedEnt:IsValid() and LocalPlayer():GetPos():Distance( CCSelectedEnt:GetPos() ) > v[4] ) then return end
				
				v[2]( CCSelectedEnt );
				
			end );
			
		end
		
	end
	
	menu:Open();
	
end

function GM:RemoveCCContext( d )
	
	gui.EnableScreenClicker( false );
	CloseDermaMenus();
	
end