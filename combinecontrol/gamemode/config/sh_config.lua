-- URLs for web integration

GM.MOTDURL = "";
GM.SteamGroupURL = "SEX";
GM.WebsiteURL = "SEX";
GM.UpdatesURL = "SEX";
GM.BooksURL = "SEX";

-- Security

GM.PrivateMode = false;

GM.PrivateSteamIDs = {
	"STEAM_0:1:47582487",
	"STEAM_0:1:34365300",
	"STEAM_0:1:93799066",
	"STEAM_0:1:67440884",
	"STEAM_0:1:105058407",
	"STEAM_0:0:54597560",
	"STEAM_0:0:44038594",
	"STEAM_0:1:86323341",
	"STEAM_0:0:17359435", -- disseminate
};

GM.TestingClosedMessage = "This server is closed for testing!";

GM.AdminsCanSpawnSENTs = true;

-- Character Creation

GM.QuizEnabled = false;
GM.QuizQuestions = {
	-- Label, { options }, correct option
	{ "1. The farmer went _____ the market.", { "to", "too", "two" }, "to" },
	{ "2. What is 6 * 8?", { "50", "48", "40" }, "48" },
	{ "3. ______ apples are very ripe.", { "They're", "There", "Their" }, "Their" },
	{ "4. ______ is the name of the rebel scientist in Half-Life 2.", { "Kleiner", "", "Barney" }, "Kleiner" },
	{ "5. ______ of people like candy.", { "Allot", "A lot", "Alot" }, "A lot" }
}

GM.IntroCinematicEnabled = false;
GM.IntroCamText = { };
GM.IntroCamText[1] = "Welcome to the Gmod Station. This is a Barotrauma, Station13/14  and Lethal Company themed roleplay server.\n\nIf you were looking for something else, you can disconnect at any time.";
GM.IntroCamText[2] = "This gamemode is all about cooperation. Players must work together, otherwise, certain demise awaits them.\n\n Every player has an unique role assigned, with different responsibilities.";
GM.IntroCamText[3] = "The Station must be maintained. And that is where you step in.\n\nTake a role of an Engineer, a Mechanic, Botanist or the Captain himself if you have the balls, and obviously more.\n\n";
GM.IntroCamText[4] = "The Station is not the only thing that must be maintained. \n\nBe sure to keep yourself fed, healthy and sane.";
GM.IntroCamText[5] = "Not everyone are on your side though.\n\nTraitors are randomly assigned over time, their ultimate goal being the destruction of the station.\n\nFind them, and get rid of them before it's too late. Or... become one yourself if you are lucky.";
GM.IntroCamText[6] = "Good luck on The Gmod Station.\n\nAnd be wary, for who knows what kind of cosmic horrors lurks in the shadows.";

GM.IntroCinematicMusic = "";

GM.MinNameLength = 4;
GM.MaxNameLength = 40;

GM.MaxDescLength = 25;

GM.MaxCharacters = 10;

GM.CitizenModels = {
	"models/player/urban.mdl",
	"models/player/urban.mdl"


};

GM.RebelModels = {
	"models/player/group03/male_01.mdl",
	"models/player/group03/male_02.mdl",
	"models/player/group03/male_03.mdl",
	"models/player/group03/male_04.mdl",
	"models/player/group03/male_05.mdl",
	"models/player/group03/male_06.mdl",
	"models/player/group03/male_07.mdl",
	"models/player/group03/male_08.mdl",
	"models/player/group03/male_09.mdl",
	"models/player/group03/female_01.mdl",
	"models/player/group03/female_02.mdl",
	"models/player/group03/female_03.mdl",
	"models/player/group03/female_04.mdl",
	"models/player/group03/female_05.mdl",
	"models/player/group03/female_06.mdl",
	"models/player/group03m/male_01.mdl",
	"models/player/group03m/male_02.mdl",
	"models/player/group03m/male_03.mdl",
	"models/player/group03m/male_04.mdl",
	"models/player/group03m/male_05.mdl",
	"models/player/group03m/male_06.mdl",
	"models/player/group03m/male_07.mdl",
	"models/player/group03m/male_08.mdl",
	"models/player/group03m/male_09.mdl",
	"models/player/group03m/female_01.mdl",
	"models/player/group03m/female_02.mdl",
	"models/player/group03m/female_03.mdl",
	"models/player/group03m/female_04.mdl",
	"models/player/group03m/female_05.mdl",
	"models/player/group03m/female_06.mdl"
};

