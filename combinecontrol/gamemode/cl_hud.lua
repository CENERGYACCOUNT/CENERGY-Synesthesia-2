GM.FontFace = "Myriad Pro";

GM.FontHeight = { };

function surface.CreateFontCC( name, tab )
	
	surface.CreateFont( name, tab );
	GM.FontHeight[name] = tab.size;
	
end

surface.CreateFontCC( "CombineControl.Window", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.GUIClose", {
	font = GM.FontFace,
	size = 16,
	weight = 900 } );

surface.CreateFontCC( "CombineControl.LabelTiny", {
	font = GM.FontFace,
	size = 12,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmall", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmallItalic", {
	font = GM.FontFace,
	size = 14,
	weight = 500,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.LabelMedium", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelBig", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelGiant", {
	font = GM.FontFace,
	size = 22,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelMassive", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelStupid", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatSmall", {
	font = GM.FontFace,
	size = 15,
	weight = 350 } );
	
surface.CreateFontCC( "CombineControl.ChatSmallItalic", {
	font = GM.FontFace,
	size = 15,
	weight = 350,
	italic = true } );

surface.CreateFontCC( "CombineControl.ChatNormal", {
	font = GM.FontFace,
	size = 20,
	weight = 650 } );
	
surface.CreateFontCC( "CombineControl.ChatNormalItalic", {
	font = GM.FontFace,
	size = 20,
	weight = 650,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatRadio", {
	font = "Digital-7",
	size = 20,
	weight = 650 } );

surface.CreateFontCC( "CombineControl.CombineCamera", {
	font = "Courier New",
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.CombineCameraSmall", {
	font = "Courier New",
	size = 15,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatBig", {
	font = GM.FontFace,
	size = 25,
	weight = 700 } );

	
surface.CreateFontCC( "CombineControl.ChatBigItalic", {
	font = GM.FontFace,
	size = 25,
	weight = 700,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatHuge", {
	font = GM.FontFace,
	size = 30,
	weight = 750 } );

surface.CreateFontCC( "CombineControl.HL2CreditText", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900 } );
	
