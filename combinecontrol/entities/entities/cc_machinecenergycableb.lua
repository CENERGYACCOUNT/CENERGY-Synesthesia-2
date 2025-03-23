AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Machines"

ENT.PrintName		= "Cenergy Cable B";
ENT.Author			= "Matt";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;


function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	

	self:NetworkVar( "Bool", 1, "Broken" );

	self:NetworkVar( "Bool", 2, "Energized" );




	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );

	self:SetBroken( false );

	self:SetEnergized( false);


	self:SetModel( "models/props_industrial/steelshelf02_packed04.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	

	
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
	if( self:GetBroken() ) then return end
		
		if( !self.NextCheck ) then self.NextCheck = CurTime() end
		
		if( CurTime() >= self.NextCheck ) then
			
	local snd = Sound( "ambient/energy/zap1.wav" );
					self.NextCheck = CurTime() + SoundDuration(snd) + 10
if ( math.random(1, 5000) == 2 ) then
	self:SetBroken( true);
end
	self:SetEnergized( false);

for _, v in pairs( ents.FindByClass( "cc_machinecenergycablea" ) ) do


						local dist = 50;
					
						if( self:GetPos():Distance( v:GetPos() ) < dist ) then
if( v:GetEnergized( true)) then

	self:SetEnergized( true); end 
else  end  end  







end end

