#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main()
{
	maps\mp\_load::main();
        
	ambientPlay("ambient_backlot_ext");

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

        teleport_main();
}

teleport_main()
{
        teleport = getEntArray("enter", "targetname");
	
        for(i = 0;i < teleport.size;i++)
	        thread teleport(teleport[i]);
}

teleport(trigger)
{
	target = getEnt(trigger.target, "targetname");

	for(;;)
	{
		trigger waittill("trigger", user);

		user setOrigin(target.origin);
		user setPlayerAngles(target.angles);
	}
}