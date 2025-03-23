ITEM.ID				= "clothesheadgasmaske"  -- ID
ITEM.Name			= "Hand of Apexforce Training Trooper Armor - Equipped"  -- NAME
ITEM.Description	= "Training armor of the children of Apexforce."  -- DESCRIPTION
ITEM.Model			= "models/props_equipment/hardcase_01a.mdl" -- model
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( -50, -50, 22.33 );
ITEM.LookAt 		= Vector( 1.61, 1.61, 4.83 );
ITEM.Weight 		= 2  -- how much it weights
ITEM.UseText		= "Unequip"; -- use button text

--- DO NOT CHANGE THOSE
ITEM.Droppable		= false;
ITEM.Throwable		= false;
ITEM.Usable			= true;
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
--- DO NOT CHANGE THOSE


-- what does it say in chat when you equip it
if( CLIENT ) then GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You remove your armor.", { CB_ALL, CB_IC } );	else
------------------------------------------------


-- sound on equip
ply:EmitSound( "weapons/tfa/melee1.wav" ); 
------------------------------------------------


-- a type of a headwear it is

ply:RemoveOddity( ply:GetOddityItem( "wearingheadgear" ) ); 

-- list of gear types
-- "wearingheadgear" for hats, head stuff
-- "wearingchestgear" for chests, kevlars, suits, clothes
-- "wearinglegsgear" for legs, pants, shoes
-- "wearingarmsgear" for gloves, pads
-- "wearingbackgear" for backpacks, radios, etc
-- "wearingbeltgear" for belt stuff
------------------------------------------------

-- ID of unequiped item
ply:GiveItem( "clothesheadgasmask" );

------------------------------------------------



-- THE STATS change on UNEQUIP (There can be multiple of those obviously, just copy and paste it) 

ply:SetHeatHeadDefense( math.Clamp( ply:HeatHeadDefense() - 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatHeadDefense", tostring( ply:HeatHeadDefense() ), true );

ply:SetSlashHeadDefense( math.Clamp( ply:SlashHeadDefense() - 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashHeadDefense", tostring( ply:SlashHeadDefense() ), true );

ply:SetHeatChestDefense( math.Clamp( ply:HeatChestDefense() - 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatChestDefense", tostring( ply:HeatChestDefense() ), true );

ply:SetSlashChestDefense( math.Clamp( ply:SlashChestDefense() - 95, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashChestDefense", tostring( ply:SlashChestDefense() ), true );

ply:SetHeatArmsDefense( math.Clamp( ply:HeatArmsDefense() - 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatArmsDefense", tostring( ply:HeatArmsDefense() ), true );

ply:SetSlashArmsDefense( math.Clamp( ply:SlashArmsDefense() - 25, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashArmsDefense", tostring( ply:SlashArmsDefense() ), true );

ply:SetHeatLegsDefense( math.Clamp( ply:HeatLegsDefense() - 35, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatLegsDefense", tostring( ply:HeatLegsDefense() ), true );

ply:SetBluntHeadDefense( math.Clamp( ply:BluntHeadDefense() - 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntHeadDefense", tostring( ply:BluntHeadDefense() ), true );

ply:SetBluntChestDefense( math.Clamp( ply:BluntChestDefense() - 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntChestDefense", tostring( ply:BluntChestDefense() ), true );

ply:SetBluntArmsDefense( math.Clamp( ply:BluntArmsDefense() - 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntArmsDefense", tostring( ply:BluntArmsDefense() ), true );

ply:SetBluntLegsDefense( math.Clamp( ply:BluntLegsDefense() - 35, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntLegsDefense", tostring( ply:BluntLegsDefense() ), true );

-- Bullet Resistance
ply:SetBulletHeadDefense( math.Clamp( ply:BulletHeadDefense() - 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletHeadDefense", tostring( ply:BulletHeadDefense() ), true );

ply:SetBulletChestDefense( math.Clamp( ply:BulletChestDefense() - 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletChestDefense", tostring( ply:BulletChestDefense() ), true );

ply:SetBulletArmsDefense( math.Clamp( ply:BulletArmsDefense() - 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletArmsDefense", tostring( ply:BulletArmsDefense() ), true );

ply:SetBulletLegsDefense( math.Clamp( ply:BulletLegsDefense() - 35, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletLegsDefense", tostring( ply:BulletLegsDefense() ), true );

--  list of stats
--  "SpeedBuff",
--	"MeleeBuff",
--	"GunsBuff",
--	"MedicineBuff",
--	"CookingBuff",
--	"CraftingBuff",
--	"BotanismBuff",
--	"MechanicsBuff",
--	"ElectronicsBuff",
--	"BluntHeadDefense",
--	"BluntChestDefense",
--	"BluntArmsDefense",
--	"BluntLegsDefense",
--	"SlashHeadDefense",
--	"SlashChestDefense",
--	"SlashArmsDefense",
--	"SlashLegsDefense",
--  "BulletHeadDefense",
--  "BulletChestDefense",
--  "BulletArmsDefense",
--  "BulletLegsDefense",
--  "AcidDefense",
--  "HeatDefense",
--  "ShockDefense",
--  "CorruptionDefense"

-- model changes

end end


-- materials (do not touch unless you wanna change textures)
ITEM.ProcessEntity = function( self, ent )
ent:SetMaterial( "effects/xen_teleporter_screen" );
end
ITEM.IconMaterial = "effects/xen_teleporter_screen";
------------------------------------------------