ITEM.ID				= "clothesheadgasmask"  -- ID
ITEM.Name			= "Hand of Apexforce Training Trooper Armor"  -- NAME
ITEM.Description	= "Training armor of the children of Apexforce."  -- DESCRIPTION
ITEM.Model			= "models/props_equipment/hardcase_01a.mdl" -- model
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( -50, -50, 22.33 );
ITEM.LookAt 		= Vector( 1.61, 1.61, 4.83 );
ITEM.Weight 		= 2  -- how much it weights
ITEM.UseText		= "Equip"; -- use button text


--- DO NOT CHANGE THOSE
ITEM.Usable			= true;
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
--- DO NOT CHANGE THOSE
------------------------------------------------

if (ply:HasOddity( "wearingheadgear" ) ) then -- a type of a headwear it is
if( CLIENT ) then GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You are already wearing something.", { CB_ALL, CB_IC } ); 	end return true; end 
-- what does it say when you are already wearing the same gear type

-- list of gear types
-- "wearingheadgear" for hats, head stuff
-- "wearingchestgear" for chests, kevlars, suits, clothes
-- "wearinglegsgear" for legs, pants, shoes
-- "wearingarmsgear" for gloves, pads
-- "wearingbackgear" for backpacks, radios, etc
-- "wearingbeltgear" for belt stuff

------------------------------------------------

-- what does it say in chat when you equip it
	if( CLIENT ) then
			GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You put on the armor.", { CB_ALL, CB_IC } );
	else

------------------------------------------------

-- a type of a headwear it is //AGAIN//
	ply:GiveOddity( "wearingheadgear" ); 
				
------------------------------------------------

-- sound on equip
ply:EmitSound( "weapons/tfa/melee1.wav" );

------------------------------------------------

-- ID of equiped item
ply:GiveItem( "clothesheadgasmaske" ); 

------------------------------------------------

-- THE STATS change on EQUIP (There can be multiple of those obviously, just copy and paste it) 

	ply:SetHeatHeadDefense( math.Clamp( ply:HeatHeadDefense() + 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatHeadDefense", tostring( ply:HeatHeadDefense() ), true );

ply:SetSlashHeadDefense( math.Clamp( ply:SlashHeadDefense() + 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashHeadDefense", tostring( ply:SlashHeadDefense() ), true );

ply:SetHeatChestDefense( math.Clamp( ply:HeatChestDefense() + 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatChestDefense", tostring( ply:HeatChestDefense() ), true );

ply:SetSlashChestDefense( math.Clamp( ply:SlashChestDefense() + 95, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashChestDefense", tostring( ply:SlashChestDefense() ), true );

ply:SetHeatArmsDefense( math.Clamp( ply:HeatArmsDefense() + 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatArmsDefense", tostring( ply:HeatArmsDefense() ), true );

ply:SetSlashArmsDefense( math.Clamp( ply:SlashArmsDefense() + 25, -1000, 1000 ) );
ply:UpdateCharacterField( "StatSlashArmsDefense", tostring( ply:SlashArmsDefense() ), true );

ply:SetHeatLegsDefense( math.Clamp( ply:HeatLegsDefense() + 35, -1000, 1000 ) );
ply:UpdateCharacterField( "StatHeatLegsDefense", tostring( ply:HeatLegsDefense() ), true );

-- Blunt Resistance
ply:SetBluntHeadDefense( math.Clamp( ply:BluntHeadDefense() + 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntHeadDefense", tostring( ply:BluntHeadDefense() ), true );

ply:SetBluntChestDefense( math.Clamp( ply:BluntChestDefense() + 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntChestDefense", tostring( ply:BluntChestDefense() ), true );

ply:SetBluntArmsDefense( math.Clamp( ply:BluntArmsDefense() + 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntArmsDefense", tostring( ply:BluntArmsDefense() ), true );

ply:SetBluntLegsDefense( math.Clamp( ply:BluntLegsDefense() + 35, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBluntLegsDefense", tostring( ply:BluntLegsDefense() ), true );

-- Bullet Resistance
ply:SetBulletHeadDefense( math.Clamp( ply:BulletHeadDefense() + 75, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletHeadDefense", tostring( ply:BulletHeadDefense() ), true );

ply:SetBulletChestDefense( math.Clamp( ply:BulletChestDefense() + 85, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletChestDefense", tostring( ply:BulletChestDefense() ), true );

ply:SetBulletArmsDefense( math.Clamp( ply:BulletArmsDefense() + 65, -1000, 1000 ) );
ply:UpdateCharacterField( "StatBulletArmsDefense", tostring( ply:BulletArmsDefense() ), true );

ply:SetBulletLegsDefense( math.Clamp( ply:BulletLegsDefense() + 35, -1000, 1000 ) );
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

end	end