-- General Gameplay

GM.UseHunger = true;

GM.FistsHaveEffectOnPlayers = true;
GM.DoorRammingEnabled = false;

GM.MaxLoan = 500;

GM.StatsAvailable = 25;

GM.UntieOnDeath = true;

GM.OffDutyCombineCanBuyDoors = true;

GM.NotifyWhenPlayersJoin = true;

-- AFK Autokicker

GM.AFKKickerEnabled = false;
GM.AFKPercentage = 0.80;
GM.AFKTime = 600;

-- Cross-Server Transfers

IP_GENERAL = "1.2.3.4";
PORT_CITY = 27018;
PORT_CANAL = 27030;
PORT_OUTLANDS = 27017;
PORT_COAST = 27018;

TRANSITPORT_CITY_GATE = 2;
TRANSITPORT_CITY_SEWER = 3;
TRANSITPORT_CITY_COMBINE = 4;
TRANSITPORT_CAVES_ENTRY = 5;
TRANSITPORT_COAST_ENTRY = 6;

-- Donations

GM.BronzeDonorAmount = 15;
GM.SilverDonorAmount = 25;
GM.GoldDonorAmount = 45;

-- Resources

GM.WorkshopMaps = { };



GM.VoicesEnabled = false;
GM.VoiceDelay = 3;

