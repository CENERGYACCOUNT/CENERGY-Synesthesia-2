AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";
ENT.Category		= "CENERGY Decals"

ENT.PrintName		= "Filth";
ENT.Author			= "Matt";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= false;
ENT.AdminSpawnable		= false;


function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()

	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
		local snd = Sound( "ambient/energy/zap1.wav" );
	self.NextCheck2 = CurTime() + SoundDuration(snd) + 250
	self:SetModel( "" .. table.Random( { "models/ryu-gi/effect props/blood/blood02-a.mdl", "models/ryu-gi/effect props/blood/blood02-b.mdl", "models/ryu-gi/effect props/blood/blood02-c.mdl", "models/ryu-gi/effect props/blood/blood02-d.mdl", "models/ryu-gi/effect props/blood/blood02-e.mdl", "models/ryu-gi/effect props/blood/blood02-g.mdl", "models/ryu-gi/effect props/blood/blood02-h.mdl", "models/ryu-gi/effect props/blood/blood02-i.mdl", "models/ryu-gi/effect props/blood/blood02-j.mdl", "models/ryu-gi/effect props/blood/blood01-c.mdl", "models/ryu-gi/effect props/blood/blood01-h.mdl", "models/ryu-gi/effect props/blood/blood01-k.mdl" } ) );
self:SetSkin( 7, 7 )
	self:PhysicsInit( SOLID_VPHYSICS );
	local phys = self:GetPhysicsObject();
	
	if( phys and phys:IsValid() ) then
		
		phys:Wake();
		
	end

self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end
	
function DontCollide(self)
self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Think()
	
	if( CLIENT ) then return end
	
		
		if( !self.NextCheck ) then self.NextCheck = CurTime() end
		
		if( CurTime() >= self.NextCheck ) then
			
	local snd = Sound( "ambient/energy/zap1.wav" );
					self.NextCheck = CurTime() + SoundDuration(snd) + 0


for _, v in pairs( ents.FindByClass( "player" ) ) do

if (v:HasOddity ("cleaning")) then

						local dist = 50;
					
						if( self:GetPos():Distance( v:GetPos() ) < dist ) then
  self:EmitSound( Sound( "ambient/water/water_spray1.wav" ) );	
		self:Remove();

else  end  end   end end 

	
		if( !self.NextCheck2 ) then self.NextCheck2 = CurTime() end
		
		if( CurTime() >= self.NextCheck2 ) then
			
	local snd = Sound( "ambient/energy/zap1.wav" );
					self.NextCheck2 = CurTime() + SoundDuration(snd) + 500

	local r = math.random( 1, 2 );

			if( r != 1 ) then

					local r = math.random( 1, 2 );

			if( r != 1 ) then

	local trace = { };
		trace.start = self:GetPos();
		trace.endpos = trace.start 
		trace.filter = self;
		
		local tr = util.TraceLine( trace );
		
		local e = ents.Create( "npc_cenergy_rat" );
		e:SetPos( tr.HitPos + tr.HitNormal * 10 );
		e:SetAngles( Angle() );
		e:Spawn();
		e:Activate();

	
				end 
 end end
end
