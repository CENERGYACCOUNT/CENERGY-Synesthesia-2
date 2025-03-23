function GM:GetHL2CamPos()
	
return { Vector( 3567, -4358, 4228 ), Angle( 38, 112, 0 ) };

	
end

function GM:GetCACamPos()
	
	return Vector( 3567, -4358, 4228 );
	
end


GM.IntroCamData = { };
GM.IntroCamData[1] = { {Vector( 3583, -4368, 4300 ), Vector( 3689, -3726, 4246 ) }, { Angle( 37, 128, 0 ), Angle( 24, -152, 0 ) } }; -- space
GM.IntroCamData[2] = { { Vector( 4724, -5195, 4434 ), Vector( 5456, -5196, 4404 ) }, { Angle( 33, 70, 0 ), Angle( 25, 133, 0 ) } }; --garden
GM.IntroCamData[3] = { {  Vector( 6112, -4977, 4223 ), Vector( 6117, -4381, 4314 ) }, { Angle( 6, 89, 0 ) ,Angle( 89, 89, 0 ) } }; --engines
GM.IntroCamData[4] = { { Vector( 5731, -4963, 4241 ), Vector( 5707, -4724, 4330 ) }, { Angle( 3, 131, 0 ), Angle( 19, 132, 0 ) } }; -- kitchen
GM.IntroCamData[5] = { { Vector( 4138, -3777, 4234 ), Vector( 4644, -3880, 4291 ) }, { Angle( 6, -7, 0 ), Angle( 25, 163, 0 ) } }; -- mechanics
GM.IntroCamData[6] = { { Vector( 4819, -4710, 4079 ), Vector( 4758, -4331, 4083 ) }, { Angle( 4, 114, 0 ), Angle( -2, 109, 0 ) } }; -- underground

GM.EnableAreaportals = true

GM.CurrentLocation = LOCATION_CITY

GM.CombineSpawnpoints = {
	Vector(6275, -4810, 5889)
}


GM.containerData = {
	{Vector(), Angle(), "test1", CONTAINER_OPEN},
	{Vector(), Angle(), "test2", CONTAINER_COMBINE},
	{Vector(), Angle(), "test3", CONTAINER_PASSWORD, "912"}, -- Note, passwords are numeric by default, check cl_container.lua line 320 to change this
	{Vector(), Angle(), "test4", CONTAINER_FLAG, {"A", "O"}}, -- Table is required, even for single values
	{Vector(), Angle(), "test5", CONTAINER_ADMIN}
}

GM.DoorData = {
	{ Vector( 1383, 3520, 367.28100585938 ), DOOR_BUYABLE_ASSIGNABLE, "Apartment C-1-4", 5, "C14" },
};