GM.Voices = { };
GM.Voices[GENDER_MALE] = { -- For ALL male citizens.
	{ "Hi!", "vo/npc/male01/squad_away01.wav" },
	{ "Nice!", "vo/npc/male01/nice.wav" },
	{ "I can't remember the last time I had a shower.", "vo/npc/male01/question19.wav" },
	{ "Civil Protecion!", "vo/npc/male01/civilprotection01.wav" },
	{ "CPs!", "vo/npc/male01/cps01.wav" },
	{ "Shouldn't we uhh be doing something?", "vo/npc/male01/doingsomething.wav" },
	{ "Excuse me.", "vo/npc/male01/excuseme02.wav" },
	{ "Fantastic!", "vo/npc/male01/fantastic01.wav" },
	{ "Get the hell out of here!", "vo/npc/male01/gethellout.wav" },
	{ "Good god!", "vo/npc/male01/goodgod.wav" },
	{ "To think, all I used to want to do is sell insurance.", "vo/npc/male01/question02.wav" },
	{ "Sometimes...I dream about cheese.", "vo/npc/male01/question06.wav" },
	{ "You smell that? It's freedom!", "vo/npc/male01/question07.wav" },
	{ "You feel it? I feel it.", "vo/npc/male01/question17.wav" },
	{ "This is bullshit!", "vo/npc/male01/question26.wav" },
	{ "God I'm hungry.", "vo/npc/male01/question28.wav" },
	{ "Sorry.", "vo/npc/male01/sorry01.wav" },
	
};
GM.Voices[GENDER_FEMALE] = { -- For ALL female citizens.
	{ "Hi.", "vo/npc/female01/hi01.wav" },
	{ "Nice.", "vo/npc/female01/nice01.wav" },
	{ "I can't remember the last time I had a shower!", "vo/npc/female01/question19.wav" },
	{ "Civil Protection!", "vo/npc/female01/civilprotection01.wav" },
	{ "CPs!", "vo/npc/female01/cps01.wav" },
	{ "Shouldn't we be doing something?", "vo/npc/female01/doingsomething.wav" },
	{ "Excuse me.", "vo/npc/female01/excuseme02.wav" },
	{ "Fantastic!", "vo/npc/female01/fantastic02.wav" },
	{ "Get the hell out of here!", "vo/npc/female01/gethellout.wav" },
	{ "Good god!", "vo/npc/female01/goodgod.wav" },
	{ "I don't dream anymore.", "vo/npc/female/question03.wav" },
	{ "I could eat a horse. Hooves and all.", "vo/npc/female01/question09.wav" },
	{ "They're never gonna make a stalker out of me!", "vo/npc/female01/question15.wav" },
	{ "Finally! Change is in the air!", "vo/npc/female01/question16.wav" },
	{ "Someday...this'll all be a bad memory", "vo/npc/female01/question20.wav" },
	{ "I can't get this tune out of my head! *whistles*", "vo/npc/female01/question23.wav" },
	{ "Sorry.", "vo/npc/female01/sorry01.wav" },
};
GM.Voices[GENDER_CP] = { -- For ALL civil protection.
	{ "Affirmative.", "npc/metropolice/vo/affirmative.wav" },
	{ "Search.", "npc/metropolice/vo/search.wav" },
	{ "All units at location, respond. Code 3.", "npc/metropolice/vo/allunitsrespondcode3.wav" },
	{ "Anyone pick up that 647e reading?", "npc/metropolice/vo/anyonepickup647e.wav" },
	{ "Check for miscount.", "npc/metropolice/vo/checkformiscount.wav" },
	{ "*chuckle*", "npc/metropolice/vo/chuckle.wav" },
	{ "Citizen.", "npc/metropolice/vo/citizen.wav" },
	{ "Clear. No 647, no 10-107.", "npc/metropolice/vo/clearno647no10-107.wav" },
	{ "Copy.", "npc/metropolice/vo/copy.wav" },
	{ "Don't move.", "npc/metropolice/vo/dontmove.wav" },
	{ "Malcompliant 10-107 at my 10-20, preparing to prosecute.", "npc/metropolice/vo/malcompliant10107my1020.wav" },
	{ "Officer down! I am 10-99! Repeat, I am 10-99", "npc/metropolice/vo/officerdowniam10-99.wav" },
	{ "Officer under fire, taking cover.", "npc/metropolice/vo/officerunderfiretakingcover.wav" },
	{ "Ready to prosecute malcompliant citizen, final warning issued.", "npc/metropolice/vo/readytoprosecutefinalwarning.wav" },
	{ "Searching for suspect. No status.", "npc/metropolice/vo/searchingforsuspect.wav" },
	{ "Shots fired, hostile malignants here.", "npc/metropolice/vo/shotsfiredhostilemalignants.wav" },
	{ "Suspect location unknown.", "npc/metropolice/vo/suspectlocationunknown.wav" },
	{ "Sweeping for suspect.", "npc/metropolice/vo/sweepingforsuspect.wav" },
	{ "10-8, standing by.", "npc/metropolice/vo/ten8standingby.wav" },
	{ "Unit is on duty, 10-8.", "npc/metropolice/vo/unitisonduty10-8.wav" },
	{ "Get Down", "npc/metropolice/vo/getdown.wav" },
	{ "Anti-Citizen", "npc/metropolice/vo/anticitizen.wav" },
	{ "Amputate", "npc/metropolice/vo/amputate.wav" },
	{ "Cover Me", "npc/metropolice/vo/covermegoingin.wav" },
	{ "Isolate", "npc/metropolice/hiding05.wav" },
	{ "Shit", "npc/metropolice/vo/shit.wav" },
	{ "Apply", "npc/metropolice/vo/apply.wav" },
};
GM.Voices[GENDER_VORT] = { -- For ALL vortiguants.
	{ "As you wish.", "vo/npc/vortigaunt/asyouwish.wav" },
	{ "For freedom!", "vo/npc/vortigaunt/forfreedom.wav" },
	{ "There is no distance between us. No false veils of time or space may intervene.", "vo/npc/vortigaunt/vmono_04.wav" },
	{ "Unity of purpose, the shattering of common shackles, a single road we tread.", "vo/npc/vortigaunt/vmono_10.wav" },
	{ "Ah'gar.", "vo/npc/vortigaunt/vortigese02.wav" },
	{ "Cha!", "vo/npc/vortigaunt/vortigese03.wav" },
	{ "Lang!", "vo/npc/vortigaunt/vortigese05.wav" },
	{ "Ga La'Lung!", "vo/npc/vortigaunt/vortigese09.wav" },
	{ "Chur! Ga'Ling Chur! Ala'Gung!", "vo/npc/vortigaunt/vortigese11.wav" },
	{ "Chur! Lang Gong! Shellel Gur!", "vo/npc/vortigaunt/vortigese12.wav" },
	{ "We have lost all dear to us.", "vo/npc/vortigaunt/vques01.wav" },
	{ "The Combine will pay in time for their depravity!", "vo/npc/vortigaunt/vques02.wav" },
	{ "Our life is worthless. Unless spent on freedom.", "vo/npc/vortigaunt/worthless.wav" },
};

