AddCSLuaFile();

--[[
/* Copyright (C) Particularly Me - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited, including distribution
 * Proprietary and confidential
 * Written by Rune Knight, rune4533@hotmail.com, August 2016
 */
 --]]
 
ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Citizen Poster Disp.";
ENT.Author			= "Rune Knight";
ENT.Contact			= "";
ENT.Purpose			= "To get citizens TO STOP ASKING.";
ENT.Instructions	= "";

ENT.Spawnable				= true;
ENT.AdminSpawnable			= true;

ENT.AutomaticFrameAdvance	= true;
function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Initialize()
	
	self:SetModel( "models/props_combine/combine_dispenser.mdl" );
	
	if( SERVER ) then
		
		self:PhysicsInit( SOLID_BBOX );
		self:SetMoveType( MOVETYPE_VPHYSICS );
		self:SetSolid( SOLID_BBOX );
		
		local phys = self:GetPhysicsObject();
		
		if( phys and phys:IsValid() ) then
			
			phys:EnableMotion( false );
			
		end
		
		self:SetUseType( SIMPLE_USE );
		
	end
	
end

function ENT:Use(ply)
	if( SERVER ) then
		
		if( ply:HasCharFlag("V") or ply:HasCharFlag("W") or ply:HasCharFlag("S") ) then
			net.Start( "nCitizenPosterNotCitizenA" );			net.Send( ply );
			return false;
		end
		if( ply:HasAnyCombineFlag() ) then
			net.Start( "nCitizenPosterNotCitizenB" )			net.Send( ply );
			return false;	
		end
		if( ply:CPPosterDate() == "" or util.TimeSinceDate( ply:CPPosterDate() ) > 60 ) then
		
			if( !ply:CanTakeItem( "poster", 5 ) ) then
					
					net.Start( "nCitizenPosterTooHeavy" );
					net.Send( ply );
					return;
				
			end
		
			self:ResetSequence( self:LookupSequence( "dispense_package" ) );

			self:EmitSound( Sound( "Buttons.snd6" ) );

			net.Start( "nCitizenPoster" );
			net.Send( ply );
			
			ply:GiveItem( "poster", 5 );
			
			ply:SetCPPosterDate( os.date( "!%m/%d/%y %H:%M:%S" ) );
			ply:UpdateCharacterField( "CPPosterDate", ply:CPPosterDate() );
		else
				
			self:EmitSound( Sound( "Buttons.snd10" ) );
				
			net.Start( "nCitizenPosterTooEarly" );
			net.Send( ply );
			
		end
		
	end
	
end
function ENT:Think()
	
	self:NextThink( CurTime() );
	return true;
	
end

--[[
	Instructions on how to set this thing up:

	1) sv_sql.lua
	{ "CPPosterDate", "VARCHAR(20)", "" },
	
	Put that in the CharTables.

	2) sv_net.lua
	util.AddNetworkString( "nCitizenPoster" );
	util.AddNetworkString( "nCitizenPosterNotCitizenA" );
	util.AddNetworkString( "nCitizenPosterNotCitizenB" );
	util.AddNetworkString( "nCitizenPosterTooHeavy" );
	util.AddNetworkString( "nCitizenPosterTooEarly" );
	
	Shove that somewhere you think it'll fit.
--]]

if( CLIENT ) then
	
	function nCitizenPoster( len )
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take your posters.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCitizenPoster", nCitizenPoster );
	
	function nCitizenPosterNotCitizenA( len )
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "The poster dispenser isn't giving you posters.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCitizenPosterNotCitizenA", nCitizenPosterNotCitizenA );
	
	function nCitizenPosterNotCitizenB( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a Civil Protection officer, let the citizens put up the posters instead.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCitizenPosterNotCitizenB", nCitizenPosterNotCitizenB );
	
	function nCitizenPosterTooHeavy( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Your inventory is too full to carry the posters.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCitizenPosterTooHeavy", nCitizenPosterTooHeavy );
	
	function nCitizenPosterTooEarly( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "The distribution machine only distributes posters every hour.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCitizenPosterTooEarly", nCitizenPosterTooEarly );
	
end

function ENT:CanPhysgun()
	
	return false;
	
end