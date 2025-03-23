ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Cultist"
ENT.Author 			= "Matt"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "CENERGY NPCs"

ENT.Spawnable				= true;
ENT.AdminSpawnable			= true;

ENT.AutomaticFrameAdvance	= true;
if (CLIENT) then
local Name = "Cultist"
local LangName = "npc_cultist"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end