GM.Voices[GENDER_ZOMBINE] = {
	{ "Biotics Overrun.", "npc/zombine/zombine_alert1.wav" },
	{ "Infestation.", "npc/zombine/zombine_alert2.wav" },
	{ "NO!", "npc/zombine/zombine_alert3.wav" },
	{ "Target.", "npc/zombine/zombine_alert4.wav" },
	{ "Contact.", "npc/zombine/zombine_alert5.wav" },
	{ "Scream.", "npc/zombine/zombine_alert6.wav" },
	{ "Scream.", "npc/zombine/zombine_charge1.wav" },
	{ "Angry Scream.", "npc/zombine/zombine_charge2.wav" }, 
	{ "Necrotics Inbound.", "npc/zombine/zombine_alert7.wav" },
	{ "Parasites.", "npc/zombine/zombine_idle1.wav" },
	{ "Biotics Overrun.", "npc/zombine/zombine_idle2.wav" },
	{ "Biotics in the perimeter.", "npc/zombine/zombine_idle3.wav" },
	{ "Sector is not secure.", "npc/zombine/zombine_idle4.wav" },
}
GM.CombineDeathLineEnabled = false;
GM.CombineDeathLine = "Dispatch: $COMBINENAME's vitals have ceased. Remaining units contain.";

-- Sandbox

GM.PropBlacklist = {
	-- Main
	"models/props_junk/propanecanister001a.mdl",
	"models/props_junk/propane_tank001a.mdl",
	"models/props_junk/gascan001a.mdl",
	"models/props_c17/oildrum001_explosive.mdl",
	-- Garry's Mod
	"models/props_phx2/garbage_metalcan001a.mdl",
	"models/dav0r/hoverball.mdl",
	"models/dav0r/thruster.mdl",
	"models/nova/w_headcrab.mdl",
	"models/nova/w_headgear.mdl",
	"models/props_phx2/garbage_metalcan001a.mdl",
	-- Garry's Mod*
	"*models/balloons/",
	"*models/dav0r/tnt/",
	"*models/dynamite/",
	"*models/hunter/",
	"*models/maxofs2d/",
	"*models/mechanics/",
	"*models/nateswheel/",
	"*models/phx/",
	"*models/props_phx/",
	"*models/phxtended/",
	"*models/player/",
	"*models/squad/sf_tubes/",
	"*models/thrusters/",
	"*models/weapons/",
	"*models/xeon133/",
	"*models/xqm/",
	-- Half life 2
	"models/extras/info_speech.mdl",
	"models/cranes/crane_frame.mdl",
	"models/props_c17/metalladder003.mdl",
	"models/props_c17/furniturearmchair001a.mdl",
	"models/props_c17/furniturechair001a.mdl",
	"models/props_citizen_tech/windmill_blade002a.mdl",
	"models/props_citizen_tech/windmill_blade004a.mdl",
	"models/props_canal/canal_bridge01.mdl",
	"models/props_canal/canal_bridge02.mdl",
	"models/props_canal/canal_bridge03a.mdl",
	"models/props_combine/combineinnerwall001c.mdl",
	"models/props_combine/combineinnerwallcluster1024_001a.mdl",
	"models/props_combine/combineinnerwallcluster1024_002a.mdl",
	"models/props_combine/combineinnerwallcluster1024_003a.mdl",
	"models/props_combine/combinethumper001a.mdl",
	"models/props_combine/combinethumper002.mdl",
	"models/props_combine/combinetrain01a.mdl",
	"models/props_combine/weaponstripper.mdl",
	"models/props_combine/health_charger001.mdl",
	"models/props_combine/suit_charger001.mdl",
	"models/props_combine/combine_bunker01.mdl",
	"models/props_combine/combine_tptimer.mdl",
	"models/props_combine/breen_tube.mdl",
	"models/props_combine/prison01c.mdl",
	"models/props_combine/prison01b.mdl",
	"models/props_combine/prison01.mdl",
	"models/props_lab/teleplatform.mdl",
	"models/props_lab/generator.mdl",
	"models/props_trainstation/train001.mdl",
	"models/props_trainstation/train002.mdl",
	"models/props_trainstation/train003.mdl",
	"models/props_trainstation/train004.mdl",
	"models/props_trainstation/train005.mdl",
	"models/props_trainstation/trainstation_clock001.mdl",
	"models/props_vehicles/tanker001a.mdl",
	"models/props_vehicles/apc001.mdl",
	"models/props_vehicles/trailer001a.mdl",
	"models/props_wasteland/antlionhill.mdl",
	"models/props_wasteland/coolingtank01.mdl",
	"models/props_wasteland/coolingtank02.mdl",
	"models/props_wasteland/cranemagnet01a.mdl",
	"models/props_wasteland/depot.mdl",
	"models/props_wasteland/medbridge_base01.mdl",
	"models/props_wasteland/rockcliff01b.mdl",
	"models/props_wasteland/rockcliff01c.mdl",
	"models/props_wasteland/rockcliff01e.mdl",
	"models/props_wasteland/rockcliff01f.mdl",
	"models/props_wasteland/rockcliff01g.mdl",
	"models/props_wasteland/rockcliff01j.mdl",
	"models/props_wasteland/rockcliff05a.mdl",
	"models/props_wasteland/rockcliff05b.mdl",
	"models/props_wasteland/rockcliff05e.mdl",
	"models/props_wasteland/rockcliff05f.mdl",
	"models/props_wasteland/rockcliff06d.mdl",
	"models/props_wasteland/rockcliff06i.mdl",
	"models/props_wasteland/rockcliff06i.mdl",
	"models/props_wasteland/rockcliff_cluster01b.mdl",
	"models/props_wasteland/rockcliff_cluster02a.mdl",
	"models/props_wasteland/rockcliff_cluster02b.mdl",
	"models/props_wasteland/rockcliff_cluster02c.mdl",
	"models/props_wasteland/rockcliff_cluster03a.mdl",
	"models/props_wasteland/rockcliff_cluster03b.mdl",
	"models/props_wasteland/rockcliff_cluster03c.mdl",
	"models/props_wasteland/rockgranite01a.mdl",
	"models/props_wasteland/rockgranite01b.mdl",
	"models/props_wasteland/rockgranite01c.mdl",
	"models/props_wasteland/rockgranite02a.mdl",
	"models/props_wasteland/rockgranite04a.mdl",
	"models/props_wasteland/rockgranite04b.mdl",
	"models/props_wasteland/rockgranite04c.mdl",
	-- Half-Life 2*
	"*models/combine_room/",
	"*models/shadertest/",
	"*models/tools/",
	"*models/weapons/",
	"*models/zombie/",
	"*models/props_foliage/",
	"*models/props_rooftop/",
	"*models/props_skybox/",
	"*models/effects/",
	"*models/perftest/",
	"*models/props_animated_breakable/",
	"*models/props_buildings/",
	-- HL2: Episode Two
	"models/mini_borealis/mini_borealis.mdl"
};