surface.CreateFontCC( "CombineControl.PlayerFont", {
	font = GM.FontFace,
	size = 17,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.HUDAmmo", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.HUDAmmoSmall", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectHeader", {
	font = GM.FontFace,
	size = 20,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.WepSelectWep", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectInfo", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );

surface.CreateFont("CyberHUD", {
    font = "Digital-7", -- Sci-fi hacker-style font
    size = 14, -- Adjust size as needed
    weight = 500,
})

surface.CreateFont("CyberHUDSmall", {
    font = "Digital-7", -- Sci-fi hacker-style font
    size = 11, -- Adjust size as needed
    weight = 500,
})

surface.CreateFont("CyberHUDTiny", {
    font = "Digital-7", -- Sci-fi hacker-style font
    size = 9, -- Adjust size as needed
    weight = 110,
})

surface.CreateFont("CyberHUDBig", {
    font = "Digital-7", -- Sci-fi hacker-style font
    size = 20, -- Adjust size as needed
    weight = 500,
})

surface.CreateFont("CyberHUDLarge", {
    font = "Digital-7", -- Sci-fi hacker-style font
    size = 35, -- Adjust size as needed
    weight = 500,
})
	
surface.CreateFontCC( "CombineControl.Written", {
	font = "Comic Sans MS",
	size = 20,
	weight = 700 } );

language.Add( "npc_clawscanner", "Claw Scanner" );
language.Add( "npc_combine_camera", "Combine Camera" );
language.Add( "npc_helicopter", "Helicopter" );
language.Add( "npc_barnacle_tongue_tip", "Barnacle Tongue Tip" );
language.Add( "prop_vehicle_apc", "APC" );
language.Add( "npc_fisherman", "Fisherman" );
	
function draw.DrawTextShadow( text, font, x, y, col1, col2, align )
	
	if( align != 0 ) then
		
		draw.DrawText( text, font, x + 1, y + 1, col2, align ); -- Less efficient than surface, so we only use this if we need special alignment stuff.
		draw.DrawText( text, font, x, y, col1, align );
		
	else
		
		surface.SetFont( font );
		
		surface.SetTextColor( col2 );
		surface.SetTextPos( x + 1, y + 1 );
		surface.DrawText( text );
		surface.SetTextColor( col1 );
		surface.SetTextPos( x, y );
		surface.DrawText( text );
		
	end
	
end

local matBlurScreen = Material( "pp/blurscreen" );

function draw.DrawBackgroundBlur( frac )
	
	DisableClipping( true );
	
	surface.SetMaterial( matBlurScreen );
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	for i = 1, 3 do
		
		matBlurScreen:SetFloat( "$blur", frac * 5 * ( i / 3 ) )
		matBlurScreen:Recompute();
		render.UpdateScreenEffectTexture();
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	DisableClipping( false );

end

GM.ThirdCurPos = Vector();
GM.ThirdCurAng = Angle();
GM.ThirdDestPos = Vector();
GM.ThirdDestAng = Angle();

function GM:ShouldDoThirdPerson( ply )
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() and wep != NULL ) then
		
		if( wep.InScope and wep:InScope() ) then
			
			return false;
			
		end
		
	end
	
	if( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
		
		return false;
		
	end
	
	if( ply:GetViewEntity() != ply ) then
		
		return false;
		
	end
	
	return true;
	
end

function GM:CalcView( ply, pos, ang, fov, znear, zfar )

    local view = self.BaseClass:CalcView( ply, pos, ang, fov, znear, zfar )


    -- Apply headbob only if enabled and not in scope
    if cookie.GetNumber("cc_headbob", 0) == 1 then
        local hmul = 0
        local len2d = ply:GetVelocity():Length2D()

        if len2d > 5 and ply:GetMoveType() ~= MOVETYPE_NOCLIP and ply:OnGround() then
            hmul = math.Clamp(len2d / 200, 0, 1)
        end

        if hmul > 0 then
            view.angles.p = view.angles.p + math.sin(CurTime() * 5) * hmul
            view.angles.y = view.angles.y + math.cos(CurTime() * 4) * 0.5 * hmul
        end

    return view
end

	
	if( cookie.GetNumber( "cc_thirdperson", 0 ) == 1 and ply:Alive() ) then
		
		if( self:ShouldDoThirdPerson( ply ) ) then
			
			local hitpos = ply:GetEyeTrace().HitPos;
			local targetpos = view.origin;
			
			local distance = 50;
			
			local wep = ply:GetActiveWeapon();
			
			if( !ply:Holstered() and wep and wep:IsValid() and wep != NULL ) then
				
				if( ply:KeyDown( IN_ATTACK2 ) and wep.IronMode ) then
					
					distance = 25;
					
				end
				
			end
			
			self.ThirdDestAng = view.angles;
			self.ThirdDestPos = targetpos - self.ThirdDestAng:Forward() * distance;
			
			local trace = { };
			trace.start = view.origin;
			trace.endpos = self.ThirdDestPos;
			trace.filter = ply;
			
			local tr = util.TraceLine( trace );
			
			self.ThirdDestPos = view.origin + tr.Normal * ( distance - 2 ) * tr.Fraction;
			
			self.ThirdCurPos = LerpVector( 0.08, self.ThirdCurPos, self.ThirdDestPos );
			self.ThirdCurAng = LerpAngle( 0.08, self.ThirdCurAng, self.ThirdDestAng );
			
			view.angles = self.ThirdCurAng;
			view.origin = self.ThirdCurPos;
			
		else
			
			self.ThirdCurPos = view.origin;
			self.ThirdCurAng = view.angles;
			
		end
		
	else
		
		self.ThirdCurPos = view.origin;
		self.ThirdCurAng = view.angles;
		
	end
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() ) then
		
		if( wep.TranslateFOV ) then
			
			view.fov = wep:TranslateFOV( view.fov );
			
		end
		
	end
	
	return view;
	
end

function GM:ShouldDrawLocalPlayer( ply )
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		return true;
		
	end
	
	if( cookie.GetNumber( "cc_thirdperson", 0 ) == 1 ) then
		
		return self:ShouldDoThirdPerson( ply );
		
	end
	
	return false;
	
end

function GM:DrawCharCreate()
	
	if( self.CharCreate ) then
		
		if( !self.GetHL2CamPos ) then
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		else
			
			draw.DrawBackgroundBlur( 1 );
			
		end
		
	end
	
end




