function GM:GetHL2CamPos()
	return {Vector(-4946, -11963, 77), Angle(-7, -50, 0)}
end

function GM:GetCombineCratePos()
	return {Vector(9553, 14657, 1297), Angle(0, 90, 0)}
end

GM.EnableAreaportals = true

GM.CurrentLocation = LOCATION_CITY

GM.EntPositionsToRemove = {
	Vector(-10968, 8568, 1202),
	Vector(-10968, 8536, 1202)
}

GM.Stoves = {
	Vector(-3736, 2469, 48),
	Vector(-10008, 7386, 1059),
	Vector(-10552, -12827, 1072),
	Vector(-8083, -11559, 1072),
	Vector(-14592, -9587, 40),
	Vector(13434, 5610, 1760),
	Vector(9553, 14643, 1314),
}

GM.spawnpoints = {
	{Vector(11329, 10041, 393), Angle(0, -84, 0)}, -- Cave entrance
	{Vector(13858, 3714, -447), Angle(0, 147, 0)}, -- Mining camp
	{Vector(-13559, -7436, 1), Angle(0, -46, 0)}, -- Lakeside house
	{Vector(-10457, -14287, 1025), Angle(0, 62, 0)}, -- Cliffside camp
	{Vector(818, -11586, 1024), Angle(0, 79, 0)}, -- Cliffside tunnel
	{Vector(818, -11586, 1024), Angle(0, 79, 0)}, -- Bunker entrance
	{Vector(-8138, 7905, 1), Angle(0, 58, 0)}, -- Bunker side entrance
	{Vector(-9209, 13776, 1025), Angle(0, -142, 0)}, -- Claustrophobia entrance
	{Vector(-13795, 11640, 1), Angle(0, 19, 0)}, -- Collapsed tunnel
	{Vector(-5615, 10652, 1), Angle(0, -118, 0)}, -- Bridge
	{Vector(2670, 15273, 945), Angle(0, -54, 0)}, -- Roadblock overlook
	{Vector(14380, 10433, -1286), Angle(0, 158, 0)}, -- Ruins
	{Vector(11679, 2086, 1410), Angle(0, 178, 0)}, -- Cliff mansion
	{Vector(9452, -9452, 884), Angle(0, -34, 0)}, -- Dam bridge
	{Vector(-2853, 6280, 1075), Angle(0, -116, 0)}, -- Excavation entrance
	{Vector(-2646, 479, 11), Angle(0, 136, 0)}, -- Hostel
	{Vector(-903, -489, 257), Angle(0, 73, 0)}, -- Factory entrance
	{Vector(1726, -1918, 1024), Angle(0, 110, 0)}, -- Factory overlook
	{Vector(-8245, -3477, 1035), Angle(0, 27, 0)}, -- Canyon path
}

GM.CombineSpawnpoints = {
	Vector(14607, -14676, 28),
	Vector(14353, -14677, 10),
	Vector(14480, -14503, 22),
	Vector(14586, -14546, 32),
	Vector(14657, -14444, 43),
	Vector(14687, -14612, 39),
	Vector(14390, -14580, 13)
}

GM.containerData = {
	{Vector( 481, -506, -35 ), Angle( 11, 157, 0 ), "ineucliffside", CONTAINER_OPEN},
	{Vector( 505, -404, -83 ), Angle(0, 180, 0), "ineucombine", CONTAINER_PASSWORD, "912"},
	{Vector(15204, 5397, -427), Angle(0, -179, 0), "ineucaves", CONTAINER_OPEN},
	{Vector(1044, 801, 461), Angle(0, 180, 0), "ineufactory", CONTAINER_OPEN},
	{Vector(-3400, 1388, -107), Angle(0, -90, 0), "ineuhostel", CONTAINER_OPEN},
	{Vector(-11107, 7317, 1037), Angle(0, -0, 0), "ineubunker", CONTAINER_OPEN},
	{Vector(10965, 15310, 1517), Angle(0, -0, 0), "ineuadmin", CONTAINER_ADMIN},
}