GM.PropWhitelist = {
	"models/props_c17/furniturestove001a.mdl",
}

GM.ToolTrustBasic = {
	"weld",
	"nocollide",
	"remover",
	"camera",
	"colour",
	"material",
	"rope",
	"winch",
	"ballsocket"
};

GM.ToolTrustBlacklist = {
	-- The ones with "--" are the ones that ATT can use.
	-- "axis",
	-- "ballsocket",
	"-- elastic",
	-- "hydraulic",
	"metor",
	"muscle",
	-- "precision",
	"pulley",
	-- "slider",
	-- "winch",
	"balloon",
	-- "button",
	"door",
	"dynamite",
	"emitter",
	"hoverball",
	"ladder",
	"lamp",
	-- "light",
	-- "nocollideworld",
	"physprop",
	-- "stacker",
	"thruster",
	"weight",
	"wheel",
	"eyeposer",
	"faceposer",
	"finger",
	"inflator",
	-- "camera",
	-- "colour",
	-- "material",
	"trails",
	"rb655_easy_bodygroup",
	"item_ammo_crate",
	"prop_door",
	"env_headcrabcanister",
	"headcrabcanister",
	"item_item_crate",
	"prop_npc_crate",
	"prop_thumper",
	"trigger",
	"npctool_controller",
	"npctool_follower",
	"npctool_health",
	"npctool_notarget",
	"npctool_proficiency",
	"npctool_relationships",
	"npctool_spawner",
	"npctool_viewcam",
	"permaprops",
	-- "streamradio",
	-- "streamradio_color",
	"creator",
	"duplicator"
};