function GM:DrawTimedProgress()
	
	local yc = 0;
	
	if( !self.TimedProgressBars ) then self.TimedProgressBars = { } end
	
	for k, v in pairs( self.TimedProgressBars ) do
		
		if( v.Start and CurTime() < v.End ) then
			
			if( !v.Player or !v.Player:IsValid() or v.Player:GetPos():Distance( LocalPlayer():GetPos() ) > 100 or v.Player:GetVelocity():Length() > 5 or LocalPlayer():GetVelocity():Length() > 5 ) then
				
				table.remove( self.TimedProgressBars, k );
				continue;
				
			end
			
			surface.SetDrawColor( 30, 30, 30, 200 );
			surface.DrawRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40 + yc, 400, 40 );
			
			surface.SetDrawColor( 150, 20, 20, 255 );
			surface.DrawRect( ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1 + yc, ( 400 - 2 ) * math.min( ( CurTime() - v.Start ) / ( v.End - v.Start ), 1 ), 40 - 2 );
			
			local y = self.FontHeight["CombineControl.LabelBig"];
			
			draw.DrawText( v.Text, "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2 + yc, Color( 200, 200, 200, 255 ), 1 );
			
		end
		
		if( v.End and CurTime() >= v.End ) then
			
			v.CB( self );
			
			table.remove( self.TimedProgressBars, k );
			
		end
		
		yc = yc + 60;
		
	end
	
end


function GM:DrawPlayerInfo()
	
	if( GAMEMODE:Combat() == 1 ) then
		
		if( !LocalPlayer():Alive() ) then

				
			
			return;
			
		end
	
	if( GAMEMODE:TurnGood() == 1 ) then
draw.DrawText( "ALLIED TURN", "CombineControl.LabelGiant", ScrW() / 3, ScrH() / 85, Color( 50, 300, 50, 255 ), 1 );
end

	if( GAMEMODE:TurnBad() == 1 ) then
draw.DrawText( "ALLIED TURN", "CombineControl.LabelGiant", ScrW() / 1.5, ScrH() / 85, Color( 300, 50, 50, 255 ), 1 );
end

	draw.RoundedBox( 15, 750, ScrH() - 177, 400, 502, Color( 0, 0, 0, 200 ) );

		draw.DrawText( "COMBAT MODE IS ON", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 85, Color( 520, 520, 520, 255 ), 1 );


			
			draw.DrawText( "Energy Points: " .. LocalPlayer():Energy() .. "", "CyberHUD", ScrW() / 2, ScrH() / 1.13, Color( 250, 250, 250, 200 ), 1 );

draw.DrawText( "Ultimate Points: " .. LocalPlayer():Ultimate() .. "", "CyberHUD", ScrW() / 2, ScrH() / 1.16, Color( 255, 100, 255, 200 ), 1 );


		draw.DrawText( "HP: " .. LocalPlayer():Health() .. "%", "CyberHUD",  ScrW() / 2, ScrH() / 1.105, Color( 200, 250, 200, 255 ), 1 );
		

		draw.DrawText( "Movement: " .. LocalPlayer():Movement() .. "", "CyberHUD",ScrW() / 2, ScrH() / 1.08, Color( 50, 200, 255, 200 ), 1 );


		draw.DrawText( "Attack Points: " .. LocalPlayer():Attack() .. "", "CyberHUD", ScrW() / 2, ScrH() / 1.055, Color( 255, 50, 50, 200 ), 1 );

		draw.DrawText( "Special Points: " .. LocalPlayer():Special() .. "", "CyberHUD", ScrW() / 2, ScrH() / 1.032, Color( 255, 255, 50, 200 ), 1 );





end
 end 
function GM:DrawHealthBars()
end

function GM:GetPlayerSight()
	
	local range = 2506;
	return range;
	
end

GM.NPCDrawBlacklist = {
	"npc_antlion_grub",
	"npc_barnacle_tongue_tip",
	"npc_bullseye",
	"monster_generic"
}

function GM:DrawEntities()
    if (self.SeeAll and not LocalPlayer():IsAdmin()) then
        self.SeeAll = false
        return
    end

local lastGlitchTime = 2
local glitchInterval = 52  -- Time in seconds between glitches (smaller is more frequent)
local glitchStrength = 0.05  -- How much the text moves during glitches

local waypointNames = {
    cc_waypoint1 = "FACTORY WAYPOINT",
    cc_waypoint2 = "RUINS WAYPOINT",
    cc_waypoint3 = "TARGET - CRYSTAL QUARRY",
    cc_waypoint4 = "MOOR's BRIGADE OUTPOST",
    cc_waypoint5 = "TARGET - PICK UP POINT"
}

hook.Add("HUDPaint", "DrawWaypointText", function()
    for waypointClass, waypointLabel in pairs(waypointNames) do
        for _, v in pairs(ents.FindByClass(waypointClass)) do
            if not v.HUDAlpha then v.HUDAlpha = 1 end  -- Always fully visible

            local a, b = v:GetRotatedAABB(v:OBBMins(), v:OBBMaxs())
            local wpos = (v:GetPos() + (a + b) / 2)
            local pos = wpos:ToScreen()

            -- Glitch effect logic
            if CurTime() - lastGlitchTime > glitchInterval then
                lastGlitchTime = CurTime()
            end

            local glitchX = pos.x + math.random(-glitchStrength, glitchStrength)
            local glitchY = pos.y + math.random(-glitchStrength, glitchStrength)

            -- Draw glitchy background text
            draw.SimpleTextOutlined("⥥", "CyberHUDLarge", glitchX, glitchY, 
                Color(255, 255,255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))

             draw.SimpleTextOutlined(waypointLabel, "CyberHUD", glitchX, glitchY + 20, 
                Color(255, 255,255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
        end
    end
end)


local lastGlitchTime = 2
local glitchInterval = 52  -- Time in seconds between glitches (smaller is more frequent)
local glitchStrength = 0.05  -- How much the text moves during glitches

hook.Add("HUDPaint", "DrawEntityTextForPlayers", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    for _, v in pairs(player.GetAll()) do
        -- Ensure it's not the local player and we are looking at the player
        if v ~= LocalPlayer() then
            -- Get the position above the player's head
            local worldPos = (v:EyePos() + Vector(0, 0, 15))  -- 15 units above the player

            -- Convert world position to screen space
            local pos = worldPos:ToScreen()

            -- Check if the player is visible
            local canSeePlayer = ply:CanSee(v)

            -- Only proceed if the player is visible
            if canSeePlayer then
                -- Glitch effect logic: Only update the glitch effect at certain intervals
                if CurTime() - lastGlitchTime > glitchInterval then
                    lastGlitchTime = CurTime()
                end

                -- Apply random jitter for glitch effect
                local glitchX = pos.x + math.random(-glitchStrength, glitchStrength)
                local glitchY = pos.y + math.random(-glitchStrength, glitchStrength)

                -- Draw the glitchy text with the jitter effect
                draw.SimpleTextOutlined("████████████████████", "CyberHUD", glitchX, glitchY, 
                    Color(0, 0, 0, 15), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 15))

                -- Draw the player's RP name with glitch effect
                draw.SimpleTextOutlined(v:VisibleRPName(), "CyberHUD", glitchX, glitchY + -1, 
                    Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))
            end
        end
    end
end)


	
	for _, v in pairs( ents.FindByClass( "cc_item" ) ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = v:GetPos():ToScreen();
		
		if( self.SeeAll or ( pos.visible and LocalPlayer():CanSee( v ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < self:GetPlayerSight() / 2 ) ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( GAMEMODE:GetItemByID( v:GetItem() ).Name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			draw.DrawTextShadow( "Weight - " .. tostring( GAMEMODE:GetItemByID( v:GetItem() ).Weight ), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 16;
			
		end
		
	end






hook.Add("HUDPaint", "DrawEntityTextForPlayers", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    -- Define hitgroups and the corresponding body part names
    local hitGroups = {
        [HITGROUP_HEAD] = "Aiming At: Head",
        [HITGROUP_CHEST] = "Aiming At: Chest",
        [HITGROUP_STOMACH] = "Aiming At: Stomach",
        [HITGROUP_LEFTARM] = "Aiming At: Left Arm",
        [HITGROUP_RIGHTARM] = "Aiming At: Right Arm",
        [HITGROUP_LEFTLEG] = "Aiming At: Left Leg",
        [HITGROUP_RIGHTLEG] = "Aiming At: Right Leg",
    }

    -- Function to get defense stats based on hitgroup
    local function getDefenseStats(V, hitGroup)
        -- Default stats
        local stats = {Blunt = 0, Slash = 0, Bullet = 0, Heat = 0}

        -- Check hitGroup and assign appropriate defense stats
        if hitGroup == HITGROUP_HEAD then
            stats.Blunt = V:BluntHeadDefenseTemporary() or 0
            stats.Slash = V:SlashHeadDefenseTemporary() or 0
            stats.Bullet = V:BulletHeadDefenseTemporary() or 0
            stats.Heat = V:HeatHeadDefenseTemporary() or 0
        elseif hitGroup == HITGROUP_CHEST then
            stats.Blunt = V:BluntChestDefenseTemporary() or 0
            stats.Slash = V:SlashChestDefenseTemporary() or 0
            stats.Bullet = V:BulletChestDefenseTemporary() or 0
            stats.Heat = V:HeatChestDefenseTemporary() or 0
        elseif hitGroup == HITGROUP_LEFTARM or hitGroup == HITGROUP_RIGHTARM then
            stats.Blunt = V:BluntArmsDefenseTemporary() or 0
            stats.Slash = V:SlashArmsDefenseTemporary() or 0
            stats.Bullet = V:BulletArmsDefenseTemporary() or 0
            stats.Heat = V:HeatArmsDefenseTemporary() or 0
        elseif hitGroup == HITGROUP_LEFTLEG or hitGroup == HITGROUP_RIGHTLEG then
            stats.Blunt = V:BluntLegsDefenseTemporary() or 0
            stats.Slash = V:SlashLegsDefenseTemporary() or 0
            stats.Bullet = V:BulletLegsDefenseTemporary() or 0
            stats.Heat = V:HeatLegsDefenseTemporary() or 0
        end

        return stats
    end

    for _, v in pairs(player.GetAll()) do
        -- Ensure it's not the local player
        if v ~= LocalPlayer() then
            -- Get the trace information of where the player is looking
            local tr = ply:GetEyeTrace()

            -- Check if the player is looking at this player
            if tr.Entity == v then
                -- Get the position above the player's head
                local worldPos = (v:EyePos() + Vector(0, 0, 15))  -- 15 units above the player

                -- Convert world position to screen space
                local pos = worldPos:ToScreen()

                -- Glitch effect logic: Only update the glitch effect at certain intervals
                if CurTime() - lastGlitchTime > glitchInterval then
                    lastGlitchTime = CurTime()
                end

                -- Apply random jitter for glitch effect
                local glitchX = pos.x + math.random(-glitchStrength, glitchStrength)
                local glitchY = pos.y -35 + math.random(-glitchStrength, glitchStrength)
	if( v:BadGuy() ) then
		
                -- Draw the player's RP name with glitch effect
                draw.SimpleTextOutlined(v:VisibleRPName() .. "", "CyberHUDBig", glitchX, glitchY +10, 
                    Color(217, 8, 82, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))

            else if( v:GoodGuy() ) then
          draw.SimpleTextOutlined(v:VisibleRPName() .. "", "CyberHUDBig", glitchX, glitchY +10, 
                    Color(50, 200, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))

      else

  draw.SimpleTextOutlined(v:VisibleRPName() .. "", "CyberHUDBig", glitchX, glitchY +10, 
                    Color(245, 255, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))
	if( v:PVT() ) then
    draw.SimpleTextOutlined(v:VisibleRPName() .. "Pvt", "CyberHUDBig", glitchX, glitchY +10, 
                    Color(245, 255, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255)) end

end
end 
                -- Check if player is within 500 units of the local player
  
    -- Create a table to store active statuses
    local statusList = {}

    if v.Supressed and v:Supressed() then
        table.insert(statusList, "Suppressed")
    end
    if v.CrippledLeg and v:CrippledLeg() then
        table.insert(statusList, "Crippled Leg")
    end
    if v.CrippledArm and v:CrippledArm() then
        table.insert(statusList, "Crippled Arm")
    end
        if v.Targeted and v:Targeted() then
        table.insert(statusList, "Order: Priority Target!")
    end

        if v.Tracked and v:Tracked() then
        table.insert(statusList, "Order: Attack!")
    end
        if v.Revealed and v:Revealed() then
        table.insert(statusList, "Order: Shred Armor!")
    end
    if v.Revealed and v:Downed() then
        table.insert(statusList, "Downed!")
    end

      if v.Revealed and v:Stunned() then
        table.insert(statusList, "Stunned!")
    end

    -- Convert the table into a single string separated by commas
    local statusText = table.concat(statusList, "  |  ")

    -- Determine the starting Y position
    local textOffset = 35  -- Default position for status text

    -- If there are active statuses, draw them
    if statusText ~= "" then
        draw.SimpleTextOutlined(statusText, "CyberHUDSmall", glitchX, glitchY + textOffset, 
            Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))
        
        -- Move typing text down if statuses exist
        textOffset = textOffset + 10
    end
     if v:GetPos():Distance(ply:GetPos()) <= 500 then
    -- Check if the player is typing
    if v:Typing() > 0 then
        draw.SimpleTextOutlined("Typing...", "CyberHUDSmall", glitchX, glitchY + textOffset, 
            Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))
    end
end

               

                                -- Collect status effects into a single string
       


                -- Get the hitgroup from the trace
                local hitGroup = tr.HitGroup

                -- Set the body part name based on the hitgroup
                local bodyPartText = hitGroups[hitGroup] or "Unknown"  -- Default to "Unknown" if no hitgroup matches

                -- Get the defense stats for the current body part
                local defenseStats = getDefenseStats(v, hitGroup)

                -- Format the defense stats to display
                local defenseText = "Blunt: " .. defenseStats.Blunt .. " | Slash: " .. defenseStats.Slash .. 
                                    " | Bullet: " .. defenseStats.Bullet .. " | Heat: " .. defenseStats.Heat
                local defenseTextWidth, defenseTextHeight = surface.GetTextSize(defenseText)

                -- Health bar logic
                local health = v:Health()
                local maxHealth = v:GetMaxHealth()

                -- Draw health bar background
                draw.RoundedBox(0, glitchX - 100, glitchY + 15, 200, 7.5, Color(0, 0, 0, 100))  -- Double width

                -- Draw health bar based on current health

                	if( v:BadGuy() ) then
                local healthWidth = (health / maxHealth) * 200  -- Double width
                draw.RoundedBox(0, glitchX - 100, glitchY + 15, healthWidth, 7.5, Color(217, 8, 82, 150))

            else if( v:GoodGuy() ) then

       local healthWidth = (health / maxHealth) * 200  -- Double width
                draw.RoundedBox(0, glitchX - 100, glitchY + 15, healthWidth, 7.5, Color(50, 200, 255, 150 ))
            else
       local healthWidth = (health / maxHealth) * 200  -- Double width
                draw.RoundedBox(0, glitchX - 100, glitchY + 15, healthWidth, 7.5, Color(245, 255, 0, 150))

            end end
                -- Draw defense stats
                draw.SimpleTextOutlined(defenseText, "CyberHUDSmall", glitchX, glitchY +23,
                    Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, 255))
            end
        end
    end
end)






	for _, v in pairs( ents.FindByClass( "npc_*" ) ) do
		
		if( table.HasValue( self.NPCDrawBlacklist, v:GetClass() ) ) then continue; end
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = ( v:EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
		
		if( self.SeeAll and v:Health() > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( "#" .. v:GetClass(), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 100, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
		end

			if( v.HUDAlpha > 0 ) then
			
			local name = v:DoorOriginalName();
			
			if( v:DoorName() != "" ) then
				
				name = v:DoorName();
				
			end
			
			draw.DrawTextShadow( name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + 20;
			


				
			end 
		
	end
	
end

GM.WeaponOutText = { };
GM.WeaponOutText["weapon_physgun"] = "Your physgun is out! Switch to your hands when you're done building.";
GM.WeaponOutText["weapon_physcannon"] = "Your gravgun is out! Switch to your hands when you're done moving things.";
GM.WeaponOutText["gmod_tool"] = "Your toolgun is out! Switch to your hands when you're done building.";

function GM:DrawAmmo()
	
	if( LocalPlayer():InVehicle() ) then
		
		return;
		
	end
	
	local w = LocalPlayer():GetActiveWeapon();
	
	if( w != NULL ) then
		
 


			
			
	
		
		if( w.Firearm ) then
			
			if( w.Primary.ClipSize > -1 ) then
				
				local clip = w:Clip1();
				local ammo = w:Ammo1();
				
				surface.SetFont( "CombineControl.HUDAmmo" );
				local x1, y1 = surface.GetTextSize( clip );
				local y2 = self.FontHeight["CombineControl.HUDAmmo"];
				
				local x = x1;
				local y = math.max( y1, y2 );
				
				draw.RoundedBox( 10, ScrW() - 700 - x, ScrH() - -10 - y, x + 4, y + 4, Color( 0, 0, 0, 200 ) );
				draw.DrawTextShadow( clip, "CyberHUDLarge", ScrW() - 690 - x, ScrH() - -13 - y, Color(217, 8, 82, 200), Color( 217, 8, 82, 200 ), 0 );
				
			end
			
		end
		
	end
	
end

function GM:DrawUnconnected()
	
	if( !self.CharCreateOpened ) then
		
		surface.SetDrawColor( Color( 0, 0, 0, 150 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		draw.DrawBackgroundBlur( 1 );
		
		draw.DrawText( "Uh we're having some technical difficulties. Try rejoining and if that doesn't fix it then we're working on it.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
		
	end
	
end

function nFlashRed( len )
		
	GAMEMODE.FlashRedStart = CurTime();
	
end
net.Receive( "nFlashRed", nFlashRed );

function GM:DrawDamage()
	
	if( self.FlashRedStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashRedStart;
		local a = 0;
	    

		if( t < 0.1 ) then
			
			a = 0.5;
			
		elseif( t < 0.6 ) then
			
			a = 0.5 - ( t - 0.1 );
			
		end
		
		if( a > 0 ) then
			
			surface.SetDrawColor( 128, 0, 0, 255 * a );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		end
		
	end
	
end

GM.Notifications = { };

function nAddNotification( len )
	
	local str = net.ReadString();
	GAMEMODE:AddNotification( str );
	
end
net.Receive( "nAddNotification", nAddNotification );

function GM:AddNotification( text, col )
	
	local n = 0;
	
	for _, m in pairs( self.Notifications ) do
		
		for _, v in pairs( self.Notifications ) do
			
			if( v[3] == n ) then
				
				n = v[3] + 1;
				
			end
			
		end
		
	end
	
	table.insert( self.Notifications, { text, CurTime(), n, col } );
	
end

function GM:DrawNotifications()
	
	for k, v in pairs( self.Notifications ) do
		
		local t = v[2];
		local n = v[3];
		local col = v[4];
		
		if( CurTime() - t > 10 ) then
			
			table.remove( self.Notifications, k );
			continue;
			
		end
		
		local a = 1;
		
		if( CurTime() - t < 0.5 ) then
			
			a = ( CurTime() - t ) / 0.5;
			
		elseif( CurTime() - t > 6 ) then
			
			a = 1 - ( CurTime() - t - 6 ) / 4;
			
		end
		
		if( !col ) then
			
			col = Color( 200, 200, 200, 255 * a )
			
		else
			
			col = Color( col.r, col.g, col.b, 255 * a )
			
		end
		
		surface.SetFont( "CombineControl.LabelGiant" );
		local x1, y1 = surface.GetTextSize( v[1] );
		
		draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ), x1 + 4, y1 + 4, Color( 30, 30, 30, 200 * a ) );
		draw.DrawTextShadow( v[1], "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ) + 2, Color( 200, 200, 200, 255 * a ), Color( 0, 0, 0, 255 * a ), 0 );
		
	end
	
end

function GM:HUDPaint()
	
	if( !CCP ) then return end
	
	self:DrawCharCreate();
	
	if( !self.CharCreate ) then
		
		if( cookie.GetNumber( "cc_hud", 1 ) == 1 and !self.Mastermind ) then
			
			self:DrawDamage();
			self:DrawDrugs();
			self:DrawEntities();
			self:DrawPlayerInfo();
			self:DrawHealthBars();
			self:DrawAmmo();
			self:DrawWeaponSelect();
			self:DrawTimedProgress();
			self:DrawNotifications();
			
		end
		
		if( self.Mastermind ) then
			
			self:DrawEntities();
			
		end
		
		if( cookie.GetNumber( "cc_chat", 1 ) == 1 ) then
			
			self:DrawChat();
			
		end
		
		if( cookie.GetNumber( "cc_hud", 1 ) != 1 ) then
			
			self:DrawWeaponSelect();

			
		end
		
		self:DrawUnconnected();
		
	end
	
end

function GM:HUDShouldDraw( str )
	
	if( str == "CHudWeaponSelection" ) then return false end
	if( str == "CHudAmmo" ) then return false end
	if( str == "CHudAmmoSecondary" ) then return false end
	if( str == "CHudHealth" ) then return false end
	if( str == "CHudBattery" ) then return false end
	if( str == "CHudChat" ) then return false end
	if( str == "CHudDamageIndicator" ) then return false end
	
	if( str == "CHudCrosshair" ) then
		
		local wep = LocalPlayer():GetActiveWeapon();
		
		if( wep and wep:IsValid() and wep != NULL ) then
			
			if( wep:GetClass() == "gmod_tool" or wep:GetClass() == "weapon_physgun" or wep:GetClass() == "weapon_physcannon" ) then
				
				return true
				
			end
			
		end
		
		return false;
		
	end
	
	return true
	
end

GM.MastermindMat = Material( "vgui/white" );

function GM:RenderNPCTargets()
	
	if( self.Mastermind ) then
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v:NPCTargetPos() != Vector() ) then
				
				local col = v:NPCMastermindColor();
				
				cam.Start3D2D( v:NPCTargetPos() + Vector( 0, 0, 1 ), Angle(), 1 );
					
					surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
					surface.SetDrawColor( col.x, col.y, col.z, 255 );
					surface.DrawTexturedRect( -10, -10, 20, 20 );
					
				cam.End3D2D();
				
				render.DrawLine( v:GetPos(), v:NPCTargetPos(), Color( col.x, col.y, col.z, 255 ), false );
				
			end
			
		end
		
		if( self.MastermindSelected and self.MastermindSelected:IsValid() ) then
			
			local trace = { };
			trace.start = LocalPlayer():GetShootPos();
			trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
			trace.filter = LocalPlayer();
			
			if( self.MastermindMouse and self.MastermindMouse == 109 ) then
				
				trace.endpos = LocalPlayer():GetPos();
				
			end
			
			local tr = util.TraceLine( trace );
			
			cam.Start3D2D( tr.HitPos + Vector( 0, 0, 1 ), Angle(), 1 );
				
				surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
				surface.SetDrawColor( 200, 200, 200, 255 );
				surface.DrawTexturedRect( -10, -10, 20, 20 );
				
			cam.End3D2D();
			
			render.DrawLine( self.MastermindSelected:GetPos(), tr.HitPos, Color( 200, 200, 200, 255 ), false );
			
		end
		
	end
	
end

function GM:PostDrawOpaqueRenderables()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() and v:GetActiveWeapon() != NULL ) then
			
			if( v:GetActiveWeapon().PostDrawOpaqueRenderables ) then
				
				v:GetActiveWeapon():PostDrawOpaqueRenderables();
				
			end
			
		end
		
	end
	
	self:RenderNPCTargets();
	
	if( self.MapPostDrawOpaqueRenderables ) then
		
		self:MapPostDrawOpaqueRenderables();
		
	end
	
	self:DrugPostDrawOpaqueRenderables();
	
end

function GM:GetCursorNPC( max )
	
	local dist = max;
	local ent = nil;
	
	for _, v in pairs( ents.GetNPCs() ) do
		
		local pos = v:GetPos():ToScreen();
		local x, y = gui.MousePos();
		
		local d = math.sqrt( ( pos.x - x ) ^ 2 + ( pos.y - y ) ^ 2 );
		
		if( d < dist ) then
			
			ent = v;
			dist = d;
			
		end
		
	end
	
	return ent;
	
end

function GM:GetCursorEnt()
	
	local trace = { };
	trace.start = LocalPlayer():GetShootPos();
	trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
	trace.filter = LocalPlayer();
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() ) then
		
		return tr.Entity;
		
	end
	
end

function GM:PreDrawHalos()
	
	if( self.Mastermind ) then
		
		local hEnt = nil;
		
		if( vgui.IsHoveringWorld() and !self.MastermindSelected ) then
			
			hEnt = self:GetCursorNPC( 200 );
			
		end
		
		local tab = { };
		
		if( hEnt ) then
			
			if( hEnt.GetActiveWeapon and hEnt:GetActiveWeapon() and hEnt:GetActiveWeapon():IsValid() ) then
				
				halo.Add( { hEnt, hEnt:GetActiveWeapon() }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			else
				
				halo.Add( { hEnt }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			end
			
		end
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
				if( v.GetActiveWeapon and v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() ) then
					
					table.insert( tab[v:NPCMastermindColor()], v:GetActiveWeapon() );
					
				end
				
			end
			
		end
		
		for _, v in pairs( ents.FindByClass( "prop_vehicle_apc" ) ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
			end
			
		end
		
		for k, v in pairs( tab ) do
			
			halo.Add( { v }, Color( k.x, k.y, k.z, 255 ), 2, 2, 1, true, true );
			
		end
		
	end
	
	if( GAMEMODE.SeeAll ) then
		
		local tab = { };
		
		for _, v in pairs( ents.GetAll() ) do
			
	
			
		end
		
		halo.Add( tab, Color( 255, 0, 255, 255 ), 1, 1, 1, true, false );
		
	end
	
end

function GM:RenderScreenspaceEffects()
	
	self.BaseClass:RenderScreenspaceEffects();
	
	if( self.FlashbangStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashbangStart;
		local a = 0;
		
		if( t < 5 ) then
			
			a = 1;
			
		elseif( t < 7 ) then
			
			a = 1 - ( t - 5 ) / 2;
			
		end
		
		local tab = { };


		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= a;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end

	if( LocalPlayer():Downed() ) then
		
		DrawMaterialOverlay( "effects/tele_refract", 0 )
				DrawMaterialOverlay( "life_materials/overlays/cinematics/lifemod_cinematicoverlay2.png", 0 )
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0.1;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= 0;
		tab[ "$pp_colour_contrast" ] 	= 0.75;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
	
	end
 
		if LocalPlayer():HasOddity("statusstunned") then
		
		DrawMaterialOverlay( "effects/tele_refract", 0 )

		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= 0;
		tab[ "$pp_colour_contrast" ] 	= 0.75;
		tab[ "$pp_colour_colour" ] 		= 0.75;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
	
	end


	 end


function GM:PlayerStartVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerStartVoice( ply );
		
	end
	
end

function GM:PlayerEndVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerEndVoice( ply );
		
	end
	
end